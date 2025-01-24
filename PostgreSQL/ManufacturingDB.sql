-- Drop the database if it already exists
DROP DATABASE IF EXISTS "ManufacturingDB";

-- Create the database
CREATE DATABASE "ManufacturingDB";

-- Connect to the database
\c "ManufacturingDB";

-- Create the tables
CREATE TABLE "Address" (
    id SERIAL PRIMARY KEY,
    country VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    city VARCHAR(100) NOT NULL,
    road VARCHAR(255),
    zip_code VARCHAR(20)
);

CREATE TABLE "Manufacturer" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    website VARCHAR(255),
    email VARCHAR(100),
    tel VARCHAR(20),
    address_id INT,
    CONSTRAINT fk_address FOREIGN KEY (address_id) REFERENCES "Address"(id)
);

CREATE TABLE "Model" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(100),
    color VARCHAR(50),
    year INT,
    manu_id INT,
    CONSTRAINT fk_manufacturer FOREIGN KEY (manu_id) REFERENCES "Manufacturer"(id)
);

CREATE TABLE "Part" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    doc_link VARCHAR(255)
);

CREATE TABLE "Supplier" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    website VARCHAR(255),
    email VARCHAR(100),
    tel VARCHAR(20),
    address_id INT,
    CONSTRAINT fk_supplier_address FOREIGN KEY (address_id) REFERENCES "Address"(id)
);

CREATE TABLE "PartOfModel" (
    model_id INT,
    part_id INT,
    PRIMARY KEY (model_id, part_id),
    CONSTRAINT fk_partofmodel_model FOREIGN KEY (model_id) REFERENCES "Model"(id),
    CONSTRAINT fk_partofmodel_part FOREIGN KEY (part_id) REFERENCES "Part"(id)
);

CREATE TABLE "PartMadeBy" (
    sup_id INT,
    part_id INT,
    PRIMARY KEY (sup_id, part_id),
    CONSTRAINT fk_partmadeby_supplier FOREIGN KEY (sup_id) REFERENCES "Supplier"(id),
    CONSTRAINT fk_partmadeby_part FOREIGN KEY (part_id) REFERENCES "Part"(id)
);

-- Insert into Address
INSERT INTO "Address" (country, state, city, road, zip_code) VALUES 
('USA', 'California', 'San Francisco', 'Market Street', '94103'),
('Brazil', 'São Paulo', 'São Paulo', 'Avenida Paulista', '01311-200'),
('USA', 'Texas', 'Austin', 'Congress Avenue', '73301'),
('Brazil', 'Rio de Janeiro', 'Rio de Janeiro', 'Rua Nascimento Silva', '22421-000');

-- Insert into Manufacturer
INSERT INTO "Manufacturer" (name, website, email, tel, address_id) VALUES
('Tornad', 'www.tornad.com', 'contact@tornad.com', '+14155551234', 1),
('Zoom Motors', 'www.zoommotors.com', 'support@zoommotors.com', '+15125559876', 3);

-- Insert into Model
INSERT INTO "Model" (name, type, color, year, manu_id) VALUES
('Aree', 'SUV', 'Red', 2023, 1),
('Bolt', 'Sedan', 'Blue', 2022, 1),
('ZoomX', 'Convertible', 'Yellow', 2024, 2);

-- Insert into Part
INSERT INTO "Part" (name, description, category, doc_link) VALUES
('Battery A1', 'High-performance battery', 'Battery', 'www.docs.com/battery_a1'),
('Engine X', 'V8 engine', 'Engine', 'www.docs.com/engine_x'),
('Battery B2', 'Standard battery', 'Battery', 'www.docs.com/battery_b2');

-- Insert into Supplier
INSERT INTO "Supplier" (name, website, email, tel, address_id) VALUES
('Hamax Power', 'www.hamaxpower.com', 'info@hamax.com', '+551199876543', 2),
('EngineMax', 'www.enginemax.com', 'support@enginemax.com', '+14155556789', 3);

-- Insert into PartOfModel
INSERT INTO "PartOfModel" (model_id, part_id) VALUES
(1, 1), -- Aree uses Battery A1
(1, 2), -- Aree uses Engine X
(2, 3), -- Bolt uses Battery B2
(3, 1); -- ZoomX uses Battery A1

-- Insert into PartMadeBy
INSERT INTO "PartMadeBy" (sup_id, part_id) VALUES
(1, 1), -- Hamax Power makes Battery A1
(2, 2), -- EngineMax makes Engine X
(1, 3); -- Hamax Power makes Battery B2
