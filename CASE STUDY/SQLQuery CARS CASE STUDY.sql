--CASE STUDY : CRIME ANALYSIS AND REPORTING SYSTEM

CREATE DATABASE CARS;
USE CARS;

-- Create the Victims table
CREATE TABLE Victims (
    VictimID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
    ContactInfo VARCHAR(255)
);

-- Create the Suspects table
CREATE TABLE Suspects (
    SuspectID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
    ContactInfo VARCHAR(255)
);

-- Create the Incidents table
CREATE TABLE Incidents (
    IncidentID INT PRIMARY KEY IDENTITY(1,1),
    IncidentType VARCHAR(50),
    IncidentDate DATE,
    Location GEOGRAPHY, 
    Description TEXT,
    Status VARCHAR(20),
    VictimID INT,
    SuspectID INT,
    FOREIGN KEY (VictimID) REFERENCES Victims(VictimID),
    FOREIGN KEY (SuspectID) REFERENCES Suspects(SuspectID)
);

-- Create the Law Enforcement Agencies table
CREATE TABLE LawEnforcementAgencies (
    AgencyID INT PRIMARY KEY IDENTITY(1,1),
    AgencyName VARCHAR(100),
    Jurisdiction VARCHAR(100),
    ContactInfo VARCHAR(255),
	Officers VARCHAR(100) 
);

-- Create the Officers table
CREATE TABLE Officers (
    OfficerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BadgeNumber VARCHAR(20),
    Rank VARCHAR(50),
    ContactInfo VARCHAR(255),
    AgencyID INT,
    FOREIGN KEY (AgencyID) REFERENCES LawEnforcementAgencies(AgencyID)
);

-- Create the Evidence table
CREATE TABLE Evidence (
    EvidenceID INT PRIMARY KEY IDENTITY(1,1),
    Description TEXT,
    LocationFound VARCHAR(255),
    IncidentID INT,
    FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);

-- Create the Reports table
CREATE TABLE Reports (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    IncidentID INT,
    ReportingOfficer INT,
    ReportDate DATE,
    ReportDetails TEXT,
    Status VARCHAR(20),
    FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID),
    FOREIGN KEY (ReportingOfficer) REFERENCES Officers(OfficerID)
);

-- Inserting sample values
--INSERT INTO VICTIMS TABLE
INSERT INTO Victims (FirstName, LastName, DateOfBirth, Gender, ContactInfo)
VALUES
('Ravi', 'Shankar', '1985-07-12', 'M', '12 Gandhi St, Chennai, Tamil Nadu, 9876543210'),
('Meena', 'Kumari', '1990-06-22', 'F', '45 Nehru St, Madurai, Tamil Nadu, 9876543211'),
('Vignesh', 'Raj', '1987-05-30', 'M', '78 MG Road, Coimbatore, Tamil Nadu, 9876543212'),
('Priya', 'Darshini', '1991-04-05', 'F', '23 Anna Nagar, Trichy, Tamil Nadu, 9876543213'),
('Karthik', 'S', '1988-03-15', 'M', '67 KK Nagar, Tirunelveli, Tamil Nadu, 9876543214'),
('Arun', 'Kumar', '1992-08-20', 'M', '90 Thiru Nagar, Salem, Tamil Nadu, 9876543215'),
('Lakshmi', 'Ravi', '1985-01-19', 'F', '78 ECR, Vellore, Tamil Nadu, 9876543216'),
('Sowmiya', 'Selvan', '1993-09-25', 'F', '54 MG Road, Erode, Tamil Nadu, 9876543217'),
('Mohan', 'Raj', '1980-02-17', 'M', '15 TVS Nagar, Dindigul, Tamil Nadu, 9876543218'),
('Anbu', 'Selvan', '1989-11-11', 'M', '89 Nehru St, Thoothukudi, Tamil Nadu, 9876543219');
SELECT *FROM Victims;

