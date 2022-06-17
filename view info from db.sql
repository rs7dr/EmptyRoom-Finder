#Summary of Data


SELECT *
FROM BUILDING, ROOM, AVAILABILITY, TIME_BLOCK, STUDENT, STUDENT_ROOM, RATING, RESERVATION;


#---------------------------------------------------------------------------------
#JOINS:
#MASTER DETAIL REPORT
#RESERVATION AND STUDENT JOIN
SELECT STUDENT.STUDENT_ID, STUDENT.STUDENT_FNAME, STUDENT.STUDENT_LNAME, RESERVATION.RESERVATION_ID, ROOM_ID, RESERVATION.RESERVATION_DATE, TIME_BLOCK.TIME_ID, TIME_BLOCK.START_TIME, TIME_BLOCK.END_TIME
FROM (RESERVATION INNER JOIN STUDENT ON RESERVATION.STUDENT_ID = STUDENT.STUDENT_ID) JOIN TIME_BLOCK ON TIME_BLOCK.TIME_ID = RESERVATION.TIME_ID;



#ROOM AND BUILDING JOIN

SELECT *
FROM (ROOM INNER JOIN BUILDING ON ROOM.BUILDING_ID=BUILDING.BUILDING_ID);


# AVAILABILITY AND ROOM JOIN






SELECT *
FROM (AVAILABILITY INNER JOIN ROOM ON AVAILABILITY.ROOM_ID=ROOM.ROOM_ID);


#RATING AND STUDENT JOIN
SELECT RATING.RATING_ID, STUDENT.STUDENT_ID, ROOM_ID, RATING.RATING_SCORE, STUDENT.STUDENT_FNAME, STUDENT.STUDENT_LNAME, STUDENT.STUDENT_EMAIL
FROM (RATING INNER JOIN STUDENT ON RATING.STUDENT_ID=STUDENT.STUDENT_ID);



#TODO: SQL SELECT STATEMENT FOR EACH ASSOCIATIVE ENTITIY THAT SHOWS THE CONTENT OF THE ENTITIY. 
#THESE SQL STATEMENTS MUST JOIN THE RELATED TABLES (STUDENT) (ROOM), AND INCLUDE INFO FROM EACH TABLE DIRECTLY RELATED IE STUDENT AND ROOM.



CREATE VIEW student_view AS
SELECT STUDENT.STUDENT_ID, STUDENT.STUDENT_FNAME, STUDENT.STUDENT_LNAME, STUDENT.STUDENT_EMAIL, ROOM_ID
FROM (STUDENT INNER JOIN STUDENT_ROOM ON STUDENT.STUDENT_ID=STUDENT_ROOM.STUDENT_ID);

SELECT ROOM.ROOM_ID, ROOM.BUILDING_ID, ROOM.ROOM_NUMBER, ROOM.CAPACITY, student_view.STUDENT_ID, student_view.STUDENT_EMAIL, student_view.STUDENT_FNAME, student_view.STUDENT_LNAME
FROM (ROOM INNER JOIN student_view ON ROOM.ROOM_ID=student_view.ROOM_ID);




#TODO: APPEND TO OLD PROJECT OUTLINE FILE AND MAKE A VIDEO.









#SELECT STATEMENTS FOR SHOWING TABLE DATA AND CHOOSING SPECIFIC ROWS IN A TABLE W/ A FILTER.
SELECT *
FROM BUILDING;

SELECT BUILDING_NAME
FROM BUILDING
WHERE BUILDING_NAME LIKE 'THORN%';



#SELECT STATEMENTS FOR SHOWING TABLE DATA AND CHOOSING SPECIFIC ROWS IN A TABLE W/ A FILTER.
SELECT *
FROM ROOM;

SELECT ROOM_NUMBER
FROM ROOM
WHERE ROOM_NUMBER LIKE 'D%';



#SELECT STATEMENTS FOR SHOWING TABLE DATA AND CHOOSING SPECIFIC ROWS IN A TABLE W/ A FILTER.
SELECT *
FROM TIME_BLOCK;

SELECT *
FROM TIME_BLOCK
WHERE START_TIME = '2:00PM';



#SELECT STATEMENTS FOR SHOWING TABLE DATA AND CHOOSING SPECIFIC ROWS IN A TABLE W/ A FILTER.
SELECT *
FROM AVAILABILITY;

SELECT *
FROM AVAILABILITY
WHERE AVAILABLE_DAY = 'MONDAY';


 
 #SELECT STATEMENTS FOR SHOWING TABLE DATA AND CHOOSING SPECIFIC ROWS IN A TABLE W/ A FILTER.
SELECT *
FROM STUDENT;

SELECT STUDENT_FNAME, STUDENT_LNAME
FROM STUDENT
WHERE STUDENT_EMAIL LIKE 'A%' OR STUDENT_EMAIL LIKE 'E%';
 


#SELECT STATEMENTS FOR SHOWING TABLE DATA AND CHOOSING SPECIFIC ROWS IN A TABLE W/ A FILTER.
SELECT *
FROM STUDENT_ROOM;

SELECT *
FROM STUDENT_ROOM
WHERE ROOM_ID = 3;
 
 


#SELECT STATEMENTS FOR SHOWING TABLE DATA AND CHOOSING SPECIFIC ROWS IN A TABLE W/ A FILTER.
SELECT *
FROM RATING;

SELECT STUDENT_ID, ROOM_ID
FROM RATING
WHERE RATING_SCORE > 3;



#SELECT STATEMENTS FOR SHOWING TABLE DATA AND CHOOSING SPECIFIC ROWS IN A TABLE W/ A FILTER.
	SELECT *
	FROM RESERVATION;

SELECT *
FROM RESERVATION
WHERE RESERVATION_DATE = '06/18/2022';
 

 
 
 #UNSURE IF WE NEED TO INCLUDE THE ROOM_TYPE ENTITY, I DON'T THINK IT IS NEEDED WITH WHAT WE HAVE.
SELECT * FROM TIME_BLOCK;
SELECT TIME_ID FROM TIME_BLOCK WHERE TIME_BLOCK.START_TIME = '1pm';
SELECT * FROM STUDENT;
SELECT * FROM RESERVATION;
SELECT STUDENT_ID FROM STUDENT WHERE STUDENT_EMAIL LIKE 'email3';


