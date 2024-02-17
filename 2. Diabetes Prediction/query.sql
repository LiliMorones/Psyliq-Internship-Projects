--> Explore data
SELECT TOP 10 *
FROM Diabetes;

--> Count rows/patients
SELECT COUNT(DISTINCT Patient_id)
FROM Diabetes;

--> Check the smoking_history variable
SELECT DISTINCT smoking_history
FROM Diabetes;

--> 1. Retrieve the Patient_id and ages of all patients
SELECT Patient_id, age
FROM Diabetes;

--> 2. Select all female patients who are older than 40
SELECT *
FROM Diabetes
WHERE gender = 'Female' AND age > 40;

--> 3. Calculate the average BMI of patients
SELECT ROUND(AVG(bmi),2) AS avg_bmi
FROM Diabetes;

--> 4. List patients in descending order of blood glucose levels
SELECT *
FROM Diabetes
ORDER BY blood_glucose_level DESC;

--> 5. Find patients who have hypertension and diabetes
SELECT *
FROM Diabetes
WHERE hypertension = 1 AND diabetes = 1;

--> 6. Determine the number of patients with heart disease
SELECT COUNT(heart_disease) AS patients_with_heart_disease
FROM Diabetes
WHERE heart_disease = 1;

--> 7. Group patients by smoking history and count how many smokers and nonsmokers there are
SELECT smoking_history, 
	   COUNT(*) AS smoking_count
FROM Diabetes
GROUP BY smoking_history;

--> 8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI
SELECT Patient_id, bmi
FROM Diabetes
WHERE bmi >
	(SELECT AVG(bmi)
	FROM Diabetes);

--> 9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
SELECT Patient_id
FROM Diabetes
WHERE HbA1c_level = 
	(SELECT MAX(HbA1c_level) 
	 FROM Diabetes);

SELECT Patient_id
FROM Diabetes
WHERE HbA1c_level = 
	(SELECT MIN(HbA1c_level) 
	 FROM Diabetes);

--> 10. Calculate the birth year of patients (assuming the current date as of now).
SELECT Patient_id,
	   YEAR(GETDATE()) - age AS birth_year
FROM Diabetes;

--> 11. Rank patients by blood glucose level within each gender group
SELECT Patient_id,
       gender,
       blood_glucose_level,
       RANK() OVER (PARTITION BY gender ORDER BY blood_glucose_level) AS glucose_rank_gender
FROM Diabetes; 

--> 12. Update the smoking history of patients who are older than 50 to "Ex-smoker" 
UPDATE Diabetes 
SET smoking_history = 'Ex-smoker'
WHERE age > 50;

SELECT Patient_id, 
	   age, 
	   smoking_history
FROM Diabetes
WHERE age > 50;

--> 13. Insert a new patient into the database with sample data
INSERT INTO Diabetes 
	(EmployeeName, Patient_id, gender, age, hypertension, heart_disease, 
	 smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
VALUES
    ('Ana Hernandez', 'PT100101', 'Female', 46, 1, 0,
	'former', 30.5, 5.5, 220, 1);

SELECT *
FROM Diabetes
WHERE Patient_id = 'PT100101';

--> 14. Delete all patients with heart disease from the database.
DELETE
FROM Diabetes 
WHERE heart_disease = 1;

SELECT * 
FROM Diabetes
WHERE heart_disease = 1;

--> 15. Find patients who have hypertension but not diabetes using the EXCEPT operator.
SELECT *
FROM Diabetes 
WHERE hypertension = 1

EXCEPT

SELECT *
FROM Diabetes
WHERE diabetes = 1;

--> 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
ALTER TABLE Diabetes
ADD CONSTRAINT UQ_PatientID UNIQUE (Patient_id);

--> 17. Create a view that displays the Patient_ids, ages, and BMI of patients
CREATE VIEW PatientBMIAge AS(
	SELECT  Patient_id, 
			Age, 
			BMI
	FROM Diabetes);

SELECT *
FROM PatientBMIAge;