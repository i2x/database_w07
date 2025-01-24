-- Drop the database if it already exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ManufacturingDB')
    DROP DATABASE ManufacturingDB;

-- Create the database
CREATE DATABASE ManufacturingDB;
GO

-- Use the database
USE ManufacturingDB;
GO

-- Create the tables
CREATE TABLE Address (
    id INT IDENTITY(1,1) PRIMARY KEY,
    country NVARCHAR(100) NOT NULL,
    state NVARCHAR(100),
    city NVARCHAR(100) NOT NULL,
    road NVARCHAR(255),
    zip_code NVARCHAR(20)
);

CREATE TABLE Manufacturer (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    website NVARCHAR(255),
    email NVARCHAR(100),
    tel NVARCHAR(20),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES Address(id)
);

CREATE TABLE Model (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    type NVARCHAR(100),
    color NVARCHAR(50),
    year INT,
    manu_id INT,
    FOREIGN KEY (manu_id) REFERENCES Manufacturer(id)
);

CREATE TABLE Part (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    category NVARCHAR(100),
    doc_link NVARCHAR(255)
);

CREATE TABLE Supplier (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    website NVARCHAR(255),
    email NVARCHAR(100),
    tel NVARCHAR(20),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES Address(id)
);

CREATE TABLE PartOfModel (
    model_id INT,
    part_id INT,
    PRIMARY KEY (model_id, part_id),
    FOREIGN KEY (model_id) REFERENCES Model(id),
    FOREIGN KEY (part_id) REFERENCES Part(id)
);

CREATE TABLE PartMadeBy (
    sup_id INT,
    part_id INT,
    PRIMARY KEY (sup_id, part_id),
    FOREIGN KEY (sup_id) REFERENCES Supplier(id),
    FOREIGN KEY (part_id) REFERENCES Part(id)
);

-- Insert into Address
INSERT INTO Address (country, state, city, road, zip_code) VALUES 
(N'USA', N'California', N'San Francisco', N'Market Street', N'94103'),
(N'Brazil', N'São Paulo', N'São Paulo', N'Avenida Paulista', N'01311-200'),
(N'USA', N'Texas', N'Austin', N'Congress Avenue', N'73301'),
(N'Brazil', N'Rio de Janeiro', N'Rio de Janeiro', N'Rua Nascimento Silva', N'22421-000');

-- Insert into Manufacturer
INSERT INTO Manufacturer (name, website, email, tel, address_id) VALUES
(N'Tornad', N'www.tornad.com', N'contact@tornad.com', N'+14155551234', 1),
(N'Zoom Motors', N'www.zoommotors.com', N'support@zoommotors.com', N'+15125559876', 3);

-- Insert into Model
INSERT INTO Model (name, type, color, year, manu_id) VALUES
(N'Aree', N'SUV', N'Red', 2023, 1),
(N'Bolt', N'Sedan', N'Blue', 2022, 1),
(N'ZoomX', N'Convertible', N'Yellow', 2024, 2);

-- Insert into Part
INSERT INTO Part (name, description, category, doc_link) VALUES
(N'Battery A1', N'High-performance battery', N'Battery', N'www.docs.com/battery_a1'),
(N'Engine X', N'V8 engine', N'Engine', N'www.docs.com/engine_x'),
(N'Battery B2', N'Standard battery', N'Battery', N'www.docs.com/battery_b2');

-- Insert into Supplier
INSERT INTO Supplier (name, website, email, tel, address_id) VALUES
(N'Hamax Power', N'www.hamaxpower.com', N'info@hamax.com', N'+551199876543', 2),
(N'EngineMax', N'www.enginemax.com', N'support@enginemax.com', N'+14155556789', 3);

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
