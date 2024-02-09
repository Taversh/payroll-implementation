CREATE DATABASE payroll;

USE payroll;

CREATE TABLE employees(
	empid varchar(25) NOT NULL PRIMARY KEY,
    firstName varchar(255) NOT NULL,
    lastName varchar(255) NOT NULL,
    dateOfBirth date NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    status varchar(15) NOT NULL
    );
    
CREATE TABLE user_accounts(
	userID int NOT NULL PRIMARY KEY,
    empID varchar(25),
	Username varchar(255) NOT NULL UNIQUE,
    pass_word varchar(255) NOT NULL, 
    user_role varchar(40) NOT NULL,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
CREATE TABLE payroll(
	payrollID int NOT NULL PRIMARY KEY,
    empID varchar(25),
    FOREIGN KEY (empID) REFERENCES employees(empID),
    payroll_period date NOT NULL,
    start_date datetime,
    end_date datetime,
    stats varchar(30) NOT NULL
    );
    
CREATE TABLE salary(
	salaryID int NOT NULL PRIMARY KEY,
    empID varchar(25),
    FOREIGN KEY (empID) REFERENCES employees(empID),
    monthlySalary int NOT NULL,
    yearlyBonus int NULL,
    taxInfo int NOT NULL
    );
    
CREATE TABLE tax(
	taxID int NOT NULL PRIMARY KEY,
	empID varchar(25), 
    FOREIGN KEY (empID) REFERENCES employees(empID),
    taxYear datetime, 
    tax_filing_status varchar(20) NOT NULL,
    tax_withholding_details varchar(30) NULL
    );

CREATE TABLE benefits(
	benefitsID int NOT NULL PRIMARY KEY,
    empID varchar(25),
    FOREIGN KEY (empID) REFERENCES employees(empID),
    benefit_type varchar(20) NULL,
    benefit_details varchar(30) NULL,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
SHOW TABLES;

CREATE TABLE pay_history(
	payID int NOT NULL PRIMARY KEY,
    empID varchar(25),
    paymentDate timestamp NOT NULL,
    grossPay int NOT NULL,
    netPay int NOT NULL,
    deductions int NULL, 
    tax_withholding varchar(30) NULL,
    payment_method varchar(20) NOT NULL,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
CREATE TABLE office_logs(
	attendanceID int NOT NULL PRIMARY KEY,
	empID varchar(25),
    datelogged date NOT NULL,
    hoursworked time,
    overtime_hours time,
    timeoff time,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
CREATE TABLE job_info(
	job_unique_key int NOT NULL PRIMARY KEY,
    jobID int NOT NULL,
    empID varchar(25),
    jobTitle varchar(255) NOT NULL,
    department varchar(255) NOT NULL,
    hire_date timestamp NOT NULL,
    termination_date timestamp NOT NULL,
    FOREIGN KEY (empID) REFERENCES employees(empID)
    );
    
SHOW TABLES;