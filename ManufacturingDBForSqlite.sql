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

-- Insert sample data into Address table
INSERT INTO Address (country, state, city, road, zip_code) VALUES
('USA', 'California', 'Los Angeles', '123 Main St', '90001'),
('Brazil', 'São Paulo', 'São Paulo', '456 Paulista Ave', '01310-000'),
('Germany', 'Bavaria', 'Munich', '789 Autobahn St', '80331'),
('Japan', 'Tokyo', 'Tokyo', '101 Ginza St', '104-0061');

-- Insert sample data into Manufacturer table
INSERT INTO Manufacturer (name, website, email, tel, address_id) VALUES
('Tornad', 'www.tornad.com', 'info@tornad.com', '+1-123-456-7890', 1),
('Hamax Power', 'www.hamaxpower.com', 'contact@hamaxpower.com', '+49-89-1234567', 3),
('Aree Motors', 'www.areemotors.com', 'support@areemotors.com', '+55-11-987654321', 2);

-- Insert sample data into Model table
INSERT INTO Model (name, type, color, year, manu_id) VALUES
('Tornad X1', 'Sedan', 'Red', 2022, 1),
('Tornad X2', 'SUV', 'Blue', 2023, 1),
('Aree', 'Hatchback', 'Green', 2021, 3),
('Aree Pro', 'Sedan', 'Black', 2023, 3);

-- Insert sample data into Part table
INSERT INTO Part (name, description, category, doc_link) VALUES
('Battery', 'High-capacity lithium-ion battery', 'Battery', 'www.battery.com/doc'),
('Engine', 'V6 Turbocharged Engine', 'Engine', 'www.engine.com/doc'),
('Tire', 'All-season radial tire', 'Tire', 'www.tire.com/doc'),
('Brake', 'High-performance brake system', 'Brake', 'www.brake.com/doc');

-- Insert sample data into Supplier table
INSERT INTO Supplier (name, website, email, tel, address_id) VALUES
('Hamax Power', 'www.hamaxpower.com', 'sales@hamaxpower.com', '+49-89-7654321', 3),
('Brazil Parts', 'www.brazilparts.com', 'info@brazilparts.com', '+55-11-1234567', 2),
('Global Tires', 'www.globaltires.com', 'contact@globaltires.com', '+1-234-567-8901', 1);

-- Insert sample data into PartOfModel table
INSERT INTO PartOfModel (model_id, part_id) VALUES
(1, 1), -- Tornad X1 uses Battery
(2, 1), -- Tornad X2 uses Battery
(3, 1), -- Aree uses Battery
(4, 1), -- Aree Pro uses Battery
(1, 2), -- Tornad X1 uses Engine
(2, 2), -- Tornad X2 uses Engine
(3, 3), -- Aree uses Tire
(4, 3), -- Aree Pro uses Tire
(3, 4), -- Aree uses Brake
(4, 4); -- Aree Pro uses Brake

-- Insert sample data into PartMadeBy table
INSERT INTO PartMadeBy (sup_id, part_id) VALUES
(1, 1), -- Hamax Power makes Battery
(2, 2), -- Brazil Parts makes Engine
(3, 3), -- Global Tires makes Tire
(2, 4); -- Brazil Parts makes Brake