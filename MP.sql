CREATE DATABASE HospitalManagementSystem_db;
USE HospitalManagementSystem_db;

--2)
CREATE TABLE Patient (
    P_ID INT PRIMARY KEY,
    P_Name VARCHAR(100),
    Contact VARCHAR(20)
);
CREATE TABLE Doctor (
    DOC_ID INT PRIMARY KEY,
    DOC_Name VARCHAR(100),
    Specialty VARCHAR(100)
);
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    P_ID INT,
    DOC_ID INT,
    Date DATE,
    Time TIME,
    FOREIGN KEY (P_ID) REFERENCES Patient(P_ID),
    FOREIGN KEY (DOC_ID) REFERENCES Doctor(DOC_ID)
);
CREATE TABLE MedicalHistory (
    History_ID INT PRIMARY KEY,
    P_ID INT,
    Description TEXT,
    FOREIGN KEY (P_ID) REFERENCES Patient(P_ID)
);
CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY,
    P_ID INT,
    DOC_ID INT,
    Medication VARCHAR(100),
    Dosage VARCHAR(255),
    FOREIGN KEY (P_ID) REFERENCES Patient(P_ID),
    FOREIGN KEY (DOC_ID) REFERENCES Doctor(DOC_ID)
);
--3)
-- Patients
INSERT INTO Patient (P_ID, P_Name, Contact) VALUES
(1, 'Janith Dewmina', '0778541756'),
(2, 'Sanduni Shehara', '0714586245'),
(3, 'Ranudi Shehansa', '0714851315'),
(4, 'Amila Perera', '0724568645'),
(5, 'Ishara Hettige', '0760486154'),
(6, 'Umesha Nirmani', '0775684251'),
(7, 'Samadhi Hansika', '0757831492'),
(8, 'Thushari Perera', '0714345256'),
(9, 'Priyani Kuruwitage', '0773541289'),
(10, 'Mala Gunathilaka', '0751789465');

-- Doctors
INSERT INTO Doctor (DOC_ID, DOC_Name, Specialty) VALUES
(1, 'Dr. Sumith Perera', 'Cardiology'),
(2, 'Dr. John De Silva', 'Pediatrics'),
(3, 'Dr. Saranga Peiris', 'Orthopedics'),
(4, 'Dr. Shen De Alwis', 'Neurology'),
(5, 'Dr. Dilani Gurusinghe', 'Dermotology'),
(6, 'Dr. Shantha Perera', 'Oncology'),
(7, 'Dr. Rashmi Priyangika', 'psychiatry'),
(8, 'Dr. Waruna Palihawadana', 'Gynecology'),
(9, 'Dr. Abdul Aslam', 'Cardiology'),
(10, 'Dr. Meena Lakshmi', 'Neurology');

-- Appointments
INSERT INTO Appointment (Appointment_ID, P_ID, DOC_ID, Date, Time) VALUES
(1, 1, 1, '2024-05-06', '09:00:00'),
(2, 2, 2, '2024-05-07', '10:00:00'),
(3, 3, 4, '2024-05-06', '10:05:00'),
(4, 4, 6, '2024-05-08', '11:00:00'),
(5, 5, 9, '2024-05-07', '09:15:00'),
(6, 6, 3, '2024-05-09', '12:00:00'),
(7, 7, 7, '2024-05-10', '09:30:00'),
(8, 8, 8, '2024-05-09', '11:15:00'),
(9, 9, 5, '2024-05-08', '10:30:00'),
(10, 10, 10, '2024-05-10', '10:15:00');

-- Medical History
INSERT INTO MedicalHistory (History_ID, P_ID, Description) VALUES
(100, 1, 'Hypertension'),
(101, 2, 'Asthma'),
(102, 3, 'Back Pain'),
(103, 4, 'Migraine Headaches'),
(104, 5, 'Skin Pigmentation'),
(105, 6, 'Stage I breast cancer'),
(106, 7, 'Major depressive disorder'),
(107, 8, 'Polycystic ovary syndrome'),
(108, 9, 'Myocardial infarction'),
(110, 10, 'Ear infections');

-- Prescriptions
INSERT INTO Prescription (Prescription_ID, P_ID, DOC_ID, Medication, Dosage) VALUES
(1, 1, 1, 'Lisinopril', '10mg once daily'),
(2, 2, 2, 'Albuterol inhaler', 'Use as needed for asthma symptoms'),
(3, 3, 4, 'Ibuprofen', '400mg every six hours as needed for pain'),
(4, 4, 6, 'Sumatriptan', '50mg at onset of migraine, may repeat in 2 hours if needed'),
(5, 5, 9, 'Hydroquinone cream', 'Apply a thin layer to affected areas once daily'),
(6, 6, 3, 'Tamoxifen', '20mg once daily for five years'),
(7, 7, 7, 'Sertraline', '50mg once daily, may increase to 100mg after one week'),
(8, 8, 8, 'Metformin', '500mg twice daily with meals'),
(9, 9, 5, 'Aspirin', '81mg once daily'),
(10, 10, 10, 'Amoxicillin', '500mg three times daily for 7-10 days');

--4
SELECT * FROM Appointment WHERE P_ID = 1;
INSERT INTO Patient (P_ID, P_Name, Contact) VALUES (11, 'Nuwan Perera', '0771234567');
UPDATE Patient SET Contact = '0712345678' WHERE P_ID = 11;
DELETE FROM Appointment WHERE Appointment_ID = 10;

--5)

CREATE PROCEDURE GetAppointmentsForPatient  @PatientID INT
AS BEGIN
SELECT Appointment_ID, P_Name AS Patient_Name, DOC_Name AS Doctor_Name, Date, Time
FROM Appointment
    INNER JOIN Patient ON Appointment.P_ID = Patient.P_ID
    INNER JOIN Doctor ON Appointment.DOC_ID = Doctor.DOC_ID
    WHERE Appointment.P_ID = @PatientID;
END;

 
CREATE FUNCTION GetTotalAppointmentsForDoctor (@DoctorID INT) 
RETURNS INT AS BEGIN 
DECLARE @TotalAppointments INT; 
SELECT @TotalAppointments = COUNT(*) FROM Appointment WHERE DOC_ID = @DoctorID; 
RETURN @TotalAppointments; END;
