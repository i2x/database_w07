-- Step 1: Drop existing tables if they exist to avoid duplicates
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE PartMadeBy CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE PartOfModel CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Supplier CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Part CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Model CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Manufacturer CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Address CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      NULL; -- Ignore errors if tables do not exist
END;
/

-- Step 2: Drop the ManufacturingDB if it exists
BEGIN
   EXECUTE IMMEDIATE 'DROP PLUGGABLE DATABASE ManufacturingDB INCLUDING DATAFILES';
EXCEPTION
   WHEN OTHERS THEN
      NULL; -- Ignore error if database does not exist
END;
/

-- Step 3: Create the ManufacturingDB
-- Ensure the FILE_NAME_CONVERT paths are correct and writable
CREATE PLUGGABLE DATABASE ManufacturingDB
   ADMIN USER admin IDENTIFIED BY AdminPassword
   FILE_NAME_CONVERT = ('/opt/oracle/oradata/FREE/FREEPDB1/', '/opt/oracle/oradata/FREE/ManufacturingDB/');

-- Step 4: Open the ManufacturingDB
ALTER PLUGGABLE DATABASE ManufacturingDB OPEN;

-- Step 5: Save the state to ensure the database opens automatically on restart
ALTER PLUGGABLE DATABASE ManufacturingDB SAVE STATE;

-- Step 6: Switch to the ManufacturingDB
ALTER SESSION SET CONTAINER = ManufacturingDB;

-- Verify that the session is using the ManufacturingDB
SHOW CON_NAME;

-- Step 7: Create SQL Schema (Tables)
CREATE TABLE Address (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    country VARCHAR2(100) NOT NULL,
    state VARCHAR2(100),
    city VARCHAR2(100) NOT NULL,
    road VARCHAR2(255),
    zip_code VARCHAR2(20)
);

CREATE TABLE Manufacturer (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    website VARCHAR2(255),
    email VARCHAR2(100),
    tel VARCHAR2(20),
    address_id NUMBER,
    CONSTRAINT fk_manufacturer_address FOREIGN KEY (address_id) REFERENCES Address(id)
);

CREATE TABLE Model (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    type VARCHAR2(100),
    color VARCHAR2(50),
    year NUMBER,
    manu_id NUMBER,
    CONSTRAINT fk_model_manufacturer FOREIGN KEY (manu_id) REFERENCES Manufacturer(id)
);

CREATE TABLE Part (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    description CLOB,
    category VARCHAR2(100),
    doc_link VARCHAR2(255)
);

CREATE TABLE Supplier (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    website VARCHAR2(255),
    email VARCHAR2(100),
    tel VARCHAR2(20),
    address_id NUMBER,
    CONSTRAINT fk_supplier_address FOREIGN KEY (address_id) REFERENCES Address(id)
);

CREATE TABLE PartOfModel (
    model_id NUMBER,
    part_id NUMBER,
    PRIMARY KEY (model_id, part_id),
    CONSTRAINT fk_partofmodel_model FOREIGN KEY (model_id) REFERENCES Model(id),
    CONSTRAINT fk_partofmodel_part FOREIGN KEY (part_id) REFERENCES Part(id)
);

CREATE TABLE PartMadeBy (
    sup_id NUMBER,
    part_id NUMBER,
    PRIMARY KEY (sup_id, part_id),
    CONSTRAINT fk_partmadeby_supplier FOREIGN KEY (sup_id) REFERENCES Supplier(id),
    CONSTRAINT fk_partmadeby_part FOREIGN KEY (part_id) REFERENCES Part(id)
);

-- Step 8: Insert Sample Data
INSERT INTO Address (country, state, city, road, zip_code) VALUES
('USA', 'California', 'San Francisco', 'Market Street', '94103'),
('Brazil', 'São Paulo', 'São Paulo', 'Avenida Paulista', '01311-200'),
('USA', 'Texas', 'Austin', 'Congress Avenue', '73301'),
('Brazil', 'Rio de Janeiro', 'Rio de Janeiro', 'Rua Nascimento Silva', '22421-000');

INSERT INTO Manufacturer (name, website, email, tel, address_id) VALUES
('Tornad', 'www.tornad.com', 'contact@tornad.com', '+14155551234', 1),
('Zoom Motors', 'www.zoommotors.com', 'support@zoommotors.com', '+15125559876', 3);

INSERT INTO Model (name, type, color, year, manu_id) VALUES
('Aree', 'SUV', 'Red', 2023, 1),
('Bolt', 'Sedan', 'Blue', 2022, 1),
('ZoomX', 'Convertible', 'Yellow', 2024, 2);

INSERT INTO Part (name, description, category, doc_link) VALUES
('Battery A1', 'High-performance battery', 'Battery', 'www.docs.com/battery_a1'),
('Engine X', 'V8 engine', 'Engine', 'www.docs.com/engine_x'),
('Battery B2', 'Standard battery', 'Battery', 'www.docs.com/battery_b2');

INSERT INTO Supplier (name, website, email, tel, address_id) VALUES
('Hamax Power', 'www.hamaxpower.com', 'info@hamax.com', '+551199876543', 2),
('EngineMax', 'www.enginemax.com', 'support@enginemax.com', '+14155556789', 3);

INSERT INTO PartOfModel (model_id, part_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1);

INSERT INTO PartMadeBy (sup_id, part_id) VALUES
(1, 1),
(2, 2),
(1, 3);

-- End of SQL file
EXIT;
