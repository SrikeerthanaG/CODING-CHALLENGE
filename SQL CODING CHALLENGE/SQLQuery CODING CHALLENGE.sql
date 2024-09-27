-- SQL CODING CHALLENGE

--Tasks:
--1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”. 
--2. Create tables for Companies, Jobs, Applicants and Applications. 
--3. Define appropriate primary keys, foreign keys, and constraints. 
--4. Ensure the script handles potential errors, such as if the database or tables already exist.

-- Create the CareerHub database (only if not exists)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'CareerHub')
CREATE DATABASE CareerHub;

-- Use the CareerHub database
USE CareerHub;

-- Creating the Companies Table with error handling
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Companies' AND xtype='U')
CREATE TABLE Companies (
    CompanyID INT IDENTITY(1,1) PRIMARY KEY, 
    CompanyName VARCHAR(255),
    Location VARCHAR(255)
);

-- Creating the Jobs Table with error handling
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Jobs' AND xtype='U')
CREATE TABLE Jobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY, 
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    JobTitle VARCHAR(255),
    JobDescription TEXT,
    JobLocation VARCHAR(255),
    Salary DECIMAL(10, 2),
    JobType VARCHAR(50),
    PostedDate DATETIME
);

-- Creating the Applicants Table with IDENTITY and error handling
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Applicants' AND xtype='U')
CREATE TABLE Applicants (
    ApplicantID INT IDENTITY(1,1) PRIMARY KEY, 
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(50),
    Resume TEXT
);

-- Creating the Applications Table with error handling
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Applications' AND xtype='U')
CREATE TABLE Applications (
    ApplicationID INT IDENTITY(1,1) PRIMARY KEY, 
    JobID INT FOREIGN KEY REFERENCES Jobs(JobID),
    ApplicantID INT FOREIGN KEY REFERENCES Applicants(ApplicantID),
    ApplicationDate DATETIME,
    CoverLetter TEXT
);
--Insert Sample Values Into The Tables
INSERT INTO Companies (CompanyName, Location)
VALUES
('Intellect', 'Chennai'),
('Flex', 'Coimbatore'),
('Amazon', 'Bangalore'),
('Barclays', 'Chennai'),
('TCS', 'Chennai'),
('Wipro', 'Salem'),
('Hexaware Technologies', 'Chennai'),
('Accenture', 'Bangalore'),
('Tech Mahindra', 'Coimbatore'),
('Azentio', 'Chennai');
SELECT *FROM Companies;

INSERT INTO Jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate)
VALUES
(1, 'Software Developer', 'Developing and maintaining software solutions', 'Chennai', 85000, 'Full-time', '2024-01-15'),
(2, 'Project Manager', 'Managing projects and teams in hardware solutions', 'Coimbatore', 120000, 'Full-time', '2024-02-01'),
(3, 'Cloud Engineer', 'Handling cloud architecture and infrastructure', 'Bangalore', 150000, 'Full-time', '2024-02-15'),
(4, 'Data Analyst', 'Analyzing and interpreting complex data sets', 'Chennai', 90000, 'Full-time', '2024-03-01'),
(5, 'Software Architect', 'Designing large-scale software architectures', 'Chennai', 140000, 'Full-time', '2024-03-10'),
(6, 'IT Support Specialist', 'Providing technical support for systems', 'Salem', 70000, 'Part-time', '2024-03-20'),
(7, 'Business Analyst', 'Analyzing business processes and systems', 'Chennai', 95000, 'Full-time', '2024-04-01'),
(8, 'DevOps Engineer', 'Maintaining deployment pipelines and CI/CD systems', 'Bangalore', 130000, 'Full-time', '2024-04-15'),
(9, 'Network Engineer', 'Managing and maintaining networks', 'Coimbatore', 80000, 'Full-time', '2024-04-25'),
(10, 'Full Stack Developer', 'Developing front-end and back-end applications', 'Chennai', 100000, 'Full-time', '2024-05-01');
SELECT *FROM Jobs;

