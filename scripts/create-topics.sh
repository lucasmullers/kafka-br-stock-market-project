echo "Waiting for Kafka to come online..."

sleep 60

cub kafka-ready -b kafka://broker:29092 1 60

echo "Deleting topics to reset messages on startup..."
for topic in brstocktrades transactions; do
  kafka-topics \
    --bootstrap-server kafka://broker:29092 \
    --delete \
    --topic $topic
done

echo "Creating topic..."

for topic in brstocktrades transactions; do
  kafka-topics \
    --bootstrap-server kafka://broker:29092 \
    --topic $topic \
    --replication-factor 3 \
    --partitions 2 \
    --create
    echo "$topic topic created."
done

sleep 30

# echo "Configuring Datagen Connector for stock-trades topic..."
curl -X POST -H "Content-Type: application/json" --data @config/connector_transactions.config http://connect:8083/connectors