--INSERT INTO SUSPECTS TABLE
INSERT INTO Suspects (FirstName, LastName, DateOfBirth, Gender, ContactInfo)
VALUES
('Vijay', 'Kumar', '1983-05-18', 'M', '34 RK Road, Chennai, Tamil Nadu, 9876543220'),
('Ramesh', 'Shankar', '1990-10-12', 'M', '89 KK Nagar, Madurai, Tamil Nadu, 9876543221'),
('Deepa', 'Venkat', '1987-03-21', 'F', '12 MG Road, Coimbatore, Tamil Nadu, 9876543222'),
('Raj', 'Mohan', '1984-06-24', 'M', '45 Anna Nagar, Trichy, Tamil Nadu, 9876543223'),
('Bala', 'Murugan', '1991-09-10', 'M', '101 Thiru Nagar, Tirunelveli, Tamil Nadu, 9876543224'),
('Meena', 'Kumar', '1995-12-12', 'F', '67 Ooty Road, Salem, Tamil Nadu, 9876543225'),
('Arun', 'Selvan', '1986-02-14', 'M', '90 MG Road, Vellore, Tamil Nadu, 9876543226'),
('Suresh', 'Raj', '1992-04-08', 'M', '89 Nehru St, Erode, Tamil Nadu, 9876543227'),
('Anbu', 'Krishnan', '1981-08-25', 'M', '23 KK Nagar, Dindigul, Tamil Nadu, 9876543228'),
('Vignesh', 'Selvan', '1990-06-19', 'M', '54 TVS Nagar, Thoothukudi, Tamil Nadu, 9876543229');
SELECT *FROM Suspects;


--INSERT INTO LAWENFORCEMENTAGENCIES TABLE
INSERT INTO LawEnforcementAgencies (AgencyName, Jurisdiction, ContactInfo, Officers)
VALUES
('Chennai Police Department', 'Chennai', '044-2561-5010', 'Inspector Suresh Kumar'),
('Madurai City Police', 'Madurai', '0452-2533-535', 'Inspector Ramesh Shankar'),
('Coimbatore Police Department', 'Coimbatore', '0422-2394-571', 'Sub-Inspector Vijay Kumar'),
('Trichy Police Department', 'Trichy', '0431-2333-333', 'Inspector Priya Darshini'),
('Tirunelveli Police', 'Tirunelveli', '0462-2334-455', 'Inspector Arun Kumar'),
('Salem City Police', 'Salem', '0427-2413-111', 'Sub-Inspector Karthik S'),
('Vellore Police', 'Vellore', '0416-2223-334', 'Inspector Mohan Raj'),
('Erode Police Department', 'Erode', '0424-2223-456', 'Sub-Inspector Lakshmi Ravi'),
('Dindigul Police', 'Dindigul', '0451-2445-678', 'Inspector Bala Murugan'),
('Thoothukudi Police', 'Thoothukudi', '0461-2345-678', 'Inspector Anbu Selvan');
select *from LawEnforcementAgencies;

--INSERT INTO OFFICERS TABLE
INSERT INTO Officers (FirstName, LastName, BadgeNumber, Rank, ContactInfo, AgencyID)
VALUES
('Suresh', 'Kumar', 'TN001', 'Inspector', '044-2561-5011', 1),
('Ramesh', 'Shankar', 'TN002', 'Inspector', '0452-2533-536', 2),
('Vijay', 'Kumar', 'TN003', 'Sub-Inspector', '0422-2394-572', 3),
('Priya', 'Darshini', 'TN004', 'Inspector', '0431-2333-334', 4),
('Arun', 'Kumar', 'TN005', 'Inspector', '0462-2334-456', 5),
('Karthik', 'S', 'TN006', 'Sub-Inspector', '0427-2413-112', 6),
('Mohan', 'Raj', 'TN007', 'Inspector', '0416-2223-335', 7),
('Lakshmi', 'Ravi', 'TN008', 'Sub-Inspector', '0424-2223-457', 8),
('Bala', 'Murugan', 'TN009', 'Inspector', '0451-2445-679', 9),
('Anbu', 'Selvan', 'TN010', 'Inspector', '0461-2345-679', 10);
select *from Officers;