INSERT INTO Applicants (FirstName, LastName, Email, Phone, Resume)
VALUES
('Arun', 'Kumar', 'arun.kumar@gmail.com', '9876543210', 'Resume submitted via email'),
('Priya', 'Ravi', 'priya.ravi@gmail.com', '9876543211', 'Resume submitted via email'),
('Suresh', 'Nair', 'suresh.nair@gmail.com', '9876543212', 'Resume submitted via email'),
('Deepa', 'Venkat', 'deepa.venkat@gmail.com', '9876543213', 'Resume submitted via email'),
('Mohan', 'Raj', 'mohan.raj@gmail.com', '9876543214', 'Resume submitted via email'),
('Samantha', 'James', 'samantha.james@gmail.com', '9876543215', 'Resume submitted via email'),
('Karthik', 'Sundar', 'karthik.sundar@gmail.com', '9876543216', 'Resume submitted via email'),
('Divya', 'Shankar', 'divya.shankar@gmail.com', '9876543217', 'Resume submitted via email'),
('Manoj', 'Krishnan', 'manoj.krishnan@gmail.com', '9876543218', 'Resume submitted via email'),
('Lakshmi', 'Narayanan', 'lakshmi.narayanan@gmail.com', '9876543219', 'Resume submitted via email');
SELECT *FROM Applicants;

INSERT INTO Applications (JobID, ApplicantID, ApplicationDate, CoverLetter)
VALUES
(1, 1, '2024-01-20', 'I am excited to apply for the Software Developer position at Intellect.'),
(2, 2, '2024-02-05', 'I believe my experience as a Project Manager at Flex makes me a great fit.'),
(3, 3, '2024-02-20', 'As a Cloud Engineer, I am eager to contribute to Amazon’s innovative projects.'),
(4, 4, '2024-03-05', 'I am passionate about data analysis and would love to work with Barclays.'),
(5, 5, '2024-03-15', 'My background in software architecture aligns with the goals at TCS.'),
(6, 6, '2024-03-25', 'I am eager to leverage my skills in IT support at Wipro.'),
(7, 7, '2024-04-05', 'I am excited to apply for the Business Analyst role at Hexaware Technologies.'),
(8, 8, '2024-04-20', 'With my experience in DevOps, I am ready to contribute to Accenture.'),
(9, 9, '2024-04-30', 'My skills as a Network Engineer will be beneficial at Tech Mahindra.'),
(10, 10, '2024-05-05', 'I am looking forward to developing applications at Azentio as a Full Stack Developer.');
SELECT *FROM Applications;

/*5. Write an SQL query to count the number of applications received for each job listing in the 
"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all 
jobs, even if they have no applications.*/
SELECT j.JobTitle, COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobTitle;

/*6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary 
range. Allow parameters for the minimum and maximum salary values. Display the job title, 
company name, location, and salary for each matching job.*/
-- Declare variables for the minimum and maximum salary range
DECLARE @MinSalary DECIMAL(10, 2) = 60000; 
DECLARE @MaxSalary DECIMAL(10, 2) = 90000; 

-- Query to retrieve job listings within the salary range
SELECT j.JobTitle, c.CompanyName, j.JobLocation, j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN @MinSalary AND @MaxSalary
ORDER BY j.Salary ASC; 

/*7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a 
parameter for the ApplicantID, and return a result set with the job titles, company names, and 
application dates for all the jobs the applicant has applied to.*/-- Declare a parameter for the ApplicantID
DECLARE @ApplicantID INT = 1; 

-- Query to retrieve job application history for a specific applicant
SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a
JOIN Jobs j ON a.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = @ApplicantID
ORDER BY a.ApplicationDate DESC; /*8. Create an SQL query that calculates and displays the average salary offered by all companies for 
job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.*/
SELECT AVG
(CASE
WHEN Salary > 0 THEN Salary 
END) AS AverageSalary
FROM Jobs;/*9. Write an SQL query to identify the company that has posted the most job listings. Display the 
company name along with the count of job listings they have posted. Handle ties if multiple 
companies have the same maximum count.*/-- Find the maximum number of job listings posted by any company
WITH JobCounts AS (
    SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
    FROM Companies c
    JOIN Jobs j ON c.CompanyID = j.CompanyID
    GROUP BY c.CompanyName
)
-- Select all companies that have posted the maximum number of job listings
SELECT CompanyName, JobCount
FROM JobCounts
WHERE JobCount = (SELECT MAX(JobCount) FROM JobCounts);/*10. Find the applicants who have applied for positions in companies located in 'CityX' and have at 
least 3 years of experience*/

