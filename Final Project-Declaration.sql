## ============================
## Gradebook Database v1.0
## ----------------------------
## Created by: Sicheng Xue
## ============================
## Changelog:
## 241106 - Initial Release
##


DROP DATABASE IF EXISTS Gradebook;
CREATE DATABASE IF NOT EXISTS Gradebook;
USE Gradebook;

CREATE TABLE IF NOT EXISTS PEOPLE (
	PersonID int auto_increment,
	UserType varchar(10) not null,
	SSN char(9),
	FirstName varchar(25) not null,
	MiddleNames varchar(100),
	LastName varchar(100) not null,
	Suffix varchar(15),
	Honorific varchar(150),
	PreferredName varchar(25),
	Gender varchar(7),
	Pronouns varchar(4),
	ContactEmail varchar(100) not null,
	ContactPhone varchar(20) not null,
	City varchar(45),
	Zip9 int,
	State varchar(2),
	AptNum varchar(25),
	StreetAddress varchar(45),
	Primary key(PersonID)
);

create table if not exists Class (
	ClassID	int auto_increment,
   	ClassName	varchar(45) not null,
   	OfferedYear	smallint,
   	OfferedSem	varchar(15),
	Primary Key (ClassID),
	Unique Key ClassOffering (ClassName, OfferedYear, OfferedSem)
) ;

create table if not exists Section (
	SectionID	int auto_increment,
	SectionName varchar(7),
	Location	varchar(20),
	Primary Key (SectionID)
) ;

#Relationship Intermediate Tables

CREATE TABLE IF NOT EXISTS Login (
	PersonID int auto_increment ,
    PersonName varchar(50) not null ,
    PassWord varchar(64) not null ,
    Primary Key (PersonID)
);

CREATE TABLE IF NOT EXISTS Instructor (
	InstructorID int auto_increment ,
    PersonID int not null ,
    SectionID int not null ,
	SectionName varchar(7) ,
    Primary Key (InstructorID),
    Unique Key InstructorSectionRecord (PersonID, SectionID)
);

CREATE TABLE IF NOT EXISTS InstructorOfRecord (
	InstructorRecID int auto_increment ,
    PersonID int not null ,
    ClassID int not null ,
    Primary Key (InstructorRecID),
    Unique Key InstructorClassRecord (PersonID, ClassID)
);

CREATE TABLE IF NOT EXISTS ClassSection (
	ClassSecID int auto_increment ,
    ClassID int not null ,
    SectionID int not null ,
    Primary Key (ClassSecID),
    Unique Key ClassSectionRecord (ClassID, SectionID)
);

CREATE TABLE IF NOT EXISTS Grade (
	GradeID int auto_increment ,
	Grade varchar(5) ,
	PersonID int not null ,
	ClassID int not null ,
	SectionID int not null ,
	InstructorID int not null ,
	InstructorOfRecordID int not null ,
	Primary Key (GradeID),
	Unique Key StudentClassSectionGrade (PersonID, ClassID, SectionID)
);

INSERT INTO PEOPLE (PersonID, UserType, SSN, FirstName, MiddleNames, LastName, Suffix, Honorific, PreferredName, Gender, Pronouns, ContactEmail, ContactPhone, City, Zip9, State, AptNum, StreetAddress)
VALUES (1, 'Student', '000000000', 'Sam', null, 'Xue', null, null, null, 'M', null, 'example@gmail.com', '0000000000', 'Champaign', 61820, 'IL', null, null);

SELECT * FROM PEOPLE;
