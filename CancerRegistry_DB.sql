CREATE DATABASE CancerRegistry;
USE CancerRegistry;

-- Create the Patient table
CREATE TABLE Patient (
  Patient_id INT PRIMARY KEY,
  First_Name VARCHAR(50) NOT NULL,
  Last_Name VARCHAR(50) NOT NULL,
  Birth_Date DATE NOT NULL,
  Sex CHAR(1) NOT NULL
);

-- Insert data into the Patient table
INSERT INTO Patient (Patient_id, First_Name, Last_Name, Birth_Date, Sex)
VALUES (1, 'John', 'Doe', '1980-05-15', 'M'),
       (2, 'Jane', 'Smith', '1975-09-22', 'F'),
       (3, 'Michael', 'Johnson', '1992-02-10', 'M'),
       (4, 'Emily', 'Davis', '1988-07-01', 'F'),
       (5, 'Daniel', 'Wilson', '1972-11-28', 'M');

SELECT * FROM Patient;

-- Create the Report table
CREATE TABLE Report (
  Report_id INT AUTO_INCREMENT PRIMARY KEY,
  Patient_id INT,
  Laboratory_Number VARCHAR(50) NOT NULL,
  Hospital_Code VARCHAR(50) NOT NULL,
  Urn VARCHAR(50) NOT NULL,
  Report_Type VARCHAR(50) NOT NULL,
  Date_of_Diagnosis DATE NOT NULL,
  Requesting_Doctor VARCHAR(100) NOT NULL,
  FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
);

-- Insert data into the Report table
INSERT INTO Report (Patient_id, Laboratory_Number, Hospital_Code, Urn, Report_Type, Date_of_Diagnosis, Requesting_Doctor)
VALUES (1, 'LAB001', 'HOSP001', 'URN001', 'Diagnostic', '2022-01-10', 'Arya Smith'),
       (2, 'LAB002', 'HOSP002', 'URN002', 'Follow-up', '2022-02-20', 'Dean Johnson'),
       (3, 'LAB003', 'HOSP003', 'URN003', 'Diagnostic', '2022-03-05', 'Kern Anderson'),
       (4, 'LAB004', 'HOSP004', 'URN004', 'Follow-up', '2022-04-15', 'Dori Quinn'),
       (5, 'LAB005', 'HOSP005', 'URN005', 'Diagnostic', '2022-05-25', 'Stef Davis');

SELECT * FROM Report;

-- Create the Patient_Notification table
CREATE TABLE Patient_Notification (
  Patient_Notification_id INT AUTO_INCREMENT PRIMARY KEY,
  Basis_of_Notification VARCHAR(100) NOT NULL,
  Histological_Type VARCHAR(100) NOT NULL,
  Histological_Grade VARCHAR(100) NOT NULL,
  Primary_Site VARCHAR(100) NOT NULL,
  Laterality VARCHAR(50) NOT NULL,
  Date_of_Diagnosis DATE NOT NULL
);

-- Insert data into the Patient_Notification table
INSERT INTO Patient_Notification (Basis_of_Notification, Histological_Type, Histological_Grade, Primary_Site, Laterality, Date_of_Diagnosis)
VALUES ('Biopsy', 'Melanoma', 'Grade III', 'Skin', 'Left', '2022-01-10'),
       ('Excision', 'Basal Cell Carcinoma', 'Grade II', 'Skin', 'Right', '2022-02-20'),
       ('Biopsy', 'Melanoma', 'Grade II', 'Skin', 'Right', '2022-03-05'),
       ('Excision', 'Squamous Cell Carcinoma', 'Grade I', 'Skin', 'Left', '2022-04-15'),
       ('Biopsy', 'Melanoma', 'Grade II', 'Skin', 'Right', '2022-05-25');

SELECT * FROM Patient_Notification;

-- Create the Report_Notification table
CREATE TABLE Report_Notification (
  Report_Notification_id INT AUTO_INCREMENT PRIMARY KEY,
  Report_id INT,
  Patient_Notification_id INT,
  Basis_of_Diagnosis VARCHAR(100) NOT NULL,
  Histological_Type VARCHAR(100) NOT NULL,
  Histological_Grade VARCHAR(100) NOT NULL,
  FOREIGN KEY (Report_id) REFERENCES Report(Report_id),
  FOREIGN KEY (Patient_Notification_id) REFERENCES Patient_Notification(Patient_Notification_id)
);

