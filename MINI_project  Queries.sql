USE Hospital;

# Q1 621422052
DROP VIEW if exists PatientSurgeryView;
CREATE VIEW PatientSurgeryView AS
SELECT
    p.ID_number AS "Patient Identification Number",
    CONCAT(pn.initial, ' ', pn.surname) AS "Patient Name",
    CONCAT(pl.Bed_Number, ', Room ', pl.Room_Number) AS "Location",
    sn.Surgery_name AS "Surgery Name",
    sn.Surgery_date AS "Surgery Date"
FROM
    patient AS p
    JOIN Patient_name AS pn ON p.ID_number = pn.ID_number
    JOIN Patient_location AS pl ON p.ID_number = pl.ID_number
    LEFT JOIN Surgery_need_patient AS sn ON p.ID_number = sn.ID_number;

select * from PatientSurgeryView;



#Q2  621422052
drop table if exists MedInfo;
CREATE TABLE MedInfo (
    MedName VARCHAR(70),
    QuantityAvailable INT,
    ExpirationDate DATE
);


drop trigger if exists InsertMedInfo;
DELIMITER //
CREATE TRIGGER InsertMedInfo
AFTER INSERT ON Medicine
FOR EACH ROW
BEGIN
    INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
    VALUES (NEW.Medicine_name, NEW.Quantity_on_hand, NEW.Expire_date);
END;
//
DELIMITER ;

INSERT INTO Medicine (Medicine_code, Medicine_name, Quantity_on_hand, Quantity_Orderd, cost, Expire_date)
VALUES
    ('M006', 'Aspirin', 200, 25, 2.50, '2023-11-30'),
     ('M007', 'Penicillin', 80, 15, 6.25, '2023-09-20'),
     ('M008', 'Codeine', 60, 10, 4.50, '2023-10-10');

select * from MedInfo;

DELIMITER //

CREATE TRIGGER UpdateMedInfo
AFTER UPDATE ON Medicine 
FOR EACH ROW
BEGIN
    UPDATE MedInfo
    SET QuantityAvailable = NEW.Quantity_on_hand, ExpirationDate = NEW.Expire_date
    WHERE MedName = NEW.Medicine_name;
END;
//
DELIMITER ;

update Medicine set Quantity_on_hand=180 where Medicine_code='M006';
select * from MedInfo;


DELIMITER //
CREATE TRIGGER DeleteMedInfo
AFTER DELETE ON Medicine 
FOR EACH ROW
BEGIN
    DELETE FROM MedInfo
    WHERE MedName = OLD.Medicine_name;
END;
//
DELIMITER ;


DELETE FROM Medicine WHERE Medicine_code = 'M006';
select * from MedInfo;


#Q3  621422052
DELIMITER //
CREATE PROCEDURE GetMedicationCount(
    IN PatientIDNumber VARCHAR(10),
    INOUT MedicationCount INT  
)
BEGIN
    SELECT COUNT(*) INTO MedicationCount
    FROM Patient_take_medicine
    WHERE ID_number = PatientIDNumber;
END;
//
DELIMITER ;


SET @PatientID = 'P001';
SET @MedicationCountResult = 0;
CALL GetMedicationCount(@PatientID, @MedicationCountResult);
SELECT @MedicationCountResult AS MedicationCountForPatient;



#Q4 621422052
DELIMITER //

CREATE FUNCTION CalculateDaysRemaining(ExpireDate DATE) RETURNS INT
BEGIN
    DECLARE CurrentDate DATE;
    DECLARE DaysRemaining INT;
    
    SET CurrentDate = CURDATE(); 
    

    SET DaysRemaining = DATEDIFF(ExpireDate, CurrentDate);
    
    RETURN DaysRemaining;
END;
//
DELIMITER ;

SELECT
    Medicine_code,
    Medicine_name,
    Quantity_on_hand,
    Quantity_Orderd,
    cost,
    Expire_date,
    CalculateDaysRemaining(Expire_date) AS Days_Remaining
FROM
    Medicine
WHERE
    CalculateDaysRemaining(Expire_date) <= 30;



#Q6 621422052

LOAD XML LOCAL INFILE 'D:\ACA\2nd year\2nd sem\EEI4366-Data Modelling and Database Systems\MINI project\Employee.xml' INTO TABLE staff ROWS IDENTIFIED BY '<employee>';
LOAD XML LOCAL INFILE 'D:\ACA\2nd year\2nd sem\EEI4366-Data Modelling and Database Systems\MINI project\Patient.xml' INTO TABLE patient ROWS IDENTIFIED BY '<patient>';



#Other Queries

select * from Staff;
select * from Doctor;
select * from MonitorDoctor;
select * from Surgeon;
select * from Nurse;
select * from Patient;
select * from Patient_name;
select * from patient_address;
select * from Patient_location;
select * from Surgery_need_patient;
select * from Surgery;
select * from Medicine;
select * from Patient_take_medicine;



#create a view for surgeon to get details
DROP VIEW if exists surgeon_view;
CREATE VIEW surgeon_view AS
SELECT Surgeon.Surgeon_id, staff.emp_name, Surgeon.type_of_contract, Surgeon.length_of_contract
FROM Surgeon
JOIN staff ON Surgeon.Surgeon_id = staff.emp_no;

select * from surgeon_view;

#create a view for surgery need patient to get details
DROP VIEW if exists surgery_need_patient_view;
CREATE VIEW surgery_need_patient_view AS
SELECT Surgery_need_patient.ID_number, Surgery_need_patient.Surgery_name, Surgery_need_patient.special_needs,
       Surgery_need_patient.Category, Surgery_need_patient.Surgery_date, Surgery_need_patient.Surgery_time
FROM Surgery_need_patient;

select * from surgery_need_patient_view;

