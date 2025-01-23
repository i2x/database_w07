---c) แสดงรายชื่อรุ่นของรถทั้งหมด ที่ใช้แบตเตอรี่ที่ผลิตโดย Hamax Power
SELECT m.name AS Model
FROM Model m
JOIN PartOfModel pom ON m.id = pom.model_id
JOIN Part p ON pom.part_id = p.id
JOIN PartMadeBy pmb ON p.id = pmb.part_id
JOIN Supplier s ON pmb.sup_id = s.id
WHERE s.name = 'Hamax Power' AND p.category = 'Battery';
