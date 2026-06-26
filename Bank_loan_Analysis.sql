# Bank Loan Analysis — SQL Queries
# Tool: MySQL Workbench
# Database: bank_loan_db
# Dataset: Financial Loan (38,576 records)
# Author: Pranjal Waim
# Date: June 2026

CREATE DATABASE bank_loan_db;
USE bank_loan_db;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

CREATE TABLE financial_loan (
    id INT,
    address_state VARCHAR(50),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(100),
    grade VARCHAR(10),
    home_ownership VARCHAR(50),
    issue_date VARCHAR(20),
    last_credit_pull_date VARCHAR(20),
    last_payment_date VARCHAR(20),
    loan_status VARCHAR(50),
    next_payment_date VARCHAR(20),
    member_id INT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(10),
    term VARCHAR(20),
    verification_status VARCHAR(50),
    annual_income FLOAT,
    dti FLOAT,
    installment FLOAT,
    int_rate FLOAT,
    loan_amount INT,
    total_acc INT,
    total_payment INT
);

LOAD DATA LOCAL INFILE 'C:/Users/PRANJAL/Downloads/financial_loan.csv'
INTO TABLE financial_loan
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM financial_loan;

SELECT COUNT(id) AS Total_Loan_Applications 
FROM financial_loan;

SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM financial_loan;

SELECT SUM(total_payment) AS Total_Amount_Received 
FROM financial_loan;

SELECT ROUND(AVG(int_rate) * 100, 2) AS Avg_Interest_Rate 
FROM financial_loan;

SELECT ROUND(AVG(dti) * 100, 2) AS Avg_DTI 
FROM financial_loan;

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Current');

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM financial_loan
WHERE loan_status = 'Charged Off';

-- Good Loan Percentage
SELECT ROUND(COUNT(CASE WHEN loan_status IN ('Fully Paid','Current') 
THEN id END) * 100.0 / COUNT(id), 2) AS Good_Loan_Percentage
FROM financial_loan;

-- Bad Loan Percentage
SELECT ROUND(COUNT(CASE WHEN loan_status = 'Charged Off' 
THEN id END) * 100.0 / COUNT(id), 2) AS Bad_Loan_Percentage
FROM financial_loan;

-- Loan Status Summary
SELECT 
    loan_status,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded,
    SUM(total_payment) AS Total_Received
FROM financial_loan
GROUP BY loan_status;

-- Monthly Trend
SELECT 
    MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) AS Month_Number,
    MONTHNAME(STR_TO_DATE(issue_date, '%d-%m-%Y')) AS Month_Name,
    COUNT(id) AS Total_Applications
FROM financial_loan
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number;

-- Loan by Purpose
SELECT 
    purpose,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded
FROM financial_loan
GROUP BY purpose
ORDER BY Total_Applications DESC;

-- Loan by Grade
SELECT 
    grade,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded
FROM financial_loan
GROUP BY grade
ORDER BY grade;