--INSERT INTO INCIDENTS TABLE
INSERT INTO Incidents (IncidentType, IncidentDate, Location, Description, Status, VictimID, SuspectID)
VALUES
('Theft', '2023-02-15', geography::STGeomFromText('POINT(13.0827 80.2707)', 4326), 'Stolen wallet at Marina Beach', 'Closed', 1, 1),
('Robbery', '2023-03-10', geography::STGeomFromText('POINT(9.9252 78.1198)', 4326), 'Robbery in Madurai Market', 'Open', 2, 2),
('Homicide', '2023-04-25', geography::STGeomFromText('POINT(11.0168 76.9558)', 4326), 'Murder in Coimbatore', 'Under Investigation', 3, 3),
('Burglary', '2023-05-05', geography::STGeomFromText('POINT(10.7905 78.7047)', 4326), 'House break-in in Trichy', 'Closed', 4, 4),
('Fraud', '2023-06-11', geography::STGeomFromText('POINT(11.6643 78.1460)', 4326), 'Financial fraud in Salem', 'Open', 5, 5),
('Assault', '2023-07-15', geography::STGeomFromText('POINT(8.7139 77.7567)', 4326), 'Assault in Tirunelveli', 'Under Investigation', 6, 6),
('Drug Trafficking', '2023-08-20', geography::STGeomFromText('POINT(12.9200 79.1333)', 4326), 'Drug case in Vellore', 'Closed', 7, 7),
('Arson', '2023-09-12', geography::STGeomFromText('POINT(11.3410 77.7172)', 4326), 'Arson in Erode', 'Under Investigation', 8, 8),
('Kidnapping', '2023-10-07', geography::STGeomFromText('POINT(10.3689 77.9804)', 4326), 'Kidnapping in Dindigul', 'Closed', 9, 9),
('Cybercrime', '2023-11-01', geography::STGeomFromText('POINT(8.7642 78.1348)', 4326), 'Online fraud in Thoothukudi', 'Open', 10, 10);
select *from Incidents;

--INSERT INTO EVIDENCE TABLE
INSERT INTO Evidence (Description, LocationFound, IncidentID)
VALUES
('Wallet with ID card', 'Marina Beach', 1),
('Gold chain', 'Madurai Market', 2),
('Blood-stained knife', 'Coimbatore', 3),
('Broken window glass', 'Trichy', 4),
('Fake financial documents', 'Salem', 5),
('Bat with fingerprints', 'Tirunelveli', 6),
('Syringe with residue', 'Vellore', 7),
('Gasoline canister', 'Erode', 8),
('Rope with knots', 'Dindigul', 9),
('Hacked email logs', 'Thoothukudi', 10);
select *from Evidence;

INSERT INTO Reports (IncidentID, ReportingOfficer, ReportDate, ReportDetails, Status)
VALUES
(1, 1, '2023-02-20', 'Theft at Marina Beach, suspect caught.', 'Finalized'),
(2, 2, '2023-03-15', 'Robbery in Madurai Market, suspect identified.', 'Draft'),
(3, 3, '2023-04-30', 'Homicide in Coimbatore, under investigation.', 'Under Review'),
(4, 4, '2023-05-10', 'Burglary in Trichy, case closed.', 'Finalized'),
(5, 5, '2023-06-18', 'Fraud in Salem, suspect at large.', 'Draft'),
(6, 6, '2023-07-20', 'Assault in Tirunelveli, suspect under custody.', 'Under Review'),
(7, 7, '2023-08-25', 'Drug trafficking in Vellore, evidence collected.', 'Finalized'),
(8, 8, '2023-09-15', 'Arson in Erode, ongoing investigation.', 'Draft'),
(9, 9, '2023-10-12', 'Kidnapping in Dindigul, victim rescued.', 'Finalized'),
(10, 10, '2023-11-05', 'Cybercrime in Thoothukudi, suspect identified.', 'Under Review');
select *from Reports;
