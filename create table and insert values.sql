DROP DATABASE IF EXISTS RoomFinder;
CREATE DATABASE RoomFinder;
USE RoomFinder;

DROP TABLE IF EXISTS BUILDING;
DROP TABLE IF EXISTS ROOM;
DROP TABLE IF EXISTS AVAILABILITY;
DROP TABLE IF EXISTS TIME_BLOCK;
DROP TABLE IF EXISTS STUDENT_ROOM;
DROP TABLE IF EXISTS STUDENT;
DROP TABLE IF EXISTS RATING;
DROP TABLE IF EXISTS RESERVATION;

#---------------------------------------------------------------------------------
CREATE TABLE BUILDING (
	BUILDING_ID INT NOT NULL AUTO_INCREMENT,
    BUILDING_NAME VARCHAR(255) NOT NULL,
    BUILDING_CITY VARCHAR(255) NOT NULL,
    BUILDING_ZIP VARCHAR(255) NOT NULL,
    BUILDING_STREET VARCHAR(255) NOT NULL,
    BUILDING_STATE VARCHAR(255) NOT NULL,
    CONSTRAINT BUILDING_PK PRIMARY KEY (BUILDING_ID)
);
INSERT INTO BUILDING VALUES(BUILDING_ID, "Rice Hall", "Charlottesville", 22903, "85 Engineer's Way", "Virginia");
INSERT INTO BUILDING VALUES(BUILDING_ID, "Thornton Hall", "Charlottesville", 22904, "351 McCormick Rd", "Virginia");
INSERT INTO BUILDING VALUES(BUILDING_ID, "Olsson Hall", "Charlottesville", 22903, "151 Engineer's Way", "Virginia");

#---------------------------------------------------------------------------------
#MAY NEED COMPOSITE KEY LATER. PK = BUILDING NAME + ROOM NUM
CREATE TABLE ROOM (
	ROOM_ID INT NOT NULL AUTO_INCREMENT,
    BUILDING_ID INT NOT NULL,
    ROOM_NUMBER  VARCHAR(255) NOT NULL,
    CAPACITY INT NOT NULL,
    #ROOM_TYPE VARCHAR(255) NOT NULL,
    CONSTRAINT ROOM_PK PRIMARY KEY (ROOM_ID),
    CONSTRAINT ROOM_FK FOREIGN KEY (BUILDING_ID) REFERENCES BUILDING (BUILDING_ID)
);
#BUILDING 1 = RICE HALL, 2 = THORNTON HALL, 3 = OLSSON HALL
INSERT INTO ROOM VALUES(ROOM_ID, 1, '032', 30);
INSERT INTO ROOM VALUES(ROOM_ID, 2, 'D115', 30);
INSERT INTO ROOM VALUES(ROOM_ID, 3, '005', 45);
INSERT INTO ROOM VALUES(ROOM_ID, 3, '120', 45);


#---------------------------------------------------------------------------------
#ROUND UP LOUS LIST DATA TO NEAREST HOUR
#ADD CONSTRAINT ON UNUSUAL TIME SLOTS.
#ASSUMPTION IS TIME BLOCKS ARE 1 HOUR INTERVALS FROM 1PM TO 4PM AND CAN ADD MORE LATER.
CREATE TABLE TIME_BLOCK (
	TIME_ID INT NOT NULL AUTO_INCREMENT,
    START_TIME VARCHAR(255),
    END_TIME VARCHAR(255),
    CONSTRAINT TIME_BLOCK_PK PRIMARY KEY (TIME_ID)
);
#TIME_ID 1 = 1-2PM, 2 = 2-3PM, 3 = 3-4PM.
INSERT INTO TIME_BLOCK VALUES(TIME_ID, '1:00PM', '2:00PM');
INSERT INTO TIME_BLOCK VALUES(TIME_ID, '2:00PM', '3:00PM');
INSERT INTO TIME_BLOCK VALUES(TIME_ID, '3:00PM', '4:00PM');

