#show container 
docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Ports}}" | column -t -s $'\t'

#setup
docker exec -i oracle-db sqlplus / as sysdba < ManufacturingDB.sql


#test query 
docker exec -i oracle-db sqlplus / as sysdba < query_001.sql
docker exec -i oracle-db sqlplus / as sysdba < query_002.sql
docker exec -i oracle-db sqlplus / as sysdba < query_003.sql
