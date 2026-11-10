SQL:

-- Step 1: 
CREATE DATABASE FirstDB;
USE FirstDB;

CREATE TABLE Profile (
    Profile_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Age INT,
    Department VARCHAR(50),
    Position VARCHAR(50)
);

-- Step 2: 
INSERT INTO Profile (Profile_ID, Name, Address, Age, Department, Position) VALUES
(101, 'Alice Smith', '123 Main St, Springfield', 29, 'Engineering', 'Software Developer'),
(102, 'Bob Johnson', '456 Oak Ave, Metropolis', 35, 'Human Resources', 'HR Specialist'),
(103, 'Charlie Brown', '789 Pine Rd, Gotham', 42, 'Finance', 'Financial Analyst'),
(104, 'Diana Prince', '101 Maple Dr, Star City', 31, 'Marketing', 'Marketing Director'),
(105, 'Evan Wright', '202 Birch Ln, Central City', 26, 'Sales', 'Sales Representative');

-- Step 3: 
CREATE DATABASE SecondDB;
USE SecondDB;

CREATE TABLE Profile (
    Profile_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Age INT,
    Department VARCHAR(50),
    Position VARCHAR(50)
);

-- copy records
INSERT INTO SecondDB.Profile 
SELECT * FROM FirstDB.Profile;

-- Step 4 & 5: 
ALTER TABLE Profile 
ADD COLUMN Name_Enc VARBINARY(255),
ADD COLUMN Address_Enc VARBINARY(255);

-- I-encryption
UPDATE Profile 
SET Name_Enc = AES_ENCRYPT(Name, 'StrongPassword123!'),
    Address_Enc = AES_ENCRYPT(Address, 'StrongPassword123!');

-- Step 6: 
SELECT 
    Profile_ID,
    CAST(AES_DECRYPT(Name_Enc, 'StrongPassword123!') AS CHAR) AS Decrypted_Name,
    CAST(AES_DECRYPT(Address_Enc, 'StrongPassword123!') AS CHAR) AS Decrypted_Address,
    Age, Department, Position
FROM Profile
WHERE Profile_ID IN (102, 103);

-- Step 7: 
SELECT 
    Profile_ID,
    HEX(Name_Enc) AS Encrypted_Name_Hex,
    HEX(Address_Enc) AS Encrypted_Address_Hex,
    Age, Department, Position
FROM Profile;
