CREATE DATABASE IF NOT EXISTS TEDxCU;
USE TEDxCU;

CREATE TABLE IF NOT EXISTS user_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL  
);

insert into `user_types`(`title`)
values
("Site Administrator"),
("Founder"),
("Head Curator"),
("Curator"),
("Executive"),
("Member"),
("Guest");

CREATE TABLE IF NOT EXISTS generations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    generationPhotoLink TEXT  
);

insert into `generations`(`title`)
values
("Generation I"),
("Generation II"),
("Generation III"),
("Generation IV"),
("Generation V"),
("Generation VI");

CREATE TABLE IF NOT EXISTS divisions(
    id int AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

insert into `divisions`(`title`)
values
("marketing"),
("SM&C"),
("HR"),
("tech"),
("Other");

CREATE TABLE IF NOT EXISTS members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userName VARCHAR(255) NOT NULL UNIQUE,
    userPassword VARCHAR(64) DEFAULT 'asdf1234', #Default password -> SHA256
    firstName VARCHAR(100) DEFAULT 'John',
    lastName VARCHAR(100) DEFAULT 'Doe',
    photo TEXT,
    mobileNumber VARCHAR(11),
    email varchar(100)

);

CREATE TABLE IF NOT EXISTS memberhistory(
    id int AUTO_INCREMENT PRIMARY KEY,
    generation INT NOT NULL,
    memberID INT NOT NULL,
    memberPosition INT NOT NULL,
    memberDivision INT NOT NULL,

    FOREIGN KEY(generation)
    REFERENCES generations(id),
    FOREIGN KEY(memberPosition)
    REFERENCES user_types(id),
    FOREIGN KEY(memberID)
    REFERENCES members(id),
    FOREIGN KEY(memberDivision)
    REFERENCES divisions(id)

);

CREATE TABLE IF NOT EXISTS events(
    id int AUTO_INCREMENT PRIMARY KEY,
    eventName varchar(100) DEFAULT 'UnDefined Yet',
    eventLocation varchar(255),
    eventDate DATETIME,
    eventYear INT,
    posterLink TEXT,
    FOREIGN KEY(eventYear)
    REFERENCES generations(id)
);

CREATE TABLE IF NOT EXISTS blogPosts(
    id int AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    body TEXT,
    writtenBy INT,
    postedOn DATETIME,
    posterLink TEXT,

    FOREIGN KEY(writtenBy)
    REFERENCES members(id)
);

CREATE TABLE IF NOT EXISTS blogComments(
    id int AUTO_INCREMENT PRIMARY KEY,
    postID int,
    commentText TEXT,
    writtenBy int,
    postedOn DATETIME,
    FOREIGN KEY(writtenBy)
    REFERENCES members(id),
    FOREIGN KEY(postID)
    REFERENCES blogPosts(id)

);

#WIP: Based on proposed questions for application and past applications.
CREATE TABLE IF NOT EXISTS applicantforevent(
    id int AUTO_INCREMENT PRIMARY KEY,
    eventID int,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    fullName varchar(100), 
    faculty VARCHAR(100),
    university VARCHAR(100),
    mobileNumber varchar(11),
    email varchar(100),
    knowTedx BOOLEAN,
    knowTedx_text TEXT,
    memberTedx BOOLEAN,
    memberTedx_text VARCHAR(255),
    interests TEXT,
    knowledgeTheme TEXT,

    FOREIGN KEY(eventID)
    REFERENCES events(id)

);

CREATE TABLE IF NOT EXISTS tedxinfo(
    id int AUTO_INCREMENT PRIMARY KEY,
    aboutTedx TEXT
);