#---------------------------------------------------------------------------------
CREATE TABLE AVAILABILITY (
	AVAILABILITY_ID INT NOT NULL AUTO_INCREMENT,
	ROOM_ID INT NOT NULL,
    AVAILABLE_DAY VARCHAR(255) NOT NULL,
    TIME_ID INT NOT NULL,
    #NeedS a primary key SO MADE IT ROOM_ID SINCE ALL ROOMS HAVE A UNIQUE ID EVEN IF THEIR ROOM_NUM IS THE SAME SO AVAILABILITY WILL ASSOCIATE W/ EACH ROOM_ID
    CONSTRAINT AVAILABILITY_PK PRIMARY KEY (AVAILABILITY_ID),
    CONSTRAINT AVAILABILITY_FK1 FOREIGN KEY (ROOM_ID) REFERENCES ROOM (ROOM_ID),
    CONSTRAINT AVAILABILITY_FK2 FOREIGN KEY (TIME_ID) REFERENCES TIME_BLOCK(TIME_ID)
    #CONSTRAINT AVAILABILITY_FK3 FOREIGN KEY (AVAILABLE_DAY) REFERENCES #UNSURE WHAT ENTITY THIS FK REFERENCES FROM THE ERD
);
#ROOM 1 = RICE HALL 032, 2 = THORNTON HALL D115, 3 = OLSSON HALL 005, 4 = OLSSON HALL 120
#TIME_ID 1 = 1-2PM, 2 = 2-3PM, 3 = 3-4PM.
INSERT INTO AVAILABILITY VALUES(AVAILABILITY_ID, 1, 'MONDAY', 1); #RICE HALL 032, MONDAY, 1-2PM
INSERT INTO AVAILABILITY VALUES(AVAILABILITY_ID, 1, 'MONDAY', 2); #RICE HALL 032, MONDAY, 2-3PM
INSERT INTO AVAILABILITY VALUES(AVAILABILITY_ID, 2, 'TUESDAY', 3); #THORNTON HALL D115, TUESDAY, 3-4PM
INSERT INTO AVAILABILITY VALUES(AVAILABILITY_ID, 2, 'THURSDAY', 1); #THORNTON HALL D115, THURSDAY, 2-3PM
INSERT INTO AVAILABILITY VALUES(AVAILABILITY_ID, 3, 'FRIDAY', 2); #OLSSON HALL 005, FRIDAY, 2-3PM
INSERT INTO AVAILABILITY VALUES(AVAILABILITY_ID, 4, 'WEDNESDAY', 1); #OLSSON HALL 120, WEDNESDAY, 1-2PM

#---------------------------------------------------------------------------------
 CREATE TABLE STUDENT (
	STUDENT_ID INT NOT NULL AUTO_INCREMENT,
    STUDENT_FNAME VARCHAR(255) NOT NULL,
    STUDENT_LNAME VARCHAR(255) NOT NULL,
    STUDENT_EMAIL VARCHAR(255) NOT NULL,
    CONSTRAINT STUDENT_PK PRIMARY KEY (STUDENT_ID)
 );
 INSERT INTO STUDENT VALUES(STUDENT_ID, 'ALEX', 'D', 'AD3ZW@VIRGINIA.EDU');
 INSERT INTO STUDENT VALUES(STUDENT_ID, 'RAMEN', 'S', 'RAMEN@VIRGINIA.EDU');
 INSERT INTO STUDENT VALUES(STUDENT_ID, 'SOFIA', 'A', 'SOFIA@VIRGINIA.EDU');
 INSERT INTO STUDENT VALUES(STUDENT_ID, 'ERIC', 'W', 'ERIC@VIRGINIA.EDU');
 
  #---------------------------------------------------------------------------------
#SPLITS THE M:N RELATIONSHIP BETWEEN ROOM AND STUDENT
 CREATE TABLE STUDENT_ROOM (
    STUDENT_ID INT NOT NULL AUTO_INCREMENT,
    ROOM_ID INT NOT NULL,
    CONSTRAINT STUDENT_ROOM_PK PRIMARY KEY (STUDENT_ID, ROOM_ID), #COMPOSITE PRIMARY KEY OF STUDENT_ID ASSIGNED TO ROOM_ID
    CONSTRAINT STUDENT_ROOM_FK1 FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (STUDENT_ID),
    CONSTRAINT STUDENT_ROOM_FK2 FOREIGN KEY (ROOM_ID) REFERENCES ROOM (ROOM_ID)
 );
