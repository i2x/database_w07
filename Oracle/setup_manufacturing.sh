#list
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"


#setup
docker cp ManufacturingDB.sql oracle-db:/tmp/ManufacturingDB.sql
echo EXIT | docker exec -i oracle-db sqlplus / as sysdba @/tmp/ManufacturingDB.sql

#test query 
cat query_001.sql | docker exec -i oracle-db sqlplus / as sysdba
cat query_002.sql | docker exec -i oracle-db sqlplus / as sysdba
cat query_003.sql | docker exec -i oracle-db sqlplus / as sysdba
