echo "Waiting for Kafka to come online..."

cub kafka-ready -b kafka://broker:29092 1 20

echo "Deleting topics to reset messages on startup..."
for topic in br-stock-trades transactions; do
  kafka-topics \
    --bootstrap-server kafka://broker:29092 \
    --delete \
    --topic $topic
done

echo "Creating topic..."

for topic in br-stock-trades transactions; do
  kafka-topics \
    --bootstrap-server kafka://broker:29092 \
    --topic $topic \
    --replication-factor 1 \
    --partitions 6 \
    --create
    echo "$topic topic created."
done

sleep 30

# echo "Configuring Datagen Connector for stock-trades topic..."
curl -X POST -H "Content-Type: application/json" --data @config/connector_transactions.config http://connect:8083/connectors