#STUDENT ID: 1 = ALEX, 2 = RAMEN, 3 = SOFIA, 4 = ERIC
#ROOM ID: 1 = RICE HALL 032, 2 = THORNTON HALL D115, 3 = OLSSON HALL 005, 4 = OLSSON HALL 120
INSERT INTO STUDENT_ROOM VALUES(1, 1); #ALEX, RICE HALL 032
INSERT INTO STUDENT_ROOM VALUES(2, 1); #RAMEN, RICE HALL 032
INSERT INTO STUDENT_ROOM VALUES(3, 3); #SOFIA, OLSSON HALL 005
INSERT INTO STUDENT_ROOM VALUES(4, 2); #ERIC, THORNTON HALL D115

 #---------------------------------------------------------------------------------
#RATINGS ARE ASSOCIATED WITH A STUDENT OR A ROOM? WHO IS RATING WHAT? IS A STUDENT RATING THE ROOM, OR IS A STUDENT RATING HOW ANOTHER STUDENT USED THE ROOM?
#MAY NOT NEED THIS ENTITY IN THE GRAND SCHEME OF THE DATABASE.
 CREATE TABLE RATING (
	RATING_ID INT NOT NULL AUTO_INCREMENT, 
    STUDENT_ID INT NOT NULL,
    ROOM_ID INT NOT NULL,
    RATING_SCORE INT NOT NULL,
    CONSTRAINT RATING_SCORE CHECK (RATING_SCORE BETWEEN 1 AND 5),
    CONSTRAINT RATING_PK PRIMARY KEY (RATING_ID),
    CONSTRAINT RATING_FK1 FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (STUDENT_ID),
    CONSTRAINT RATING_FK2 FOREIGN KEY (ROOM_ID) REFERENCES ROOM (ROOM_ID)
 );
 #STUDENT ID: 1 = ALEX, 2 = RAMEN, 3 = SOFIA, 4 = ERIC
INSERT INTO RATING VALUES(RATING_ID, '1', 1, '4'); #ALEX RATES RICE HALL 032 4/5
INSERT INTO RATING VALUES(RATING_ID, '2', 1, '5'); #RAMEN RATES RICE HALL 032 5/5
INSERT INTO RATING VALUES(RATING_ID, '3', 3, '3'); #SOFIA RATES OLSSON HALL 005 3/5
INSERT INTO RATING VALUES(RATING_ID, '4', 2, '4'); #ERIC RATES THORNTON HALL D115 4/5

#---------------------------------------------------------------------------------
 CREATE TABLE RESERVATION (
	RESERVATION_ID INT NOT NULL AUTO_INCREMENT,
    STUDENT_ID INT NOT NULL,
    ROOM_ID INT NOT NULL,
    RESERVATION_DATE VARCHAR(255),
    TIME_ID INT NOT NULL,
    CONSTRAINT RESERVATION_PK PRIMARY KEY (RESERVATION_ID),
    CONSTRAINT RESERVATION_FK1 FOREIGN KEY (TIME_ID) REFERENCES TIME_BLOCK(TIME_ID),
	CONSTRAINT RESERVATION_FK2 FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (STUDENT_ID)
 );
#STUDENT ID: 1 = ALEX, 2 = RAMEN, 3 = SOFIA, 4 = ERIC
#ROOM 1 = RICE HALL 032, 2 = THORNTON HALL D115, 3 = OLSSON HALL 005, 4 = OLSSON HALL 120
#TIME_ID 1 = 1-2PM, 2 = 2-3PM, 3 = 3-4PM.
INSERT INTO RESERVATION VALUES(RESERVATION_ID, 1, 1, '06/18/2022', 1); #ALEX RESERVES RICE HALL 032 ON 6/18/2022 FROM 1-2PM
INSERT INTO RESERVATION VALUES(RESERVATION_ID, 2, 1, '06/22/2022', 3); #RAMEN RESERVES RICE HALL 032 ON 6/22/2022 FROM 3-4PM
INSERT INTO RESERVATION VALUES(RESERVATION_ID, 3, 3, '06/14/2022', 3); #SOFIA RESERVES OLSSON HALL 005 ON 6/14/2022 FROM 3-4PM
INSERT INTO RESERVATION VALUES(RESERVATION_ID, 4, 4, '06/18/2022', 2); #ERIC RESERVES OLSSON HALL 120 ON 6/18/2022 FROM 2-3PMSTUDENT_FNAME