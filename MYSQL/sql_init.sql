DROP DATABASE MEETGREET; -- Remove any pre-existing MeetGreet Databases.

CREATE DATABASE MEETGREET;

USE MEETGREET;

CREATE TABLE User (
    ID int PRIMARY KEY AUTO_INCREMENT,
    Email varchar(255) NOT NULL,
    IsEmailVerified bit NOT NULL,
    Password varchar(255) NOT NULL,
    DateCreated datetime NOT NULL,
    GeoLocation varchar(255) NOT NULL
);

CREATE TABLE Event (
    ID int PRIMARY KEY AUTO_INCREMENT,
    Title varchar(255) NOT NULL,
    CreatedAt datetime DEFAULT NOW() NOT NULL,
    CreatedByUserID int NOT NULL,
    Description varchar(255) NOT NULL,
    GeoLocation varchar(255) NOT NULL,
    ScheduledDateTime datetime NOT NULL,
    FOREIGN KEY (CreatedByUserID) REFERENCES User(ID)
);

CREATE TABLE AttendingIndication (
    ID int PRIMARY KEY,
    UserID int NOT NULL,
    EventID int NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(ID),
    FOREIGN KEY (EventID) REFERENCES Event(ID)
);

CREATE TABLE StaffMemberRelations (
    ID int PRIMARY KEY,
    UserID int NOT NULL,
    EventID int NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(ID),
    FOREIGN KEY (EventID) REFERENCES Event(ID)
);

INSERT INTO User (Email, IsEmailVerified, Password, DateCreated, GeoLocation) VALUES ("baffog@wit.edu", 1, "####", NOW(), "-80.89390, 133.03446");
INSERT INTO Event (Title, CreatedByUserID, Description, GeoLocation, ScheduledDateTime) VALUES ("Opening Day For Comm Ave Center", 1, "Come celebrate our opening day. Free sandwich for all attendees.", "-80.89390, 133.03446", "2023-03-20 15:45:33");