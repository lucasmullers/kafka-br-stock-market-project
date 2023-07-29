# Create Kafka Topics
```bash
$ kafka-topics --bootstrap-server localhost:9092 --topic poems_1 --create --partitions 1 --replication-factor 1
$ kafka-topics --bootstrap-server localhost:9092 --topic poems_4 --create --partitions 4 --replication-factor 1
```
# Describe Kafka Topics
```bash
kafka-topics --bootstrap-server localhost:9092 --topic poems_4 --describe
kafka-topics --bootstrap-server localhost:9092 --topic poems_1 --describe
``````

# Create Kafka Console Producer with Key and Defined Separator
```bash
kafka-console-producer --bootstrap-server localhost:9092 --topic poems_4 --property "parse.key=true" --property "key.separator=:"
kafka-console-producer --bootstrap-server localhost:9092 --topic poems_1 --property "parse.key=true" --property "key.separator=:"
```

# Listen to Kafka Topics
```bash
kafka-console-consumer --bootstrap-server localhost:9092 --topic poems_4 --from-beginning
kafka-console-consumer --bootstrap-server localhost:9092 --topic poems_1 --from-beginning
```
