/* CW3 QUERIES */
/* GROUP 70 */
/* Yasir M Dahir - 190009658 */
/* Omar Hassan - 180374892 */

/* CREATE TABLE STATEMENTS - 7 TABLES */
/* The costraints ensure that the trains in the table are of only two models (types) and of two statues */
CREATE TABLE Train (
    TrainID int NOT NULL PRIMARY KEY,
    TrainType varchar(20) NOT NULL,
    Status varchar(20) NOT NULL,
    CONSTRAINT Check_Type CHECK (TrainType = 'Normal' OR TrainType = 'Modern'),
    CONSTRAINT Check_Status CHECK (Status = 'Operational' OR Status = 'In Service')
);

/* Each crew must have a supervisor and no identical supervisors in different groups */
CREATE TABLE Crew (
    CrewID int NOT NULL PRIMARY KEY,
    Supervisor int NOT NULL UNIQUE
);

/* Each employee is part of a crew and also have specific roles (jobs) */
CREATE TABLE Employee (
    EmployeeID int NOT NULL PRIMARY KEY,
    FirstName varchar(20),
    LastName varchar(20),
    Job varchar(20),
    CrewID int,
    CONSTRAINT FK_Crew FOREIGN KEY (CrewID) REFERENCES Crew(CrewID),
    CONSTRAINT Check_Role CHECK (Job = 'Driver' OR Job = 'Conductor' OR Job = 'Service' OR Job = 'Security' OR Job = 'Management' OR Job = 'Sales')
);


CREATE TABLE Station (
    StationID int NOT NULL PRIMARY KEY,
    StationName varchar(30) NOT NULL
);

/* Routes are referenced by their start and final station */
/* A Station can be the starting station and the terminating station of multiple routes */
CREATE TABLE Route (
    RouteID int NOT NULL PRIMARY KEY,
    Distance int,
    RouteTime int,
    StartStation int,
    TerminalStation int,
    CONSTRAINT FK_Start FOREIGN KEY (StartStation) REFERENCES Station(StationID),
    CONSTRAINT FK_Terminal FOREIGN KEY (TerminalStation) REFERENCES Station(StationID)
);

/* Used to keep track of each specific journey containing a reference to three other relations */
CREATE TABLE Journey (
    JourneyID int NOT NULL PRIMARY KEY,
    JourneyDate DATE,
    RouteID int,
    TrainID int,
    CrewID int,
    CONSTRAINT FK_JourRoute FOREIGN KEY (RouteID) REFERENCES Route(RouteID),
    CONSTRAINT FK_JourTrain FOREIGN KEY (TrainID) REFERENCES Train(TrainID),
    CONSTRAINT FK_JourCrew FOREIGN KEY (CrewID) REFERENCES Crew(CrewID)
);


CREATE TABLE Passenger (
    PassengerID int NOT NULL PRIMARY KEY,
    PassengerType varchar(20),
    JourneyID int,
    CONSTRAINT FK_Journey FOREIGN KEY (JourneyID) REFERENCES Journey(JourneyID)
);

/* INSERT STATEMENTS */
INSERT INTO Train (TrainID, TrainType, Status) VALUES (1, 'Normal', 'Operational');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (2, 'Normal', 'In Service');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (3, 'Normal', 'Operational');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (4, 'Modern', 'Operational');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (5, 'Normal', 'In Service');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (6, 'Normal', 'In Service');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (7, 'Modern', 'In Service');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (8, 'Modern', 'Operational');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (9, 'Normal', 'Operational');
INSERT INTO Train (TrainID, TrainType, Status) VALUES (10, 'Modern', 'Operational');

INSERT INTO Crew (CrewID, Supervisor) Values (15, 3);
INSERT INTO Crew (CrewID, Supervisor) Values (16, 6);
INSERT INTO Crew (CrewID, Supervisor) Values (17, 14);

INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (1, 'Awais', 'Herman', 'Driver', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (2, 'Aya', 'Fraser', 'Driver', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (3, 'Rose', 'Kennedy', 'Conductor', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (4, 'Maria', 'Bowen', 'Conductor', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (5, 'Mohammed', 'Haworth', 'Service', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (6, 'Andre', 'Lamb', 'Conductor', 16);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (7, 'Riyad', 'Benton', 'Service', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (8, 'Eshaan', 'Meza', 'Service', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (9, 'Akash', 'Hunter', 'Service', 16);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (10, 'Riyad', 'Jackson', 'Security', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (11, 'Humaira', 'Knoxx', 'Driver', 16);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (12, 'Adaline', 'Morrow', 'Security', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (13, 'Ismaeel', 'McGenius', 'Management', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (14, 'Felix', ' Hansen', 'Conductor', 17);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (15, 'Yusuf', 'Abdulle', 'Management', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (16, 'Amin', 'Abdulle', 'Sales', 16);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (17, 'Ethan-Owin', 'Jones', 'Sales', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (18, 'Yasir', 'Dahir', 'Service', 15);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (19, 'Talha', 'Samin', 'Driver', 17);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Job, CrewID) VALUES (20, 'Tolga', 'Sar', 'Driver', 17);

INSERT INTO Station (StationID, StationName) VALUES (1, 'Heathbrook Station');
INSERT INTO Station (StationID, StationName) VALUES (2, 'Carisbrooke Station');
INSERT INTO Station (StationID, StationName) VALUES (3, 'Dovedale Station');
INSERT INTO Station (StationID, StationName) VALUES (4, 'East Greenhill');
INSERT INTO Station (StationID, StationName) VALUES (5, 'Highbrook North');
INSERT INTO Station (StationID, StationName) VALUES (6, 'Binworth Park');
INSERT INTO Station (StationID, StationName) VALUES (7, 'Happard Town');
INSERT INTO Station (StationID, StationName) VALUES (8, 'Milestone Down');
INSERT INTO Station (StationID, StationName) VALUES (9, 'Capchester North');
INSERT INTO Station (StationID, StationName) VALUES (10, 'Capchester South');
INSERT INTO Station (StationID, StationName) VALUES (11, 'Giles Central Station');
INSERT INTO Station (StationID, StationName) VALUES (12, 'Wington City Station');
INSERT INTO Station (StationID, StationName) VALUES (13, 'Rivermouth Station');
INSERT INTO Station (StationID, StationName) VALUES (14, 'Old Town Station');
INSERT INTO Station (StationID, StationName) VALUES (15, 'New Town Station');
INSERT INTO Station (StationID, StationName) VALUES (16, 'Wombfield Park');
INSERT INTO Station (StationID, StationName) VALUES (17, 'Woodford Station');
INSERT INTO Station (StationID, StationName) VALUES (18, 'High Town Station');
INSERT INTO Station (StationID, StationName) VALUES (19, 'McGenius Station');
INSERT INTO Station (StationID, StationName) VALUES (20, 'Cowstone Cross');

INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (1, 30, 70, 18, 2);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (2, 15, 30, 17, 6);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (3, 40, 90, 5, 15);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (4, 40, 85, 9, 10);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (5, 40, 80, 18, 1);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (6, 25, 60, 4, 10);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (7, 30, 65, 4, 15);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (8, 15, 25, 17, 15);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (9, 25, 60, 13, 12);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (10, 25, 60, 13, 12);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (11, 5, 10, 14, 15);
INSERT INTO Route (RouteID, Distance, RouteTime, StartStation, TerminalStation) VALUES (12, 40, 100, 1, 20);

INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (1, DATE '2015-05-25', 6, 2, 15);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (2, DATE '2017-01-02', 10, 2, 16);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (3, DATE '2016-09-21', 12, 7, 15);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (4, DATE '2016-10-01', 12, 7, 15);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (5, DATE '2015-04-16', 6, 6, 17);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (6, DATE '2018-08-18', 12, 2, 15);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (7, DATE '2020-12-09', 1, 5, 17);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (8, DATE '2020-12-09', 1, 5, 16);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (9, DATE '2018-04-01', 7, 6, 15);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (10, DATE '2018-09-30', 5, 7, 15);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (11, DATE '2018-10-30', 5, 7, 16);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (12, DATE '2019-11-11', 8, 2, 17);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (13, DATE '2019-06-29', 6, 2, 15);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (14, DATE '2016-02-29', 10, 6, 15);
INSERT INTO Journey (JourneyID, JourneyDate, RouteID, TrainID, CrewID) VALUES (15, DATE '2020-05-18', 10, 7, 16);

INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (1, 'Adult', 15);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (2, 'Student', 15);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (3, 'Adult', 4);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (4, 'Adult', 5);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (5, 'Student', 5);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (6, 'Adult', 15);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (7, 'Student', 9);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (8, 'Adult', 4);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (9, 'Adult', 6);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (10, 'Student', 1);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (11, 'Student', 1);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (12, 'Student', 2);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (13, 'Adult', 5);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (14, 'Adult', 5);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (15, 'Adult', 10);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (16, 'Adult', 12);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (17, 'Adult', 1);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (18, 'Student', 12);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (19, 'Student', 4);
INSERT INTO Passenger (PassengerID, PassengerType, JourneyID) VALUES (20, 'Student', 15);

/* BASIC QUERIES */
/* QUERY --- Show all the employee’s names (and ID) that start with M (either first or last name) */

SELECT E.EmployeeID, E.FirstName, E.LastName
FROM Employee E
Where E.FirstName LIKE 'M%' OR E.LastName LIKE 'M%';

/* The LIKE statement allows us to search for specific patterns inside of a column of a relation. */
/* In this case, what is returned are all the strings which its requirements are stated in the query */

/* QUERY --- Show all the employee’s names (and ID) that are supervisors */

SELECT E.EmployeeID, E.FirstName, E.LastName
FROM Employee E, Crew C
WHERE E.EmployeeID = C.Supervisor;

/* A supervisor is a specific employee in the table, meaning that the EmployeeID and Supervisor columns are related */
/* We have two tables to look at and we return the combination of the tables, where the ID of employees matches the ID of supervisors */

/* MEDIUM QUERIES */
/* QUERY --- Show all the employees’ names (and ID) and roles that where part of the journey on 25th May 2015 giving the list in ascending order of employees’ last names */

SELECT E.EmployeeID, E.FirstName, E.LastName, E.Job
FROM Employee E, Crew C, Journey J
WHERE J.CrewID = C.CrewID AND E.CrewID = C.CrewID AND J.JourneyDate = DATE '2015-05-25'
ORDER BY E.LastName ASC;

/* The journey table has a reference to the crew table, but the journey table doesn't have a reference to the employee table. */
/* However, the crew table contains the reference to the employee table. Thus, the journey table can have a indirect reference to the employee table*/
/* Thus, the tables are combined and the first two conditions in the WHERE clause must be true for such an indirect reference. */
/* Lastly, each tuple in the outcome will be ordered in ascending order, as state in the ORDER BY clause */

/* QUERY --- Count how many passengers were taking a journey during the year 2015 */

SELECT COUNT(P.PassengerID)
FROM Passenger P INNER JOIN Journey J ON P.JourneyID = J.JourneyID
WHERE J.JourneyDate BETWEEN '01-JAN-15' AND '31-DEC-15';

/* The INNER JOIN clause will return all the records that have something in common in both tables (their journeyID's) */
/* The BETWEEN clause in the WHERE clause is used to select all values within a given range (all days in 2015) */
/* The count will give the number of records in the provided column (the number of passengers that statisfy the query) */

/* QUERY --- Show how many adults and students (separately) were in journeys that occurred in the year 2018, showing relevant information */

SELECT COUNT(P.PassengerID), P.PassengerType
FROM Passenger P INNER JOIN Journey J ON P.JourneyID = J.JourneyID
WHERE J.JourneyDate BETWEEN '01-JAN-18' AND '31-DEC-2018'
GROUP BY PassengerType;

/* The GROUP BY clause is used to make sure that the query produces tuple with atomic cells */
/* This is to make sure that the COUNT function will return exactly two rows (one of the number of adults and one of the number of students) */

/* ADVANCED QUERIES */
/* QUERY --- Show all the station names (ascending order) that are not the final station */

SELECT DISTINCT S.StationID
FROM Station S
WHERE S.StationID NOT IN (SELECT DISTINCT S.StationID
FROM Station S INNER JOIN ROUTE R ON S.StationID = R.TerminalStation)
ORDER BY S.StationID;

/* For this query, we use a subquery. The subquery will return all the stations that are terminal stations */
/* Then, the subquery is used in the WHERE clause to produce an output of records of the opposite by using the NOT IN keyword */
/* Thus, if a station isn't in the subquery, it will then be displayed */
/* The DISTINCT keyword is used to make sure that there are no duplicates */

/* QUERY --- Show how many journeys, crews’ with only 1 conductor, have taken in total */

/* We first create a temporary table which displays the crews that only have one conductor */
/* The HAVING clause is replaced with the usual WHERE clause, as the WHERE clause doesn't use aggregate function, whereas the HAVING clause does */
/* The HAVING clause states the requirement that the crew must have only 1 conductor. If not, then that crew is not placed into the temporary table */
CREATE VIEW Conductor_View AS
SELECT COUNT(E.EmployeeID) NofConductors, E.CrewID
FROM Employee E
WHERE E.Job = 'Conductor'
GROUP BY E.CrewID
HAVING COUNT(E.EmployeeID) = 1;

/* By combining the temporary table with the journey table, we can now satisfy the query */
/* We use inner join to make sure that we have the set of records where the ID's of each crew matches */
SELECT C.CrewID, COUNT(J.JourneyID) NumberOfJourneys
FROM Conductor_View C INNER JOIN Journey J ON C.CrewID = J.CrewID
GROUP BY C.CrewID;

/* QUERY --- Show the average time of all journeys that a train has taken (trains that haven’t taken a journey yet are required to display an average time of 0) */

/* Show the average time that all train has taken to complete a journey */
/* First create a view where we show number of times a train has taken a journey, including ones that haven't */
CREATE VIEW JourneysTaken AS
SELECT T.TrainID, J.JourneyID
FROM Train T FULL OUTER JOIN Journey J ON T.TrainID = J.TrainID;

/* Secondly, create another view which will shows the time of each journey */
CREATE VIEW JourneyTimes AS
SELECT J.JourneyID, R.RouteTime
FROM Journey J INNER JOIN Route R ON J.RouteID = R.RouteID;

/* Then, find the average time of each train (if the train hasn't taken any journeys, then its time is taken as 0) */
/* Lastly, order from highest to lowerst time, then by the ID of the trains, if the average time is 0 */
SELECT J.TrainID, ROUND(AVG(NVL(T.RouteTime, 0)),1) AverageTime
FROM JourneysTaken J LEFT JOIN JourneyTimes T ON J.JourneyID = T.JourneyID
GROUP BY TrainID
ORDER BY AverageTime DESC, TrainID;

/* LEFT JOIN is used to make sure that we include the journeys that do not have an average time (0 time) */
/* All trains that didn't take a journey wouldn't have a reference, but we still wan't to include them and display their time as 0 */
/* The ROUND function will round to 1 decimal place, if necessary. The AVG function will return the average of all times */
/* However, not all trains will have an average time. So, the NVL function is used to ensure that NULL time columns will have a value of 0 */