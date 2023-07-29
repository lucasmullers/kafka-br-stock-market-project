from json import dumps
from time import sleep
from pandas import read_csv
from confluent_kafka import Producer


class KafkaProducer(Producer):
    def __init__(self, config: dict, path: str = "./data/bovespa-stock-market-kaggle.csv"):
        super().__init__(config)

        self.path = path

    def read_data(self):
        return read_csv(self.path)

    def convert_date_column(self, df):
        df['Date'] = df['Date'].str.extract(r"(\d{4}-\d{2}-\d{2})", expand=False)
        return df

    def sort_dataframe_by_date(self, df):
        return df.sort_values(by=['Date'], ascending=True)

    def send_message_to_kafka(self, topic: str = "br-stock-trades"):
        df = self.read_data()
        df = self.convert_date_column(df)
        df = self.sort_dataframe_by_date(df)

        for row_number in range(df.shape[0]):
            message = df.iloc[row_number, :].to_dict()
            self.produce(topic, dumps(message), key=message["Symbol"])
            self.flush()

            if row_number % 100 == 0:
                print(f"Sending message {row_number} to Kafka")
                sleep(0.5)
