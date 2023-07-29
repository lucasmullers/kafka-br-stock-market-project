CREATE STREAM br_stock_trades (
    Date VARCHAR,
    Symbol VARCHAR,
    `Adj Close` DOUBLE,
    close DOUBLE,
    High DOUBLE,
    Open DOUBLE,
    Volume INT
) WITH (
    KAFKA_TOPIC='br-stock-trades',
    PARTITIONS=6,
    VALUE_FORMAT='JSON',
    KEY_FORMAT='KAFKA'
);
