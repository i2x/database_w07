-- c) แสดงรายชื่อรุ่นของรถทั้งหมด ที่ใช้แบตเตอรี่ที่ผลิตโดย Hamax Power
--- cat query_003.sql | docker exec -i oracle-db sqlplus / as sysdba

SELECT DISTINCT m.name AS model_name
FROM Model m
JOIN PartOfModel pom ON m.id = pom.model_id
JOIN Part p ON pom.part_id = p.id
JOIN PartMadeBy pm ON p.id = pm.part_id
JOIN Supplier s ON pm.sup_id = s.id
WHERE s.name = 'Hamax Power' AND p.category = 'Battery';
