-- from the terminal run:
-- psql < medical_center.sql

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;


\c medical_center


-- Create Doctors Table
CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    contact_info VARCHAR(255)
);

-- Create Patients Table
CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    contact_info VARCHAR(255)
);

-- Create Diseases Table
CREATE TABLE Diseases (
    disease_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Create Visits Table
CREATE TABLE Visits (
    visit_id SERIAL PRIMARY KEY,
    doctor_id INTEGER REFERENCES Doctors(doctor_id),
    patient_id INTEGER REFERENCES Patients(patient_id),
    visit_date DATE NOT NULL,
    notes TEXT
);

-- Create Diagnoses Table
CREATE TABLE Diagnoses (
    diagnosis_id SERIAL PRIMARY KEY,
    visit_id INTEGER REFERENCES Visits(visit_id),
    disease_id INTEGER REFERENCES Diseases(disease_id)
);

-- Insert Sample Data into Doctors
INSERT INTO Doctors (name, specialty, contact_info) VALUES ('Dr. Smith', 'Cardiology', '123-456-7890');
INSERT INTO Doctors (name, specialty, contact_info) VALUES ('Dr. Adams', 'Neurology', '987-654-3210');

-- Insert Sample Data into Patients
INSERT INTO Patients (name, date_of_birth, contact_info) VALUES ('John Doe', '1980-05-10', 'john@example.com');
INSERT INTO Patients (name, date_of_birth, contact_info) VALUES ('Jane Roe', '1990-07-20', 'jane@example.com');

-- Insert Sample Data into Diseases
INSERT INTO Diseases (name, description) VALUES ('Hypertension', 'High blood pressure');
INSERT INTO Diseases (name, description) VALUES ('Migraine', 'Severe headache');

-- Insert Sample Data into Visits
INSERT INTO Visits (doctor_id, patient_id, visit_date, notes) VALUES (1, 1, '2024-07-30', 'Routine check-up');
INSERT INTO Visits (doctor_id, patient_id, visit_date, notes) VALUES (2, 2, '2024-07-31', 'Severe headache');

-- Insert Sample Data into Diagnoses
INSERT INTO Diagnoses (visit_id, disease_id) VALUES (1, 1);
INSERT INTO Diagnoses (visit_id, disease_id) VALUES (2, 2);

