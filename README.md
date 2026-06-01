# Change Data Capture (CDC) from MySQL to PostgreSQL using Kafka Connect and Debezium

## Step 1: Connect to VM

```bash
ssh azureuser@SERVER-IP
```

## Step 2: Install Docker

```bash
sudo apt update
sudo apt install -y docker.io docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
newgrp docker
```

## Step 3: Clone Repository

```bash
git clone https://github.com/shubhsalunke/react-node-mysql-crud.git
cd mysql-postgres-cdc

mkdir mysql-init
```

## Step 4: Build and Start Containers

```bash
docker compose up -d --build
```

## Step 5: Verify Kafka Connect

```bash
curl http://localhost:8083/connector-plugins
```

```bash
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @source.json
```

```bash
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @sink.json
```

## Step 6: Verify Connectors

```bash
curl http://localhost:8083/connectors

curl http://localhost:8083/connectors/mysql-source-connector/status

curl http://localhost:8083/connectors/postgres-jdbc-sink/status
```

## Step 7: Verify Initial Data

```bash
docker exec -it postgres-cdc psql -U postgres -d inventory -c "SELECT * FROM customers;"
```

## Step 8: Test INSERT

```bash
docker exec -it mysql-cdc mysql -uroot -proot123 -e "USE inventory; INSERT INTO customers VALUES (1003,'John','Doe','john@example.com');"
```

```bash
docker exec -it postgres-cdc psql -U postgres -d inventory -c "SELECT * FROM customers;"
```

## Step 9: Test UPDATE

```bash
docker exec -it mysql-cdc mysql -uroot -proot123 -e "USE inventory; UPDATE customers SET email='john.new@example.com' WHERE id=1003;"
```

```bash
docker exec -it postgres-cdc psql -U postgres -d inventory -c "SELECT * FROM customers;"
```

## Step 10: Test DELETE

```bash
docker exec -it mysql-cdc mysql -uroot -proot123 -e "USE inventory; DELETE FROM customers WHERE id=1003;"
```

```bash
docker exec -it postgres-cdc psql -U postgres -d inventory -c "SELECT * FROM customers;"
```

## Step 11: Final Verification

```bash
curl http://localhost:8083/connectors

curl http://localhost:8083/connectors/mysql-source-connector/status

curl http://localhost:8083/connectors/postgres-jdbc-sink/status
```

### Expected Result

```text
mysql-source-connector      RUNNING
postgres-jdbc-sink          RUNNING

INSERT  -> Synced
UPDATE  -> Synced
DELETE  -> Synced
```

CDC Pipeline Successfully Working:
**MySQL → Debezium → Kafka Connect → PostgreSQL**.
