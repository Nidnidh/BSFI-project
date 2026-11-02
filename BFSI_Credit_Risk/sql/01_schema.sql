-- Run in MySQL 8+
CREATE DATABASE IF NOT EXISTS credit_risk_project;
USE credit_risk_project;

CREATE TABLE borrowers (
  borrower_id VARCHAR(10) PRIMARY KEY,
  age INT,
  annual_income DECIMAL(12,2),
  employment_type VARCHAR(30),
  credit_score INT,
  city_tier VARCHAR(10),
  existing_loans INT
);

CREATE TABLE loans (
  loan_id VARCHAR(10) PRIMARY KEY,
  borrower_id VARCHAR(10),
  loan_type VARCHAR(30),
  loan_amount DECIMAL(14,2),
  annual_interest_rate_pct DECIMAL(5,2),
  tenure_months INT,
  application_date DATE,
  loan_status VARCHAR(20),
  default_flag TINYINT,
  FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id)
);

CREATE TABLE repayments (
  repayment_id VARCHAR(12) PRIMARY KEY,
  loan_id VARCHAR(10),
  due_date DATE,
  amount_due DECIMAL(12,2),
  amount_paid DECIMAL(12,2),
  days_past_due INT,
  payment_status VARCHAR(20),
  FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