-- Insert data into the Report_Notification table
INSERT INTO Report_Notification (Report_id, Patient_Notification_id, Basis_of_Diagnosis, Histological_Type, Histological_Grade)
VALUES (1, 1, 'Biopsy', 'Melanoma', 'Grade III'),
       (2, 2, 'Biopsy', 'Basal Cell Carcinoma', 'Grade II'),
       (3, 3, 'Excision', 'Squamous Cell Carcinoma', 'Grade I'),
       (4, 4, 'Biopsy', 'Melanoma', 'Grade II'),
       (5, 5, 'Excision', 'Basal Cell Carcinoma', 'Grade III');

SELECT * FROM Report_Notification;

-- Create the Stage table
CREATE TABLE Stage (
  Stage_id INT AUTO_INCREMENT PRIMARY KEY,
  Report_Notification_id INT,
  T_stage INT NOT NULL,
  N_stage INT NOT NULL,
  M_stage INT NOT NULL,
  FOREIGN KEY (Report_Notification_id) REFERENCES Report_Notification(Report_Notification_id)
);

-- Insert data into the Stage table
INSERT INTO Stage (Report_Notification_id, T_stage, N_stage, M_stage)
VALUES (1, '3', '1', '0'),
       (2, '2', '0', '0'),
       (3, '1', '0', '0'),
       (4, '3', '1', '0'),
       (5, '2', '0', '0');

SELECT * FROM Stage;

-- Create the Synoptic table
CREATE TABLE Synoptic (
  Synoptic_id INT AUTO_INCREMENT PRIMARY KEY,
  Report_Notification_id INT,
  Tumour_size DECIMAL(10,2) NOT NULL,
  Total_Nodes INT NOT NULL,
  Positive_Nodes INT NOT NULL,
  FOREIGN KEY (Report_Notification_id) REFERENCES Report_Notification(Report_Notification_id)
);

-- Insert data into the Synoptic table
INSERT INTO Synoptic (Report_Notification_id, Tumour_size, Total_Nodes, Positive_Nodes)
VALUES (1, 2.5, 3, 2),
       (2, 1.8, 1, 0),
       (3, 0.9, 0, 0),
       (4, 2.7, 2, 1),
       (5, 1.6, 1, 0);

SELECT * FROM Synoptic;

-- Create the Synoptic_Melanoma table
CREATE TABLE Synoptic_Melanoma (
  Synoptic_Melanoma_id INT AUTO_INCREMENT PRIMARY KEY,
  Report_Notification_id INT,
  Clarks_Level VARCHAR(50) NOT NULL,
  Thickness DECIMAL(10,2) NOT NULL,
  Ulceration VARCHAR(50) NOT NULL,
  FOREIGN KEY (Report_Notification_id) REFERENCES Report_Notification(Report_Notification_id)
);

-- Insert data into the Synoptic_Melanoma table
INSERT INTO Synoptic_Melanoma (Report_Notification_id, Clarks_Level, Thickness, Ulceration)
VALUES (1, 'Level IV', 4.2, 'Present'),
       (2, 'Level II', 1.5, 'Absent'),
       (3, 'Level I', 0.8, 'Absent'),
       (4, 'Level III', 3.8, 'Present'),
       (5, 'Level II', 1.4, 'Absent');

 SELECT * FROM Synoptic_Melanoma;

 -- ------------------------------------------------------------------------------------------------
 -- Create a view that combines multiple tables using joins
 -- The view called Report Data combines data from four base tables: Report, Report_Notification, Patient_Notification, and Stage. 
 -- A view like this could be useful for researchers because it excludes identifying data like the patient’s name dob and sex 
CREATE VIEW vw_ReportData AS
SELECT R.Report_id, R.Laboratory_Number, R.Report_Type, R.Date_of_Diagnosis, PN.Basis_of_Notification, PN.Histological_Type, S.T_stage, S.N_stage
FROM
    Report R
JOIN Report_Notification RN ON R.Report_id = RN.Report_id
JOIN Patient_Notification PN ON RN.Patient_Notification_id = PN.Patient_Notification_id
JOIN Stage S ON RN.Report_Notification_id = S.Report_Notification_id;

SELECT * FROM vw_ReportData;

