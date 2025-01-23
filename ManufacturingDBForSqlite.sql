-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Create the tables
CREATE TABLE Address (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    country TEXT NOT NULL,
    state TEXT,
    city TEXT NOT NULL,
    road TEXT,
    zip_code TEXT
);

CREATE TABLE Manufacturer (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    website TEXT,
    email TEXT,
    tel TEXT,
    address_id INTEGER,
    FOREIGN KEY (address_id) REFERENCES Address(id)
);

CREATE TABLE Model (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT,
    color TEXT,
    year INTEGER,
    manu_id INTEGER,
    FOREIGN KEY (manu_id) REFERENCES Manufacturer(id)
);

CREATE TABLE Part (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT,
    doc_link TEXT
);

CREATE TABLE Supplier (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    website TEXT,
    email TEXT,
    tel TEXT,
    address_id INTEGER,
    FOREIGN KEY (address_id) REFERENCES Address(id)
);

CREATE TABLE PartOfModel (
    model_id INTEGER,
    part_id INTEGER,
    PRIMARY KEY (model_id, part_id),
    FOREIGN KEY (model_id) REFERENCES Model(id),
    FOREIGN KEY (part_id) REFERENCES Part(id)
);

CREATE TABLE PartMadeBy (
    sup_id INTEGER,
    part_id INTEGER,
    PRIMARY KEY (sup_id, part_id),
    FOREIGN KEY (sup_id) REFERENCES Supplier(id),
    FOREIGN KEY (part_id) REFERENCES Part(id)
);


-- Insert into Address
INSERT INTO Address (country, state, city, road, zip_code) VALUES 
('USA', 'California', 'San Francisco', 'Market Street', '94103'),
('Brazil', 'São Paulo', 'São Paulo', 'Avenida Paulista', '01311-200'),
('USA', 'Texas', 'Austin', 'Congress Avenue', '73301'),
('Brazil', 'Rio de Janeiro', 'Rio de Janeiro', 'Rua Nascimento Silva', '22421-000');

-- Insert into Manufacturer
INSERT INTO Manufacturer (name, website, email, tel, address_id) VALUES
('Tornad', 'www.tornad.com', 'contact@tornad.com', '+14155551234', 1),
('Zoom Motors', 'www.zoommotors.com', 'support@zoommotors.com', '+15125559876', 3);

-- Insert into Model
INSERT INTO Model (name, type, color, year, manu_id) VALUES
('Aree', 'SUV', 'Red', 2023, 1),
('Bolt', 'Sedan', 'Blue', 2022, 1),
('ZoomX', 'Convertible', 'Yellow', 2024, 2);

-- Insert into Part
INSERT INTO Part (name, description, category, doc_link) VALUES
('Battery A1', 'High-performance battery', 'Battery', 'www.docs.com/battery_a1'),
('Engine X', 'V8 engine', 'Engine', 'www.docs.com/engine_x'),
('Battery B2', 'Standard battery', 'Battery', 'www.docs.com/battery_b2');

-- Insert into Supplier
INSERT INTO Supplier (name, website, email, tel, address_id) VALUES
('Hamax Power', 'www.hamaxpower.com', 'info@hamax.com', '+551199876543', 2),
('EngineMax', 'www.enginemax.com', 'support@enginemax.com', '+14155556789', 3);

-- Insert into PartOfModel
INSERT INTO PartOfModel (model_id, part_id) VALUES
(1, 1), -- Aree uses Battery A1
(1, 2), -- Aree uses Engine X
(2, 3), -- Bolt uses Battery B2
(3, 1); -- ZoomX uses Battery A1

-- Insert into PartMadeBy
INSERT INTO PartMadeBy (sup_id, part_id) VALUES
(1, 1), -- Hamax Power makes Battery A1
(2, 2), -- EngineMax makes Engine X
(1, 3); -- Hamax Power makes Battery B2
