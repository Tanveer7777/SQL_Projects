-- ============================================================
-- 🏥 Hospital Data Analysis Project (SQL)
-- Database: bharat
-- ============================================================

CREATE DATABASE IF NOT EXISTS bharat;
USE bharat;

-- NOTE:
-- Load CSV files into patients, doctors, appointments before running queries

-- ============================================================
-- BUSINESS PROBLEMS & SOLUTIONS
-- ============================================================

-- #---1.How many patients does the hospital have in total?
SELECT
COUNT(*) AS total_patients
FROM patients;

-- #---2.How many appointments were Completed, Cancelled,
--            and Pending?
SELECT
status,
COUNT(*) AS total_appointments
FROM appointments
GROUP BY status
ORDER BY total_appointments DESC;

-- #---3. What is the total revenue collected by
--            the hospital so far?
SELECT
SUM(bill_amount) AS total_revenue
FROM appointments
WHERE status = 'Completed';

-- #---4.Which department has the most doctors?
SELECT
department,
COUNT(*) AS total_doctor
FROM doctors
GROUP BY department
ORDER BY total_doctor DESC;

-- #---5.List all male patients above the age of 45.
SELECT
patient_name,
city,
age
FROM patients
WHERE gender = 'Male'
AND age > 45
ORDER BY age DESC;

-- #---6.What is the most common payment mode used
--            by patients?
SELECT
payment_mode,
COUNT(*) AS total
FROM appointments
WHERE status = 'Completed'
GROUP BY payment_mode
ORDER BY total DESC
LIMIT 1;

-- #---7.Which doctor has generated the most
--              revenue for the hospital?
SELECT
d.doctor_name,
SUM(a.bill_amount) AS total
FROM doctors d
JOIN appointments a
ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_name
ORDER BY total DESC
LIMIT 1;

-- #---8.What is the average bill amount per department?
SELECT
d.department,
COUNT(a.appointment_id) AS appointments,
ROUND(AVG(a.bill_amount), 2) AS avg_bill_inr,
ROUND(MIN(a.bill_amount), 2) AS min_bill,
ROUND(MAX(a.bill_amount), 2) AS max_bill
FROM doctors d
JOIN appointments a
ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.department
ORDER BY avg_bill_inr DESC;

-- #---9.Find patients who have visited the hospital
--              more than once. (Repeat patients)
SELECT
p.patient_name,
COUNT(a.appointment_id) AS visit_count
FROM patients p
JOIN appointments a
ON p.patient_id = a.patient_id
WHERE a.status = 'Completed'
GROUP BY p.patient_id, p.patient_name
HAVING COUNT(a.appointment_id) > 1
ORDER BY visit_count DESC;

-- #---10.Which patients have NEVER had a completed
--              appointment? (No-show / inactive patients)
SELECT
p.patient_name
FROM patients p
LEFT JOIN appointments a
ON p.patient_id = a.patient_id
AND a.status = 'Completed'
WHERE a.appointment_id IS NULL
ORDER BY p.patient_name;

-- ============================================================
-- ✅ END
-- ============================================================
