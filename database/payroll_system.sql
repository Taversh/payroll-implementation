CREATE DATABASE payroll_system;

USE payroll_system;

-- Employees Table Structure
CREATE TABLE employees(
	empID int NOT NULL PRIMARY KEY,
    firstName varchar(255) NOT NULL,
    lastName varchar(255) NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    house_address varchar(255) NULL,
    date_of_birth date NOT NULL,
    nin varchar(30) NULL UNIQUE
    );
    
-- User Table Structure
CREATE TABLE user_account(
	userID int NOT NULL PRIMARY KEY,
	Username varchar(255) NOT NULL UNIQUE,
    pass_word varchar(255) NOT NULL, 
    user_role varchar(40) NOT NULL
    );
    
-- Payroll Table Structure
CREATE TABLE payroll(
	payrollID int NOT NULL PRIMARY KEY,
    payroll_period date NOT NULL,
    start_date datetime,
    end_date datetime,
    stats varchar(30) NOT NULL
    );
    
-- Salary Table Structure
CREATE TABLE salary(
	salaryID int NOT NULL PRIMARY KEY,
    empID int NOT NULL,
    FOREIGN KEY (empID) REFERENCES employees(empid),
    monthlySalary int NOT NULL,
    yearlyBonus int NULL,
    taxInfo int NOT NULL
    );
    
-- Tax Table Structure
CREATE TABLE tax(
	taxID int NOT NULL PRIMARY KEY,
	empID int NOT NULL, 
    taxYear datetime, 
    tax_filing_status varchar(20) NOT NULL,
    tax_withholding_details varchar(30) NULL
    );

-- Creation of Foreign Key
ALTER TABLE tax ADD FOREIGN KEY (empID) REFERENCES employees(empID);

-- Benefits Table Structure
CREATE TABLE benefits(
	benefitsID int NOT NULL PRIMARY KEY,
    empID int NOT NULL,
    benefit_type varchar(20) NULL,
    benefit_details varchar(30) NULL,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
SHOW TABLES;

-- Pay History Table Structure
CREATE TABLE pay_history(
	payID int NOT NULL PRIMARY KEY,
    empID int NOT NULL,
    paymentDate timestamp NOT NULL,
    grossPay int NOT NULL,
    netPay int NOT NULL,
    deductions int NULL, 
    tax_withholding varchar(30) NULL,
    payment_method varchar(20) NOT NULL,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
-- Office logs Table Structure
CREATE TABLE office_logs(
	attendanceID int NOT NULL PRIMARY KEY,
	empID int NOT NULL,
    datelogged date NOT NULL,
    hoursworked time,
    overtime_hours time,
    timeoff time,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
-- Job Info Table Structure
CREATE TABLE job_info(
	job_unique_key int NOT NULL PRIMARY KEY,
    jobID int NOT NULL,
    empID int NOT NULL,
    jobTitle varchar(255) NOT NULL,
    department varchar(255) NOT NULL,
    hire_date timestamp NOT NULL,
    termination_date timestamp NOT NULL,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
SHOW TABLES;

DESCRIBE office_logs;

-- Admin Table Structure
CREATE TABLE administrator(
	adminID int NOT NULL PRIMARY KEY,
    userID int NOT NULL,
    pass_word varchar(255) NOT NULL,
    FOREIGN KEY (userID) REFERENCES user_account(userID)
    );