--Alter the table Applicants by adding 'ExperienceYears' column 
ALTER TABLE Applicants
ADD ExperienceYears INT;
UPDATE Applicants SET ExperienceYears = 5 WHERE ApplicantID = 1;  
UPDATE Applicants SET ExperienceYears = 3 WHERE ApplicantID = 2;  
UPDATE Applicants SET ExperienceYears = 7 WHERE ApplicantID = 3;  
UPDATE Applicants SET ExperienceYears = 2 WHERE ApplicantID = 4;  
UPDATE Applicants SET ExperienceYears = 4 WHERE ApplicantID = 5;  
UPDATE Applicants SET ExperienceYears = 6 WHERE ApplicantID = 6;  
UPDATE Applicants SET ExperienceYears = 3 WHERE ApplicantID = 7;  
UPDATE Applicants SET ExperienceYears = 8 WHERE ApplicantID = 8;  
UPDATE Applicants SET ExperienceYears = 1 WHERE ApplicantID = 9;  
UPDATE Applicants SET ExperienceYears = 10 WHERE ApplicantID = 10; 
SELECT *FROM Applicants;

DECLARE @City VARCHAR(255) = 'Chennai'; 
SELECT a.FirstName, a.LastName, a.ExperienceYears, c.CompanyName, c.Location
FROM Applications app
JOIN Applicants a ON app.ApplicantID = a.ApplicantID
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = @City AND a.ExperienceYears >= 3;/*11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.*/
SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;

/*12. Find the jobs that have not received any applications.*/
SELECT j.JobTitle
FROM Jobs j
LEFT JOIN Applications app ON j.JobID = app.JobID
WHERE app.ApplicationID IS NULL;

/*13. Retrieve a list of job applicants along with the companies they have applied to and the positions 
they have applied for.*/
SELECT a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applications app
JOIN Applicants a ON app.ApplicantID = a.ApplicantID
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID;

/*14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not 
received any applications.*/
SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyName;

/*15. List all applicants along with the companies and positions they have applied for, including those 
who have not applied.*/
SELECT a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applicants a
LEFT JOIN Applications app ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j ON app.JobID = j.JobID
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID;

/*16. Find companies that have posted jobs with a salary higher than the average salary of all jobs.*/
SELECT DISTINCT c.CompanyName
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs);

/*17. Display a list of applicants with their names and a concatenated string of their city and state*/
ALTER TABLE Applicants
ADD City VARCHAR(255), 
    State VARCHAR(255);
UPDATE Applicants
SET City = CASE 
    WHEN ApplicantID = 1 THEN 'Chennai'
    WHEN ApplicantID = 2 THEN 'Coimbatore'
    WHEN ApplicantID = 3 THEN 'Madurai'
    WHEN ApplicantID = 4 THEN 'Salem'
    WHEN ApplicantID = 5 THEN 'Tiruchirappalli'
    WHEN ApplicantID = 6 THEN 'Tirunelveli'
    WHEN ApplicantID = 7 THEN 'Erode'
    WHEN ApplicantID = 8 THEN 'Vellore'
    WHEN ApplicantID = 9 THEN 'Thoothukudi'
    WHEN ApplicantID = 10 THEN 'Dindigul'
END,
State = 'Tamil Nadu';
SELECT*FROM Applicants;
-- Query to display applicants with a concatenated string of their city and state
SELECT a.FirstName, a.LastName, CONCAT(a.City, ', ', a.State) AS Location
FROM Applicants a;

/*18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.*/
SELECT JobTitle
FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%';

/*19. Retrieve a list of applicants and the jobs they have applied for, including those who have not 
applied and jobs without applicants.*/
SELECT a.FirstName, a.LastName, j.JobTitle
FROM Applicants a
FULL OUTER JOIN Applications app ON a.ApplicantID = app.ApplicantID
FULL OUTER JOIN Jobs j ON app.JobID = j.JobID;

/*20. List all combinations of applicants and companies where the company is in a specific city and the 
applicant has more than 2 years of experience. For example: city=Chennai*/
DECLARE @City VARCHAR(255) = 'Chennai'; 

SELECT a.FirstName, a.LastName, c.CompanyName, c.Location, a.ExperienceYears
FROM Applicants a
CROSS JOIN Companies c
WHERE c.Location = @City AND a.ExperienceYears > 2;