-- a) แสดงจํานวนรุ่นของรถทั้งหมด ที่ผู้ผลิตรถยนต์ (Manufacturer) ชื่อ Tornad ผลิต
--- cat query_001.sql | docker exec -i oracle-db sqlplus / as sysdba

SELECT COUNT(*) AS model_count
FROM Model m
JOIN Manufacturer manu ON m.manu_id = manu.id
WHERE manu.name = 'Tornad';
