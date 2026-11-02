-- Import the three CSV files with MySQL Workbench Table Data Import Wizard.
-- Import borrowers.csv first, loans.csv second, repayments.csv third.
-- Ensure date columns are parsed as DATE and default_flag as TINYINT.
USE credit_risk_project;
SELECT COUNT(*) AS borrower_rows FROM borrowers;
SELECT COUNT(*) AS loan_rows FROM loans;
SELECT COUNT(*) AS repayment_rows FROM repayments;
