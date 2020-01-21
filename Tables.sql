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
    photo VARCHAR(500),
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
    posterLink VARCHAR(500),
    FOREIGN KEY(eventYear)
    REFERENCES generations(id)
);

CREATE TABLE IF NOT EXISTS blogPosts(
    id int AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    body TEXT,
    writtenBy INT,
    postedOn DATETIME,
    posterLink VARCHAR(500),

    FOREIGN KEY(writtenBy)
    REFERENCES members(id)
);

CREATE TABLE IF NOT EXISTS blogComments(
    id int AUTO_INCREMENT PRIMARY KEY,
    postID int,
    commentText VARCHAR(255),
    writtenBy int,
    postedOn DATETIME,
    FOREIGN KEY(writtenBy)
    REFERENCES members(id),
    FOREIGN KEY(postID)
    REFERENCES blogPosts(id)

);

CREATE TABLE IF NOT EXISTS talksvideos(
    id int AUTO_INCREMENT PRIMARY KEY,
    videoLink VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS categories(
    id int AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30)
);

insert into `categories`(`title`)
values
("Technology"),
("Phsychology"),
("Education"),
("Design"),
("Other");

CREATE TABLE IF NOT EXISTS videocategories(
    id int AUTO_INCREMENT PRIMARY KEY,
    videoID int,
    categoryID int,
    FOREIGN KEY(videoID)
    REFERENCES talksvideos(id),
    FOREIGN KEY(categoryID)
    REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS statusofapplications(
    id int AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(20)
);

insert into `statusofapplications`(`title`)
values
("No Decision Yet"),
("Accepted"),
("On Hold"),
("Rejected"),
("Other");

CREATE TABLE IF NOT EXISTS speakersapplications(
    id int AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) DEFAULT 'John',
    lastName VARCHAR(50) DEFAULT 'Doe',
    photo VARCHAR(500),
    mobileNumber VARCHAR(11),
    email varchar(100),
    topic VARCHAR(500),
    innovativeApproach VARCHAR(1000),
    linkForMaterial VARCHAR(500),
    applicationStatus INT DEFAULT 1,
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(applicationStatus)
    REFERENCES statusofapplications(id)
);

CREATE TABLE IF NOT EXISTS speakers(
    id int AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) DEFAULT 'John',
    lastName VARCHAR(50) DEFAULT 'Doe',
    photo VARCHAR(500),
    mobileNumber VARCHAR(11),
    email varchar(100),
    topic VARCHAR(500),
    innovativeApproach VARCHAR(1000),
    linkForMaterial VARCHAR(500),
    createdOn DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS speakereventrelation(
    id int AUTO_INCREMENT PRIMARY KEY,
    speakerID int,
    eventID int,
    speakerRole varchar(20), #Host or speaker.
    FOREIGN KEY(speakerID)
    REFERENCES speakers(id),
    FOREIGN KEY(eventID)
    REFERENCES events(id)
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