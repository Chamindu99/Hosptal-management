DROP DATABASE IF EXISTS Hospital;
CREATE DATABASE Hospital;

#s92062052-621422052
USE Hospital;

#create main table called staff
DROP TABLE IF EXISTS staff;
CREATE TABLE staff(
emp_no varchar(10) PRIMARY KEY,
emp_name varchar(50),
gender varchar(7),
address varchar(50),
Telephone_number varchar(20),
employment_type varchar(20));

#insert values into staff
INSERT INTO staff (emp_no, emp_name, gender, address, Telephone_number, employment_type)
VALUES
('D001', 'Samantha Perera', 'Female', '123 Main St, Colombo', '1122334455', 'Doctor'),
('N101', 'Rajitha Silva', 'Male', '456 Elm St, Kandy', '2233445566', 'Nurse'),
('S201', 'Nimal Fernando', 'Male', '789 Oak St, Galle', '3344556677', 'Surgeon'),
('N102', 'Kamala Jayawardena', 'Female', '987 Pine St, Matara', '4455667788', 'Nurse'),
('D002', 'Dasun Rajapaksa', 'Male', '654 Cedar St, Jaffna', '5566778899', 'Doctor'),
('D003', 'Dasun Dilshan', 'Male', '645/4 street Jaffna', '5566777799', 'Doctor'),
('S202', 'Nimal Dilshan', 'Male', '789/5 Imaduwa, Galle', '3348556677', 'Surgeon'),
('N103', 'Kamala Danushka', 'male', '97 Pine St, Dehiwala', '3355667788', 'Nurse');



#create table called Doctor
DROP TABLE IF EXISTS Doctor;
CREATE TABLE Doctor(
Doctor_id varchar(10) primary key,
speciality varchar(100));

#insert values into Doctor
INSERT INTO Doctor (Doctor_id, speciality)
VALUES
('D001','Cardiology'),
('D002','Pediatrics'),
('D003','Pediatrics');



#create table called MonitorDoctor
DROP TABLE IF EXISTS MonitorDoctor;
create table MonitorDoctor(
Doctor_id varchar(10),
HD_number varchar(8),
foreign key(Doctor_id)references Doctor(Doctor_id));

#insert values into MonitorDoctor
INSERT INTO MonitorDoctor (Doctor_id,HD_number)
VALUES
('D003','HD001');



#create table called Surgeon
DROP TABLE IF EXISTS Surgeon;
Create table Surgeon(
Surgeon_id varchar(10) primary key,
type_of_contract varchar(30),
length_of_contract varchar(30));

#Insert values into Surgeon
INSERT INTO Surgeon(Surgeon_id,type_of_contract,length_of_contract)
VALUES
('S201','Permanent','Indefinite'),
('S202','Contract','2 years');


#create table called Nurse
DROP TABLE IF EXISTS Nurse;
create table Nurse(
Nurse_id varchar(10) primary key,
Work_Years year,
Grade varchar(10),
Skill_type varchar (20));


#Insert values into Surgeon
INSERT INTO Nurse (Nurse_id, Work_Years, Grade, Skill_type)
VALUES
    ('N101', 3, 'Senior', 'Critical Care'),
    ('N102', 5, 'Junior', 'Surgeon Nurse'),
    ('N103', 5, 'Junior', 'Surgeon Nurse');


#create table called Patient
DROP TABLE IF EXISTS patient;
create table patient(
ID_number varchar(10) Primary Key,
Blood_type varchar(10),
age year,
allergy varchar(30),
tele_number varchar(30));

#Insert values into patient
INSERT INTO patient (ID_number, Blood_type, age, allergy, tele_number)
VALUES
    ('P001', 'A+', 35, 'Penicillin', '7722334455'),
    ('P002', 'O-', 50, 'Sulfonamides', '8888777766'),
    ('P003', 'B+', 28, NULL, '9999888877'),
    ('P004', 'AB-', 42, 'Latex', '6666555544'),
    ('P005', 'A-', 60, 'Codeine', '5555666677');


#create table called Patient_name
DROP TABLE IF EXISTS Patient_name;
create table Patient_name(
ID_number varchar(10),
P_name varchar(30),
surname varchar(20),
initial varchar(20),
foreign key(ID_number)references patient(ID_number));

#Insert values into Patient_name
INSERT INTO Patient_name (ID_number, P_name, surname, initial)
VALUES
    ('P001', 'Chathuri', 'Fernando', 'C. D.'),
    ('P002', 'Saman', 'Perera', 'S.'),
    ('P003', 'Nilantha', 'Rathnayake', 'N. M.'),
    ('P004', 'Ayesha', 'Kumarasinghe', 'A. K.'),
    ('P005', 'Ranjith', 'Siriwardena', 'R.');


