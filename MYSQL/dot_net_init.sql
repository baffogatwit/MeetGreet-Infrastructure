CREATE DATABASE MEETGREET;

USE MEETGREET;

CREATE TABLE User (
    Id VARCHAR(450) NOT NULL,
    UserName VARCHAR(256) DEFAULT NULL,
    NormalizedUserName VARCHAR(256) DEFAULT NULL,
    Email VARCHAR (256)  DEFAULT  NULL,
    NormalizedEmail VARCHAR(256) DEFAULT NULL,
    EmailConfirmed BIT NOT NULL,
    PasswordHash VARCHAR(800) DEFAULT NULL,
    RememberMe BIT NOT NULL DEFAULT 0,
    SecurityStamp VARCHAR(800) DEFAULT  NULL,
    ConcurrencyStamp VARCHAR(800) DEFAULT  NULL,
    PhoneNumber VARCHAR(800) DEFAULT NULL,
    PhoneNumberConfirmed BIT NOT NULL,
    TwoFactorEnabled BIT NOT NULL,
    LockoutEnd TIMESTAMP NULL,
    LockoutEnabled BIT NOT NULL,
    AccessFailedCount INT NOT NULL,
    CONSTRAINT User PRIMARY KEY CLUSTERED (Id ASC)
);


CREATE TABLE UserClaims (
    Id         INT NOT NULL,
    UserId     VARCHAR (450) NOT NULL,
    ClaimType  VARCHAR (450) NULL,
    ClaimValue VARCHAR (450) NULL,
    CONSTRAINT UserClaims PRIMARY KEY CLUSTERED (Id ASC),
    CONSTRAINT UserClaims_Users_UserId FOREIGN KEY (UserId) REFERENCES User (Id) ON DELETE CASCADE
);


CREATE TABLE UserLogins (
    LoginProvider       VARCHAR (128) NOT NULL,
    ProviderKey         VARCHAR (128) NOT NULL,
    ProviderDisplayName VARCHAR (800) NULL,
    UserId              VARCHAR (450) NOT NULL,
    CONSTRAINT AspNetUserLogins PRIMARY KEY (LoginProvider, ProviderKey),
    CONSTRAINT AspNetUserLogins_AspNetUsers_UserId FOREIGN KEY (UserId) REFERENCES User (Id) ON DELETE CASCADE
);


CREATE TABLE UserTokens (
    UserId        VARCHAR (450) NOT NULL,
    LoginProvider VARCHAR (128) NOT NULL,
    Name          VARCHAR (128) NOT NULL,
    Value         VARCHAR (255) NULL,
    CONSTRAINT UserTokens PRIMARY KEY CLUSTERED (UserId ASC, LoginProvider ASC, Name ASC),
    CONSTRAINT UserTokens_User_UserId FOREIGN KEY (UserId) REFERENCES User (Id) ON DELETE CASCADE
);


-- Event, Events
CREATE TABLE Event (
    Id int PRIMARY KEY AUTO_INCREMENT,
    Title varchar(500) NOT NULL,
    CreatedAt datetime DEFAULT NOW() NOT NULL,
    CreatedByUserId VARCHAR(450) NOT NULL,
    Description varchar(500) NOT NULL,
    GeoLocation_Longitude DOUBLE NOT NULL,
    GeoLocation_Latitude DOUBLE NOT NULL,
    ZipCode varchar(500) NOT NULL,
    City varchar(500) NOT NULL,
    Address varchar(500) NOT NULL,
    ScheduledDateTime datetime NOT NULL,
    Radius int,
    FOREIGN KEY (CreatedByUserId) REFERENCES User(Id)
);

-- Attending - 0, Interested - 1, Not Attending - 2
CREATE TABLE AttendingIndication (
    ID int PRIMARY KEY AUTO_INCREMENT,
    UserID VARCHAR(450) NOT NULL,
    EventID int NOT NULL,
    Status int NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(Id),
    FOREIGN KEY (EventID) REFERENCES Event(Id)
);

CREATE TABLE Image (
    Id int PRIMARY KEY AUTO_INCREMENT,
    EventId int NOT NULL,
    S3Key varchar(2083) NOT NULL,
    FOREIGN KEY (EventId) REFERENCES Event(Id)
);

CREATE TABLE EmailAPIKey (
    Id int PRIMARY KEY AUTO_INCREMENT,
    APIKey varchar(255)
);


CREATE TABLE AWSAPIKey (
    Id int PRIMARY KEY AUTO_INCREMENT,
    AccessKey varchar(500),
    SecretAccessKey varchar(500)
);

INSERT INTO EmailAPIKey (APIKey) VALUES ("[VALUE-REDACTED]");
INSERT INTO AWSAPIKey (AccessKey, SecretAccessKey) VALUES ("[VALUE-REDACTED]", "[VALUE-REDACTED]");