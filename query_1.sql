--- a) แสดงจํานวนรุ่นของรถทั้งหมด ที่ผู้ผลิตรถยนต์ (Manufacturer) ชื่อ Tornad ผลิต

SELECT COUNT(*) AS NumberOfModels
FROM Model
JOIN Manufacturer ON Model.manu_id = Manufacturer.id
WHERE Manufacturer.name = 'Tornad';