#create table called Patient_address
DROP TABLE IF EXISTS patient_address;
create table patient_address(
ID_number varchar(10),
address varchar(50),
foreign key(ID_number)references patient(ID_number));

#Insert values into Patient_address
INSERT INTO Patient_address (ID_number, address)
VALUES
    ('P001', '123 Park St, Colombo'),
    ('P002', '456 Hill Rd, Kandy'),
    ('P003', '789 Beach Rd, Galle'),
    ('P004', '987 Lake St, Matara'),
    ('P005', '654 Forest Rd, Jaffna');


#create table called Patient_location
DROP TABLE IF EXISTS Patient_location;
create table Patient_location(
ID_number varchar(10),
Bed_Number varchar(50),
Room_Number varchar(50),
Nursing_unit varchar (20),
foreign key(ID_number)references patient(ID_number));

#insert values into Patient_location
INSERT INTO Patient_location (ID_number, Bed_Number, Room_Number, Nursing_unit)
VALUES
    ('P001', 'B101', '101', 'ICU'),
    ('P002', 'B202', '202', 'Maternity'),
    ('P003', 'A303', '303', 'Surgery Ward'),
    ('P004', 'C404', '404', 'Orthopedics Ward'),
    ('P005', 'D505', '505', 'Pediatrics Ward');


#create table called Surgery_need_patient
DROP TABLE IF EXISTS Surgery_need_patient;
create table Surgery_need_patient(
ID_number varchar(10),
Surgery_name varchar(50),
special_needs varchar(40),
Category varchar(20),
Surgery_date date,
Surgery_time time,
foreign key(ID_number)references patient(ID_number));

#Insert values into Surgery_need_patient
INSERT INTO Surgery_need_patient (ID_number, Surgery_name, special_needs, Category, Surgery_date, Surgery_time)
VALUES
    ('P001', 'Appendectomy', 'None', 'Elective', '2023-08-15', '10:00:00'),
    ('P002', 'Hysterectomy', 'Hypertension', 'Urgent', '2023-08-20', '14:30:00'),
    ('P003', 'Gallbladder Removal', NULL, 'Elective', '2023-08-18', '09:30:00'),
    ('P004', 'Knee Replacement', 'Diabetes', 'Urgent', '2023-08-17', '11:00:00'),
    ('P005', 'Tonsillectomy', NULL, 'Elective', '2023-08-16', '15:00:00');


#create table called Surgery
DROP TABLE IF EXISTS Surgery;
create table Surgery(
ID_number varchar(10),
Surgeon_id varchar(10),
Nurse_id varchar(10),
foreign key(ID_number)references patient(ID_number),
foreign key(Surgeon_id)references Surgeon(Surgeon_id),
foreign key(Nurse_id)references Nurse(Nurse_id));


#insert values into Surgery
insert into Surgery Values ('P001','S201','N102');


#create table called Medicine
DROP TABLE IF EXISTS Medicine;
create table Medicine (
Medicine_code varchar(10) primary key,
Medicine_name varchar(40),
Quantity_on_hand int(10),
Quantity_Orderd int(8),
cost float(10),
Expire_date date);


#Insert value into medicine
INSERT INTO Medicine (Medicine_code, Medicine_name, Quantity_on_hand, Quantity_Orderd, cost, Expire_date)
VALUES
    ('M001', 'Paracetamol', 100, 50, 5.25, '2023-12-31'),
    ('M002', 'Amoxicillin', 75, 30, 10.75, '2023-09-15'),
    ('M003', 'Lisinopril', 50, 20, 8.50, '2024-02-28'),
    ('M004', 'Ibuprofen', 120, 60, 3.75, '2023-09-30'),
    ('M005', 'Omeprazole', 90, 40, 7.00, '2024-01-15');


#create table called Patient_take_medicine
DROP TABLE IF EXISTS Patient_take_medicine;
create table Patient_take_medicine(
Medicine_code varchar(10),
ID_number varchar(10),
foreign key(Medicine_code)references Medicine(Medicine_code),
foreign key(ID_number)references patient(ID_number));


#Insert values into Patient_take_medicine
INSERT INTO Patient_take_medicine (Medicine_code, ID_number)
VALUES
    ('M001', 'P001'),
    ('M002', 'P002'),
    ('M003', 'P003'),
    ('M004', 'P004'),
    ('M005', 'P005');


