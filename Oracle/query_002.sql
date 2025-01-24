-- b) แสดงรายชื่อผู้ผลิตชิ้นส่วน (Supplier) ที่อยู่ในประเทศบราซิล ที่ผลิตชิ้นส่วนให้กับรถที่มีชื่อรุ่น (Model) ว่า Aree

SELECT DISTINCT s.name AS supplier_name
FROM Supplier s
JOIN Address a ON s.address_id = a.id
JOIN PartMadeBy pm ON s.id = pm.sup_id
JOIN Part p ON pm.part_id = p.id
JOIN PartOfModel pom ON p.id = pom.part_id
JOIN Model m ON pom.model_id = m.id
WHERE a.country = 'Brazil' AND m.name = 'Aree';
