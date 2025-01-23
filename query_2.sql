---b) แสดงรายชื่อผู้ผลิตชิ้นส่วน (Supplier) ที่อยู่ในประเทศบราซิล ที่ผลิตชิ้นส่วนให้กับรถที่มีชื่อรุ่น (Model) ว่า Aree

SELECT DISTINCT s.name AS Supplier
FROM Supplier s
JOIN PartMadeBy pmb ON s.id = pmb.sup_id
JOIN Part p ON pmb.part_id = p.id
JOIN PartOfModel pom ON p.id = pom.part_id
JOIN Model m ON pom.model_id = m.id
JOIN Address a ON s.address_id = a.id
WHERE m.name = 'Aree' AND a.country = 'Brazil';