from time import sleep
from utils.kafka_producer import KafkaProducer


if __name__ == "__main__":
    sleep(120)

    kafka_producer = KafkaProducer(config={"bootstrap.servers": "broker:29092"})

    kafka_producer.send_message_to_kafka()
