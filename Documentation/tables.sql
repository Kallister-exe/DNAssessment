DROP DATABASE IF EXISTS `dbproj`;
CREATE DATABASE dbproj;
USE `dbproj`;

## TABLES CREATE
DROP TABLE IF EXISTS `Locations`;
CREATE TABLE Locations (
    location varchar(20) NOT NULL PRIMARY KEY,
    CONSTRAINT UniqueL UNIQUE (location)
);
DROP TABLE IF EXISTS `Phones`;
CREATE TABLE Phones (
    Phone varchar(25) NOT NULL PRIMARY KEY,
    CONSTRAINT UniquePh UNIQUE (Phone)
);
DROP TABLE IF EXISTS `Positions`;
CREATE TABLE Positions (
    Position varchar(40) NOT NULL PRIMARY KEY,
    CONSTRAINT UniqueP UNIQUE (Position)
);
DROP TABLE IF EXISTS `Emails`;
CREATE TABLE Emails (
    Email varchar(50) NOT NULL PRIMARY KEY,
    CONSTRAINT UniqueE UNIQUE (Email)
);
DROP TABLE IF EXISTS `Logins`;
CREATE TABLE Logins (
    LoginID varchar(10) NOT NULL PRIMARY KEY,
    CONSTRAINT UniqueLID UNIQUE (LoginID)
);
DROP TABLE IF EXISTS `Users`;
CREATE TABLE Users (
	UserID varchar(10) NOT NULL PRIMARY KEY,
	LoginID varchar(10),
    Surname varchar(40),
    Forenames varchar(50) NOT NULL DEFAULT '',
    Title varchar(55) NOT NULL,
    Phone varchar(25),
    location varchar(10) NOT NULL,
    CONSTRAINT UniqueIDs UNIQUE (UserID),
    FOREIGN KEY (location) REFERENCES Locations(location),
    FOREIGN KEY (LoginID) REFERENCES Logins(LoginID),
    FOREIGN KEY (Phone) REFERENCES Phones(Phone)
);
DROP TABLE IF EXISTS `UserEmails`;
CREATE TABLE UserEmails (
    UserID varchar(10) NOT NULL,
    Email varchar(50) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (Email) REFERENCES Emails(Email),
    CONSTRAINT COMPOSITE_KEY_NAME PRIMARY KEY (UserID, Email)
);
DROP TABLE IF EXISTS `UserPositions`;
CREATE TABLE UserPositions (
    UserID varchar(10) NOT NULL,
    Position varchar(40) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (Position) REFERENCES Positions(Position),
    CONSTRAINT COMPOSITE_KEY_NAME PRIMARY KEY (UserID, Position)
);
DROP TABLE IF EXISTS `UserLogins`;
CREATE TABLE UserLogins (
    UserID varchar(10) NOT NULL,
    LoginID varchar(10) NOT NULL ,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (LoginID) REFERENCES Logins(LoginID),
    CONSTRAINT COMPOSITE_KEY_NAME PRIMARY KEY (UserID, LoginID)
);