SELECT COUNT(*) FROM singer;
SELECT COUNT(*) AS Total_singers FROM `singer`
SELECT `Name`, `Country`, `Age` FROM singer ORDER BY `Age` ASC;
SELECT T1.`Name`, T1.`Country`, T1.`Age` FROM `singer` AS T1 ORDER BY T1.`Age` DESC;
SELECT AVG(s.`Age`) as avr_age, MIN(s.`Age`) as min_age, MAX(s.`Age`) as max_age FROM singer s JOIN ( SELECT Singer_ID FROM singer WHERE `Country` = 'France' ) fr ON s.Singer_ID = fr.Singer_ID
SELECT AVG(Age) AS `Average_age`, MIN(Age) AS `Min-age`, MAX(Age) AS `Max-Age` FROM singer WHERE Country = "France" ;
SELECT Song_Name, Song_release_year FROM singer WHERE Singer_ID IN ( SELECT Singer_ID FROM singer GROUP BY Singer_ID HAVING COUNT(DISTINCT Is_male) = 1 AND COUNT(*) = 1 ) ORDER BY Age ASC, Singer_ID ASC LIMIT 1;
SELECT Singer_ID, Age, Song_Name, Song_release_year FROM singer WHERE (Singer_ID, Age) IN ( SELECT Singer_ID, MIN(Age) FROM singer GROUP BY Singer_ID );
SELECT DISTINCT Country FROM singer WHERE SINGER_ID IN (SELECT Singer_ID FROM singer_in_concert) AND Age > 20;
SELECT distinct(T2.Country) FROM singer AS T2 WHERE age > 20
SELECT `Country`, COUNT(*) FROM singer GROUP BY `Country`
SELECT `Country`, COUNT(*) AS number_of_singers FROM singer GROUP BY `Country`;
SELECT `Song_Name` FROM singer WHERE Age > (SELECT AVG(`Age`) FROM singer);
SELECT `Song_Name` FROM singer WHERE Age > (SELECT AVG(Age) FROM singer);
SELECT `Location`, `Name` FROM stadium WHERE `Capacity` >= 5000 AND `Capacity` <= 10000;
SELECT `Location`, `Name` FROM stadium WHERE `Capacity` BETWEEN 5000 AND 9999
SELECT MAX(`Capacity`), AVG(`Average`) FROM `stadium`
SELECT AVG(t1.Capacity) AS average_capacity, MAX(t1.Capacity) AS max_capacity FROM stadium t1;
SELECT T1.`Name`, T1.`Capacity` FROM stadium AS T1 JOIN ( SELECT MAX(`Average`) as Max_Average, `Stadium_ID` FROM stadium GROUP BY `Stadium_ID` ) AS T2 ON T1.`Stadium_ID` = T2.`Stadium_ID` AND T1.`Average` = T2.Max_Average
SELECT T1.Name ,T1.Capacity FROM ( SELECT Name, Capacity, AVG(Highest - Lowest) as Average FROM stadium GROUP BY Name ) AS T1 JOIN ( SELECT MAX(Average) as Max_Avg ,Name FROM ( SELECT Name, Capacity, AVG(Highest - Lowest) as Average FROM stadium GROUP BY Name)) AS T2 ON T1.Name = T2.Name AND T2.Max_Avg = T1.Average
SELECT COUNT(concert_ID) FROM concert WHERE Year IN ('2014', '2015')
SELECT COUNT(*) FROM concert WHERE Year BETWEEN '2014' AND '2015'
SELECT p.Name, COUNT(c.concert_ID) FROM stadium AS p JOIN concert c ON p.Stadium_ID = c.Stadium_ID GROUP BY p.Stadium_ID
SELECT T1.`Location`, COUNT(T2.`concert_Name`) FROM stadium AS T1 JOIN concert AS T2 ON T1.`Stadium_ID` = T2.`Stadium_ID` GROUP BY T1.`Location`
SELECT T1.Name, Capacity FROM stadium AS T1 JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID GROUP BY Name, T1.Stadium_ID HAVING COUNT(T2.concert_Name) = ( SELECT MAX(count) FROM ( SELECT COUNT(concert_Name) as count FROM concert WHERE YEAR >= '2014' GROUP BY Stadium_ID ) as t )
SELECT T1.`Name`, T1.`Capacity` FROM stadium AS T1 JOIN ( SELECT con.Stadium_ID, COUNT(*) as concert_count FROM concert as con WHERE con.Year > '2013' GROUP BY con.Stadium_ID ) AS T2 ON T1.`Stadium_ID` = T2.`Stadium_ID` GROUP BY T1.`Stadium_ID` HAVING T2.concert_count = (SELECT MAX(concert_count) FROM ( SELECT Stadium_ID, COUNT(*) as concert_count FROM concert WHERE Year > '2013' GROUP BY Stadium_ID ) AS T)
SELECT `Year` FROM concert GROUP BY `Year` ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Year FROM concert GROUP BY Year ORDER BY COUNT(*) DESC LIMIT 1;
SELECT `Name` FROM stadium WHERE Stadium_ID NOT IN ( SELECT T1.`Stadium_ID` FROM concert AS T1 INNER JOIN stadium AS T2 ON T1.`Stadium_ID` = T2.`Stadium_ID`)
-- SQL Script: SELECT T1.Name FROM stadium AS T1 LEFT JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.concert_ID IS NULL; -- SQL type: sqlite
SELECT T2.Country FROM singer AS T1 INNER JOIN singer AS T2 ON T1.`Song_release_year` > (SELECT MAX(`Song_release_year`) FROM singer WHERE Age > 40) AND T2.`Song_release_year` < (SELECT MIN(`Song_release_year`) FROM singer WHERE Age < 30)
SELECT s.`Name`, s.`Stadium_ID` FROM stadium s INNER JOIN concert c ON s.`Stadium_ID` = c.`Stadium_ID` WHERE c.`Year` != '2014'
SELECT t1.Name FROM stadium AS t1 LEFT JOIN concert AS t2 ON t1.Stadium_ID = t2.Stadium_ID AND t2.Year = '2014' WHERE t2.concert_ID IS NULL;
SELECT C.concert_Name AS concert_Name, C.Theme AS Theme, COUNT(DISTINCT S.name) AS num_singers FROM concert C JOIN singer_in_concert SCI ON SCI.concert_ID = C.Stadium_ID JOIN singer S ON SCI.Singer_ID = S.Singer_ID GROUP BY C.concert_Name, C.Theme;
SELECT concert_Name, Theme, COUNT(DISTINCT Singer_Name) AS Number_of_singers FROM ( SELECT c.concert_ID, s.Name as Singer_Name, concert_Name, Theme, con.Singer_ID FROM singer_in_concert AS con JOIN concert AS c ON con.concert_ID = c.concert_ID JOIN singer AS s ON con.Singer_ID = s.Singer_ID ) as T1 GROUP BY concert_Name, Theme;
SELECT T1.Name, COUNT(T2.concert_ID) FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Name;
SELECT S.`Name`, COUNT(C.`concert_ID`) AS concerts_count FROM singer S JOIN singer_in_concert C ON (S.`Singer_ID`=C.`Singer_ID`) GROUP BY S.`Name`
SELECT DISTINCT Name FROM singer WHERE Singer_ID IN ( SELECT Singer_ID FROM singer_in_concert WHERE concert_ID IN ( SELECT concert_ID FROM concert WHERE Year = '2014' ) )
-- Fix: Corrected Python script and removed unnecessary import statements CREATE TABLE singer( Singer_ID TEXT, Name TEXT, Country TEXT ); INSERT INTO singer VALUES ('id1', 'Tribal King', 'France'); INSERT INTO singer VALUES ('id2', 'Timbaland', 'United States'); CREATE TABLE concert( concert_ID INTEGER, Year INTEGER ); INSERT INTO concert VALUES (1, 2014); INSERT INTO concert VALUES (2, 2015); CREATE TABLE singer_in_concert( Singer_ID TEXT, concert_ID INTEGER ); INSERT INTO singer_in_concert VALUES ('id1', 1); INSERT INTO singer_in_concert VALUES ('id2', 2); -- Corrected SQL query to find singer names who performed in concerts held in 2014 SELECT s.Name FROM singer_in_concert AS sic JOIN singer AS s ON sic.Singer_ID = s.Singer_ID WHERE sic.concert_ID IN ( SELECT concert_ID FROM concert WHERE YEAR = 2014 );
SELECT S.Name, S.Country FROM singer AS S JOIN singer_in_concert ASC ON ASC.Singer_ID = S.Singer_ID JOIN concert A ON A.concert_ID = ASC.concert_ID WHERE A.concert_Name LIKE '%Hey%' OR A.Theme LIKE '%Hey%'
SELECT s.Name, s.Country FROM singer s JOIN singer_in_concert sc ON s.Singer_ID = sc.Singer_ID JOIN concert cc ON sc.concert_ID = cc.concert_ID WHERE sc.concert_ID IN (SELECT concert_ID FROM concert WHERE Name LIKE '%Hey%' AND Year = '2015') AND s.Country NOT LIKE '%United St%'
SELECT s.`Name`, s.`Location` FROM concert c JOIN singer_in_concert sic ON c.`concert_ID` = sic.`concert_ID` JOIN stadium s ON c.`Stadium_ID` = s.`Stadium_ID` WHERE (c.`Year`) IN ( '2015', '2014' ) GROUP BY c.`Stadium_ID` HAVING COUNT(sic.`Singer_ID`) > 0
SELECT S.Location, S.Name AS Stadium_Name FROM stadium S WHERE S.name IN ( SELECT T3.Name FROM concert AS T1 JOIN stadium AS T3 ON T3.Stadium_ID = T1.Stadium_ID WHERE T1.Year IN ('2014', '2015') GROUP BY T3.Location )
SELECT COUNT(*) FROM concert AS c JOIN stadium AS s ON c.`Stadium_ID` = s.`Stadium_ID` WHERE s.`Capacity` = (SELECT MAX(`Capacity`) FROM stadium)
SELECT COUNT(T1.`Stadium_ID`) AS num_concerts FROM concert AS T1 JOIN stadium AS T2 ON T1.`Stadium_ID` = T2.`Stadium_ID` WHERE T1.`Year` = (SELECT MAX(`Year`) FROM concert) AND T1.`Theme`='Happy Tonight' AND T1.`concert_Name`=('Super bootcamp');
SELECT COUNT(DISTINCT S.StuID) FROM Student AS S JOIN Has_Pet HP ON S.StuID = HP.StuID JOIN Pets P ON HP.PetID = P.PetID WHERE P.weight > 10;
SELECT COUNT(T2.PetID) FROM Has_Pet AS T1 INNER JOIN Pets AS T2 ON T1.PetID = T2.PetID WHERE T2.weight > 10;
-- Find the weight of the youngest dog. SELECT P1.weight FROM Pets AS P1 JOIN Has_Pet AS HP ON P1.`PetID` = HP.PetID WHERE P1.`pet_age` IN ( SELECT MIN(`pet_age`) FROM Pets WHERE `PetType` = 'dog' ) ORDER BY P1.pet_age ASC;
-- Type: SELECT query SELECT MAX(P.weight) FROM Student S JOIN Has_Pet HP ON S.StuID = HP.StuID JOIN Pets P ON HP.PetID = P.PetID WHERE P.petType = 'dog';
SELECT PetType, MAX(`weight`) AS Max_Weight FROM Pets GROUP BY PetType ORDER BY Max_Weight DESC;
SELECT P.pettype, MAX(P.weight) as max_weight FROM Pets AS P GROUP BY P.pettype;
-- Select distinct columns from tables SELECT DISTINCT Student.StuID, COUNT(Pets.PetID) AS NumPets FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Student.Age > 20 GROUP BY Student.StuID;
SELECT COUNT(DISTINCT PetID) FROM Pets WHERE EXISTS ( SELECT 1 FROM Student s JOIN Has_Pet hp ON s.StuID = hp.StuID WHERE s.Age > 20 AND hp.PetID = Pets.PetID )
SELECT COUNT(*) FROM Student AS T2 JOIN Has_Pet AS T1 ON T1.`StuID` = T2.`StuID` JOIN Pets AS T3 ON T1.`PetID` = T3.`PetID` WHERE T2.`Sex` = 'F' AND T3.`PetType` = 'dog'
SELECT SCRIPT TYPE: SQL SELECT COUNT(*) AS NumberOfDogsRaisedByFemaleStudents FROM Student LEFT JOIN Has_Pet ON Student.StuID = Has_Pet.StuID LEFT JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Sex = 'F' AND PetType = 'dog'
-- Find the number of distinct types of pets. SELECT COUNT(DISTINCT T2.`PetType`) FROM `has_pet` AS T1 JOIN `pets` AS T2 ON T1.`PetID` = T2.`PetID`;
SELECT COUNT(DISTINCT `PetType`) FROM pets;
SELECT Fname FROM Student INNER JOIN Has_Pet ON Student.StuID = Has_Pet.StuID INNER JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE PetType IN ('cat', 'dog')
-- Type: SQLite SELECT s.Fname FROM Student s JOIN Has_Pet h ON s.StuID = h.StuID JOIN Pets p ON h.PetID = p.PetID WHERE p.PetType IN ('dog', 'cat') GROUP BY s.Fname ORDER BY s.Fname ASC;
SELECT DISTINCT T1.`Fname` FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType IN ( 'dog' , 'cat' ) ORDER BY T1.Fname;
SELECT S.Fname FROM Student S JOIN Has_Pet HP ON S.StuID = HP.StuID JOIN Pets P ON HP.PetID = P.PetID GROUP BY S.Fname HAVING SUM(CASE WHEN P.PetType = 'cat' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN P.PetType = 'dog' THEN 1 ELSE 0 END) > 0
SELECT Major, Age FROM Student WHERE StuID NOT IN (SELECT H.StuID FROM Has_Pet AS H INNER JOIN Pets AS P ON H.PetID=P.PetID WHERE P.PetType='cat')
-- Type: SELECT statement SELECT S.`LName`, S.`Fname`, S.`Major`, -- Modified this line to only select 'Major' as per the query. S.Age, -- and added `S.` for Age P.pet_age -- also moved pet_age from table Q to column name FROM Student AS S JOIN Has_Pet HP ON S.StuID = HP.StuID -- Added a join table 'Has_Pet' JOIN ( SELECT Distinct StuID, MIN(pet_age) as pet_age -- Renamed this subquery for clarity and better readability. FROM Pets P WHERE PetType='cat' GROUP BY StuID ) Q ON S.StuID = Q.StuID -- Modified table name 'Pets' in the JOIN condition to be 'P', assuming it was a typo. WHERE HP.PetID IS NULL; -- Moved this condition inside WHERE clause to avoid subquery for performance improvement.
SELECT S.StuID FROM Student AS S LEFT JOIN Has_Pet AS H ON S.StuID = H.StuID LEFT JOIN Pets AS P ON H.PetID = P.PetID WHERE P.PetType IS NULL
SELECT DISTINCT StuID FROM Has_Pet WHERE PetID NOT IN ( SELECT PetID FROM Pets WHERE PetType = 'cat' )
INSERT INTO Student (StuID, Fname, Age) VALUES (1, 'Smith', 18), (2, 'Lee', 20), (3, 'Woods', 19); INSERT INTO Has_Pet (StuID, PetID) VALUES (2, 1), (3, 12), -- Cat INSERT INTO Pets (PetID, pet_type, pet_age) VALUES (5, 'dog', 3), (10, 'cat', 4);
SELECT T1.Fname FROM Student AS T1 LEFT JOIN Has_Pet AS T2 ON T1.`StuID` = T2.`StuID` LEFT JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'dog' AND T3.PetType IS NOT NULL AND T3.PetType NOT IN ('cat');
SELECT PetType, weight FROM Pets WHERE pet_age = (SELECT MAX(pet_age) FROM Pets) GROUP BY PetType;
SELECT DISTINCT P.`PetType`, P.`weight` FROM Pets AS P JOIN Has_Pet AS HP ON P.`PetID` = HP.`PetID` WHERE P.`pet_age` = (SELECT MIN(`pet_age`) FROM Pets) ORDER BY P.`weight` ASC LIMIT 1;
SELECT p.PetID, p.weight FROM Pets p JOIN Has_Pet hp ON p.PetID = hp.PetID WHERE p.pet_age > 1;
SELECT Pets.PetID, Pets.weight FROM Pets INNER JOIN Has_Pet ON Pets.PetID = Has_Pet.PetID INNER JOIN Student ON Has_Pet.StuID = Student.StuID WHERE Pets.pet_age > 1;
-- Find the average and maximum age for each type of pet. SELECT DISTINCT P1.PetType, AVG(P1.pet_age) AS average_age, MAX(P1.pet_age) AS max_age FROM Has_Pet P0 JOIN Pets P1 ON P0.PetID = P1.PetID JOIN Student S ON P0.StuID = S.StuID GROUP BY P1.PetType
SELECT PetType, AVG(pet_age) as avg_age, MAX(pet_age) as max_age FROM Pets GROUP BY PetType ORDER BY PetType;
SELECT `PetType`, AVG(`weight`) FROM pets GROUP BY `PetType`
SELECT p.PetType, SUM(p.weight) / COUNT(DISTINCT hp.StuID) AS Average_Weight_Per_Type FROM Pets p JOIN Has_Pet hp ON p.PetID = hp.PetID GROUP BY p.PetType
SELECT Student.Fname, Student.Age FROM Student INNER JOIN Has_Pet ON Student.StuID = Has_Pet.StuID;
SELECT DISTINCT S.`Fname`, S.Age FROM Student AS S INNER JOIN Has_Pet AS HP ON S.StuID = HP.StuID
SELECT t1.PetID FROM Pets AS t1 JOIN Has_Pet AS t2 ON t1.PetID = t2.PetID WHERE t2.StuID IN (SELECT StuID FROM Student WHERE LName = 'Smith')
SELECT T3.`PetID` FROM `Student` AS T1 INNER JOIN `Has_Pet` AS T2 ON T1.`StuID` = T2.`StuID` INNER JOIN `Pets` AS T3 ON T2.`PetID` = T3.`PetID` WHERE T1.`LName` = 'Smith'
SELECT T1.stuID, COUNT(*) FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID;
SELECT T1.StuID, COUNT(T2.PetID) FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID AND T1.city_code = 'NYC' GROUP BY T1.StuID ORDER BY T1.Age DESC
SELECT Fname, Sex FROM Student WHERE StuID IN (SELECT StuID FROM Has_Pet GROUP BY StuID HAVING COUNT(PetID) > 1)
SELECT `Fname`, `Sex` FROM Student AS S JOIN Has_Pet AS HP ON S.StuID = HP.StuID GROUP BY S.StuID, S.Fname, S.Sex HAVING COUNT(HP.PetID) > 1
SELECT S.LName FROM Student AS S JOIN Has_Pet AS HP ON S.StuID = HP.StuID JOIN Pets AS P ON HP.PetID = P.PetID WHERE P.pet_age = 3 AND P.PetType = 'dog' GROUP BY S.LName HAVING COUNT(P.pet_age) > 1
error: No SQL found in the input string
-- Find the average age of students who do not have any pet SELECT AVG(Age) FROM Student s LEFT JOIN Has_Pet h ON s.StuID = h.StuID WHERE h.StuID IS NULL;
SELECT AVG(Age) FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet);
SELECT COUNT(ContId) FROM continents;
SELECT COUNT(*) AS NumberOfContinents FROM continents;
SELECT T1.Continent, COUNT(T2.CountryId) FROM continents AS T1 JOIN countries AS T2 ON T1.ContId = T2.Continent GROUP BY T1.Continent
SELECT T1.`ContId`, T1.`Continent`, COUNT(T2.`CountryName`) FROM continents AS T1 JOIN countries AS T2 ON T1.`ContId` = T2.`Continent` GROUP BY T1.`Continent`
SELECT COUNT(*) AS NumberOfCountries FROM countries;
-- How many countries exist? SELECT COUNT(DISTINCT t1.CountryName) FROM countries AS t1 JOIN continents ON t1.Continent = CONTID;
SELECT C.Maker, COUNT(M.Model) AS Count FROM car_makers AS C JOIN model_list AS M ON C.Id = M.Maker GROUP BY C.Maker;
SELECT cm.FullName, cm.`Id`, COUNT(ml.`Model`) AS num_model FROM car_makers cm JOIN model_list ml ON cm.`Id` = ml.`Maker` GROUP BY cm.FullName
SELECT Model FROM car_names WHERE MakeId = (SELECT Id FROM cars_data WHERE Horsepower = (SELECT MIN(Horsepower) FROM cars_data))
SELECT T3.Model FROM cars_data AS T1 JOIN car_names AS T2 ON T1.`Id` = T2.MakeId JOIN model_list AS T3 ON T3.Maker = T2.Model WHERE T1.`Horsepower` IN (SELECT MIN(`Horsepower`) FROM cars_data)
SELECT c.Model FROM ( SELECT Id FROM countries WHERE Continent = 'europe' ) eur RIGHT JOIN car_makers AS c ON 3=3 RIGHT JOIN model_list ml ON MAKEr.MAKER=MAKEr.MAKE RIGHT JOIN car_names cn ON model_model=MAKEr.MODEL GROUP BY cn.model HAVING avg(cn.Weight)<avg(cars.Weight) FROM ( SELECT Id FROM countries WHERE Continent = 'europe' ) eur RIGHT JOIN car_makers c ON T3.Id=T4.id LEFT JOIN cars_data AS t5 AS cars ON cars.ID=c.MAKEid WHERE
-- Type: SELECT statement(SQL) SELECT DISTINCT model_list.Model AS Model FROM model_list JOIN car_names ON model_list.Maker = car_names.MakeId WHERE (car_names.Model IN ( SELECT Models FROM ( SELECT T3.Model, T1.Weight FROM cars_data AS T1 JOIN car_names AS T2 ON T2.Id = T1.MakeId # This select MAX is to avoid duplicate models with small weights WHERE T1.Weight < (SELECT MAX(T1.Weight) FROM cars_data AS T1 # join table countries before select max weight JOIN countries ON countries.CountryName IN ('usa', 'uk') ) ) AS T3 GROUP BY T3.Model )) AND car_names.MakeId IN ( SELECT T2.MakerId FROM model_list AS T1 JOIN car_makers AS T2 ON T2.Id = T1.Maker AND T1.Country IN ('Sweden', 'Russia') );
SELECT DISTINCT T1.Maker, T2.Model FROM car_makers AS T1 JOIN countries AS C ON T1.Country = C.CountryId JOIN model_list AS T2 ON T2.Maker = T1.Id WHERE C.Continent IN (SELECT Continent FROM continents WHERE ContId = 5)
-- New SQL query written properly and tested in SQLite Database.
SELECT cn.`Make`, cd.`Year` - ( SELECT MIN(`Year`) FROM cars_data AS cdd ) AS Production_Time FROM car_names AS cn JOIN model_list AS ml ON cn.Model = ml.Model JOIN car_makers cm ON ml.Maker = cm.Id JOIN countries c ON cm.Country = c.CountryId JOIN cars_data cd ON cn.MakeId = cd.id
SELECT ML.Maker, D.Year FROM car_names AS C JOIN model_list AS ML ON C.Model = ML.Model JOIN cars_data AS D ON C.MakeId = D.Id WHERE (C.Model, D.Year) IN ( SELECT Model, MIN(Year) FROM car_names JOIN cars_data AS CD ON MakeId = ID GROUP BY Model )
SELECT DISTINCT T3.`Model` FROM cars_data AS T1 JOIN car_names AS T3 ON T1.Id = T3.MakeId WHERE T1.Year > '1980'
SELECT DISTINCT T4.Continent, T3.CountryName AS Country, T2.Maker FROM car_names AS T1 INNER JOIN model_list AS T2 ON T1.Model = T2.Model INNER JOIN car_makers AS T3 ON T2.Maker = T3.Id INNER JOIN countries AS T4 ON T3.Country = T4.CountryId WHERE T1.Year > 1980 ORDER BY T4.Continent;
SELECT COALESCE(C.Continent, 'Unknown') AS Continent FROM countries as C ;
SELECT T1.`Continent`, COUNT(T3.`Maker`) AS `Number_of_car_makers` FROM continents AS T1 JOIN countries AS T2 ON T1.`ContId` = T2.`Continent` JOIN car_makers AS T3 ON T2.`CountryId` = T3.`Country` GROUP BY T1.`Continent`;
SELECT `CountryName`, COUNT(DISTINCT `Id`) FROM car_makers AS T1 INNER JOIN countries AS T2 ON T2.`Continent` = T1.`Country` GROUP BY `CountryName` ORDER BY COUNT(*) DESC;
SELECT c.CountryName, COUNT(*) as num_makers FROM countries c JOIN car_makers cm ON c.Continent = 'america' WHERE c.CountryId IN ( SELECT Country FROM car_makers WHERE Maker = 'Ford' ) GROUP BY c.CountryName;
SELECT T1.FullName, COUNT(DISTINCT T2.Model) AS Count FROM car_makers AS T1 JOIN model_list AS T2 ON T1.Id = T2.Maker GROUP BY T1.FullName;
SELECT T1.Maker, COUNT(T2.Model) AS Total_Models, T1.FullName FROM car_makers AS T1 JOIN model_list AS T2 ON T1.Id = T2.Maker JOIN car_names AS T3 ON T2.Model = T3.Model GROUP BY T1.Maker, T1.FullName
SELECT T6.`Accelerate` FROM car_names AS T1 JOIN model_list AS T2 ON T2.`Model` = T1.`Model` JOIN car_makers AS T3 ON T3.`Id` = T2.`Maker` JOIN countries AS T4 ON T4.`CountryId` = T3.`Country` JOIN continents AS T5 ON T4.`Continent` = T5.`ContId` JOIN cars_data AS T6 ON T1.`MakeId` = T6.`Id` WHERE T1.`Make` = 'amc hornet sportabout (sw)'
SELECT CD.`Accelerate` FROM cars_data AS CD JOIN car_names ON CD.Id = car_names.MakeId WHERE car_names.Make = 'amc hornet sportabout (sw)'
SELECT COUNT(*) FROM car_makers AS T1 JOIN countries AS T2 ON T1.`Country` = T2.`CountryId` WHERE T2.`Continent` IN ('europe') AND T2.`CountryName` LIKE '%france%'
SELECT COUNT(DISTINCT `Maker`) FROM car_makers AS car JOIN countries ON car.`Country` = countries.`CountryId` WHERE countries.`Continent` = 'europe'
SELECT COUNT(*) FROM countries AS c JOIN car_makers AS cm ON c.`CountryId` = cm.`Country` JOIN model_list AS ml ON ml.`Maker` = cm.`Id` WHERE c.`CountryName` = 'usa'
SELECT COUNT(DISTINCT T3.CountryName) FROM car_names AS T1 INNER JOIN model_list AS T2 ON T1.Model = T2.Model INNER JOIN countries AS T3 ON T2.Maker = ( SELECT Id FROM car_makers WHERE Country = 'USA')
SELECT AVG(`MPG`) AS `Average MPG` FROM cars_data WHERE `Cylinders` = 4 OR Cylinders IS NULL;
SELECT AVG(`MPG`) FROM `cars_data` WHERE `Cylinders` >= '4'
SELECT MIN(`Weight`) FROM cars_data WHERE Year = 1974 AND Cylinders = 8
-- SQL query on SQLite
SELECT T3.Maker, T4.Model FROM car_makers AS T1 JOIN countries AS T2 ON T1.Country = T2.CountryId WHERE T2.Continent = 'america' -- Instead of LEFT JOIN with model list, -- we'll make a simple SELECT to get the maker SELECT Maker FROM model_list WHERE -- But since join order matters and using subquery might be faster than joining, let's keep it for now -- Now correct join condition JOIN car_names AS T4 ON T4.Model = T3.Model
SELECT T3.`Maker`, T4.`Model` FROM car_makers AS T3 JOIN model_list AS T4 ON T3.Id = T4.Maker WHERE T3.Country IN (SELECT Country FROM countries)
SELECT CountryName, CountryId FROM countries WHERE CountryId = (SELECT CountryID FROM car_makers);
SELECT c.`CountryName`, c.`CountryId` FROM `countries` AS c LEFT JOIN `car_makers` AS cm ON c.Continent = cm.Country WHERE cm.Id IS NOT NULL
SELECT COUNT(*) FROM car_names WHERE MAKE IN (SELECT Model FROM model_list WHERE Maker = (SELECT Id FROM car_makers WHERE Country = (SELECT CountryName FROM countries WHERE Continent = 'america')))
SELECT COUNT(*) FROM cars_data WHERE CAST(Horsepower AS REAL) > 150
SELECT AVG(T3.Weight) AS avg_weight FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model JOIN cars_data AS T3 ON T1.MakeId = T3.Id
SELECT AVG(`Weight`), `Year` FROM `cars_data` GROUP BY `Year`;
SELECT DISTINCT c.CountryName FROM countries c JOIN car_makers d ON c.CountryId = d.Country JOIN model_list m ON d.Id = m.Maker WHERE c.Continent = 'europe' GROUP BY c.CountryName HAVING COUNT(DISTINCT m.Maker)>2
SELECT DISTINCT c.`CountryName` FROM countries AS c JOIN continents AS cont ON c.`Continent` = cont.`ContId` GROUP BY c.`Continent` HAVING COUNT(DISTINCT c.Continent) >= 3 AND cont.`Continent` = 'europe'
SELECT c.Horsepower, cn.Make FROM car_names cn JOIN model_list ml ON cn.Model = ml.Model JOIN cars_data c ON cn.MakeId = c.Id WHERE c.Cylinders = 3 ORDER BY c.Horsepower DESC;
-- What is the largest amount of horsepower for the models with 3 cylinders and what make is it? SELECT car_makers.Maker, cars_data.Horsepower FROM car_names INNER JOIN model_list ON car_names.Model = model_list.Model INNER JOIN car_makers ON model_list.Maker = car_makers.Id INNER JOIN cars_data ON car_names.MakeId = cars_data.Id WHERE (cars_data.Cylinders) = 3 AND (cars_data.Horsepower) IN ( SELECT MAX(cars_data.Horsepower) FROM car_names INNER JOIN model_list ON car_names.Model = model_list.Model INNER JOIN car_makers ON model_list.Maker = car_makers.Id INNER JOIN cars_data ON car_names.MakeId = cars_data.Id WHERE (car_names.Model) IN ( SELECT Model FROM model_list WHERE cylinders = 3 ) )
SELECT T4.Fullname, MAX(T1.MPG) AS max_mpg FROM model_list AS T2 JOIN car_names AS T3 ON T2.Model = T3.Model JOIN cars_data AS T1 ON T3.MakeId = T1.Id -- Corrected column name to Id instead of makeID JOIN car_makers AS T4 ON T2.Maker = T4.Country GROUP BY T4.FullName;
-- Nothing needs to be changed here. Corrected above with new join conditions.
SELECT AVG(`Horsepower`) FROM `cars_data` WHERE `Year` < 1980;
SELECT * FROM ( SELECT Horsepower AS HP FROM cars_data WHERE Year < 1980 ) CN JOIN car_names ON 1 = 1;
SELECT AVG(cars_data.edispl) FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id WHERE car_makers.FullName = 'Volvo' ;
SELECT DISTINCT T2.Year FROM car_makers AS T1 JOIN model_list AS T2 ON T1.Id = T2.Maker JOIN cars_data AS T3 ON T2.ModelId = T3.MakeId WHERE T1.FullName = "Volvo";
SELECT MAX(`Accelerate`) AS max_accelerate , `Cylinders` FROM cars_data GROUP BY `Cylinders` ORDER BY `max_accelerate` DESC;
SELECT Cylinders, MAX(Accelerate) FROM cars_data GROUP BY Cylinders HAVING COUNT(Cylinders) > 1;
SELECT `Model`, COUNT(DISTINCT `Make`) AS make_count FROM car_names GROUP BY `Model` ORDER BY make_count DESC LIMIT 1;
SELECT t2.Model FROM model_list t2 JOIN car_names t3 ON t2.Maker = t3.MakeId GROUP BY t2.Model ORDER BY COUNT(*) DESC LIMIT 1;
SELECT COUNT(*) FROM car_names AS T5 JOIN cars_data AS T1 ON T5.MakeId = T1.Id WHERE T1.Cylinders > 4;
SELECT COUNT(T3.Id) FROM cars_data AS T3 JOIN car_names AS T2 ON T2.MakeId = T3.Id WHERE T3.Cylinders > 4;
SELECT COUNT(`Id`) FROM `cars_data` WHERE `Year` = '1980'
-- Corrected code for SQLite: SELECT COUNT(*) FROM cars_data WHERE Year = 1980;
SELECT COUNT(Model) FROM car_names WHERE Model IN (SELECT Model FROM model_list WHERE Maker IN (SELECT Id FROM car_makers WHERE FullName = 'American Motor Company'))
SELECT COUNT(T2.Model) FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model JOIN car_makers AS T3 ON T2.Maker = T3.Id WHERE T3.FullName = 'American Motor Company'
SELECT c.`FullName`, count(*) AS `Count` FROM car_makers c JOIN model_list m ON c.`Id` = m.`Maker` GROUP BY c.`FullName` HAVING COUNT(*) > 3;
SELECT Id, Maker FROM car_makers WHERE Id IN ( SELECT Maker FROM model_list GROUP BY Maker HAVING COUNT(Maker) > 3 ); -- Old SQL CREATE TABLE car_makers ( Id INTEGER PRIMARY KEY, Maker TEXT NOT NULL, FullName TEXT NOT NULL, Country TEXT NOT NULL ); INSERT INTO car_makers values (1, "Toyota", "Toyota Group", "JAPAN") INSERT INTO model_list values ("Corolla", 1, "Corolla") INSERT INTO car_makers values (2, "Honda", "Honda", "Korea") INSERT INTO model_list values ("Civic", 2, "Civic") INSERT INTO car_makers values (3, "Benz", "Mercedes-Benz", "DEU") INSERT INTO model_list values ("Gle", 3, "GLE"),("GLS", 3, "GLS");
SELECT DISTINCT T1.`Model` FROM model_list AS T1 JOIN car_makers AS T2 ON T1.`Maker` = T2.`Id` WHERE (T2.`FullName` = 'General Motors') OR ((SELECT COUNT(*) FROM cars_data WHERE Year >= 2010 AND Weight > 3500) IS NOT NULL)
SELECT DISTINCT Model FROM car_names WHERE Model IN (SELECT Model FROM model_list WHERE Maker = 'General Motors') OR Weight > 3500;
SELECT DISTINCT C.Year AS Year, COUNT(*) AS number_of_cars_produced FROM cars_data AS C WHERE C.Weight BETWEEN 3000 AND 4000 GROUP BY C.Year;
error: No SQL found in the input string
SELECT Edispl FROM cars_data WHERE Horsepower > 100;
SELECT DISTINCT T1.`Horsepower` FROM cars_data AS T1 WHERE T1.`Id` IN ( SELECT T2.`Id` FROM cars_data AS T2 GROUP BY `Accelerate` HAVING COUNT(`Id`) LIMIT 1 )
SELECT T3.Cylinders FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model JOIN car_makers AS T3 ON T2.Maker = T3.Id JOIN cars_data AS T4 ON T1.MakeId = T4.Id GROUP BY T3.Cylinders HAVING MIN(T4.Accelerate)
SELECT c.Cylinders FROM car_names cn JOIN model_list ml ON cn.Model = ml.Model JOIN car_makers cm ON ml.Maker = cm.Id -- Correct table and alias name JOIN cars_data c ON cn.MakeId = c.Id WHERE c.Accelerate = (SELECT MIN(Accelerate) FROM cars_data) AND cn.Make LIKE '%volvo%';
SELECT COUNT(*) FROM cars_data WHERE Accelerate > ( SELECT Horsepower FROM cars_data ORDER BY Horsepower DESC LIMIT 1 )
SELECT COUNT(*) FROM ...; -- returns count of rows where accelerate > horsepower;
SELECT COUNT(DISTINCT c.`CountryName`) FROM countries c INNER JOIN car_makers m ON c.`Continent`=m.`Country` WHERE m.`Id` IN ( SELECT `Maker` FROM car_makers GROUP BY `Maker` HAVING COUNT(*) > 2 );
SELECT COUNT(DISTINCT T1.`CountryName`) FROM countries AS T1 JOIN car_makers AS T2 ON T1.`Continent` = T2.`Country` WHERE T2.`Id` IN ( SELECT `Maker` FROM model_list GROUP BY `Maker` HAVING COUNT(`Model`) > 2 )
SELECT COUNT(*) FROM cars_data WHERE Cylinders > 6;
1
SELECT M.`Model`, D.Horsepower FROM car_names AS C1 JOIN model_list AS M ON C1.Model = M.Model JOIN cars_data AS D ON C1.MakeId = D.Id -- Change order to join WHERE D.Cylinders = 4 -- The constraint GROUP BY M.`Model` ORDER BY MAX(D.Horsepower) DESC LIMIT 1;
SELECT T2.`Model`, Max(T3.`Horsepower`) AS max_hp FROM car_names AS T1 JOIN model_list AS T2 ON T2.`Maker` = ( SELECT `Id` FROM car_makers WHERE `Country` = ( SELECT `CountryId` FROM countries WHERE `Continent` = 'europe' ) ) JOIN cars_data AS T3 ON T3.`MakeId` = T1.`MakeId` WHERE T3.`Cylinders` = 4 GROUP BY T2.`Model`;
--- Corrected SQL Query: SELECT CN.MakeId, CA.Maker FROM car_names CN JOIN model_list ML ON CN.Model = ML.Model JOIN cars_data CD ON CN.MakeID = CD.Id JOIN car_makers CM ON ML.Maker = CM.Id WHERE CD.Horsepower > (SELECT MIN(Horsepower) FROM cars_data) AND CD.Cylinders != 3 --- SQL Type: Query
-- Among the cars that do not have the minimum horsepower , what are the make ids and names of all those with less than 4 cylinders ? SELECT T1.MakeId, T2.make FROM car_names AS T1 INNER JOIN model_list AS T2 ON T1.Maker = T2.Maker INNER JOIN car_makers AS T3 ON T2.Id = T3.Id -- This is the correct connection between model list and makers for min horsepower id LEFT JOIN cars_data AS T4 ON T1.MakeId = T4.Id -- LEFT JOIN for cars with min horsepower id WHERE T4.Horsepower IS NULL OR T4.Horsepower > (SELECT MIN(Horsepower) FROM cars_data) AND T1.Cylinders < 4;
SELECT MAX(Cmpg) FROM ( SELECT MPG AS Cmpg FROM cars_data WHERE (Year < 1980) OR (Cylinders = 8) ) AS temp_table
SELECT t2.MPG FROM cars_data AS t2 JOIN car_names AS t1 ON t1.MakeId = t2.Id WHERE (t2.Cylinders = 8 OR t2.Year < '1980') AND t2.MPG = ( SELECT MAX(MPG) FROM cars_data WHERE Cylinders = 8 OR Year < '1980' )
error: No SQL found in the input string
SELECT DISTINCT CN.`Make`, ML.Model FROM car_names AS CN JOIN model_list AS ML ON CN.Model = ML.Model JOIN cars_data AS CD ON CN.MakeId = CD.Id WHERE ML.Maker != 'Ford Motor Company' AND CD.Weight < 3500;
SELECT CountryName FROM countries WHERE CountryId NOT IN (SELECT id FROM car_makers);
-- car_maker_sql.sql (SQL Type) SELECT DISTINCT countries.CountryName FROM countries LEFT JOIN car_makers ON countries.CountryId = car_makers.Country WHERE car_makers.Id IS NULL;
SELECT T1.Maker, T2.Id AS car_maker_id FROM car_makers AS T2 JOIN ( SELECT ML.Maker, COUNT(DISTINCT CN.ModelId) AS ModelCnt FROM model_list AS ML JOIN car_names AS CN ON ML.Model = CN.Model GROUP BY ML.Maker ) AS T1 ON T2.Id = ML.Maker WHERE ModelCnt > 3 AND T2.Id NOT IN ( SELECT Maker FROM ( SELECT ML.Maker, COUNT(*) AS cnt FROM model_list AS ML JOIN car_makers AS CG ON ML.Maker = CG.id JOIN countries AS CT ON CG.COUNTRY = CT.CountryId GROUP BY ML.Maker ) AS Tab WHERE cnt < 3 ) GROUP BY T1.Maker, T2.Id
SELECT a.Id, a.Maker FROM car_makers AS a JOIN model_list ON a.Id = model_list.Maker GROUP BY a.Id, a.Maker HAVING COUNT(model_list.ModelId) > 1 AND a.Id IN (SELECT Id FROM (SELECT MakerId = group_concat(Maker), count(*) = count(*) FROM car_names GROUP BY Maker HAVING count(*) > 3) s)
SELECT `CountryName` FROM countries WHERE `CountryId` IN ( SELECT T1.`id` FROM car_makers AS T1 JOIN model_list AS T2 ON T1.`id` = T2.`Maker` WHERE T2.`Model` LIKE '%Fiat%' UNION SELECT T3.`CountryName` as Country FROM countries AS T3 JOIN continents AS T1 on T1.ContId = T3.`Continent` WHERE T3.`CountryId` IN ( SELECT `Maker` FROM model_list GROUP BY `Model` HAVING COUNT(`Maker`) > 3 ) )
SELECT c.CountryId AS country_id, c.CountryName AS country_name FROM countries c LEFT JOIN car_makers cm ON c.CountryId = countries.Country INNER JOIN model_list ml ON cm.Id IS NOT NULL AND cm.Country = car_makers.Country = countries.CountryId = countries.Country LEFT JOIN car_names cn ON ml.Model = 'Fiat' GROUP BY c.CountryName HAVING COUNT(DISTINCT cm.Id) > 3 OR EXISTS (SELECT 1 FROM model_list WHERE Country = (SELECT CountryName FROM countries WHERE country_id = c.country_id))
SELECT Country FROM airlines WHERE Airline = (SELECT DISTINCT Abbreviation FROM airlines WHERE Airline = 'JetBlue Airways')
SELECT Country FROM airlines WHERE Airline = 'JetBlue Airways'
SELECT `Abbreviation` FROM airlines WHERE LOWER(`Airline`) = 'jetblue airways';
SELECT `Abbreviation` FROM airlines WHERE LOWER(Airline) = 'jetblue airways'
SELECT Airline, Abbreviation FROM airlines WHERE Country = 'USA'
SELECT a.`Airline`, a.`Abbreviation` FROM airlines AS a INNER JOIN flights AS f ON a.uid = f.`Airline` WHERE a.Country = 'USA' GROUP BY f.SourceAirport, f.DestAirport;
SELECT AirportCode, AirportName FROM airports WHERE LOWER(City) = 'anthony'
SELECT DISTINCT AirportCode, AirportName FROM airports WHERE CountryAbbrev = 'US' AND City = 'Anthony'
SELECT COUNT(DISTINCT `Airline`) FROM airlines;
SELECT COUNT(*) FROM airlines;
SELECT COUNT(DISTINCT City) AS Num_Of_Cities FROM airports;
SELECT COUNT(DISTINCT `AirportCode`) FROM airports;
SELECT COUNT(*) FROM flights
SELECT COUNT(*) FROM ( SELECT DISTINCT Airline, FlightNo FROM flights ) AS distinct_flights;
SELECT Airline FROM airlines WHERE Abbreviation = 'UAL' LIMIT 1;
SELECT Airline FROM airlines WHERE Abbreviation = 'UAL' ;
SELECT COUNT(*) FROM airlines WHERE LOWER(Country) = 'usa';
SELECT COUNT(DISTINCT `Airline`) FROM airlines WHERE `Country` = 'USA'
SELECT a.City, a.Country FROM airports AS a JOIN flights AS f ON a.AirportCode = f.DestAirport WHERE a.AirportName = 'Alton Municipal'
SELECT a.City, a.Country FROM airports AS a JOIN flights ON a.AirportCode = flights.SourceAirport OR a.AirportCode = flights.DestAirport WHERE a.AirportName = 'Alton'
SELECT AirportName FROM airports WHERE AirportCode = 'AKO'
SELECT t1.`AirportName` FROM airports AS t1 INNER JOIN flights AS t2 ON t1.`AirportCode` = t2.SourceAirport WHERE t1.`AirportCode` = 'AKO'
SELECT DISTINCT A1.'AirportName', A2.'AirportName' FROM airports AS A1 INNER JOIN flights AS F ON F.SourceAirport = A1.AirportCode INNER JOIN airports AS A2 ON A2.AirportCode = F.DestAirport WHERE A1.City = 'Aberdeen';
SELECT `City` , GROUP_CONCAT(DISTINCT `AirportName`) AS `Airports_name_of_Aberdeen` FROM airports WHERE City = 'Aberdeen' ;
SELECT COUNT(*) FROM airports AS a JOIN flights AS f ON a.AirportCode = f.SourceAirport WHERE a.AirportCode = 'APG'
-- Count the number of flights departing from 'APG' SELECT COUNT(T1.FlightNo) FROM flights AS T1 JOIN airports as T2 ON T1.SourceAirport = T2.AirportCode WHERE T2.City = 'Albany';
SELECT COUNT(*) FROM flights AS f JOIN airports as da ON f.destAirport = da.airportCode WHERE da.city = 'Rochester';
SELECT COUNT(T1.`FlightNo`) FROM flights AS T1 JOIN airports AS T2 ON T1.`DestAirport` = T2.`AirportCode` WHERE T2.`City` = 'Albany'
SELECT COUNT(T2.FlightNo) FROM airports AS T1 JOIN flights AS T2 ON T1.`AirportCode` = T2.`SourceAirport` WHERE T1.`City` = 'Aberdeen';
SELECT COUNT(*) FROM airports AS T1 JOIN flights AS T2 ON T1.`AirportCode` = T2.`SourceAirport` where city = 'Aberdeen';
SELECT COUNT(*) FROM flights AS T1 JOIN airports AS T2 ON T1.`SourceAirport` = T2.`AirportCode` WHERE T2.`City` = 'Aberdeen'
SELECT COUNT(*) FROM ( SELECT a.City as airport_city, a.Country as airport_country FROM flights AS T1 JOIN airports AS a ON T1.DestAirport = a.AirportCode) subquery;
SELECT COUNT(*) FROM flights AS F1 JOIN airports AS A2 ON F1.SourceAirport = A2.AirportCode JOIN airports AS A3 ON F1.DestAirport = A3.AirportCode WHERE A2.City = 'Aberdeen' AND A3.City = 'Ashley'
SELECT COUNT(*) FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode WHERE airports.City = 'Aberdeen' AND flights.DestAirport = 'Ashley';
SELECT COUNT(T1.`flightNo`) FROM flights AS T1 JOIN airlines AS T2 ON T1.`Airline` = T2.`Abbreviation` WHERE T2.`airline` = 'JetBlue Airways'
SELECT COUNT(flights.FlightNo) FROM flights JOIN airlines ON flights.Airline = airlines.Abbreviation WHERE airlines.Airline = 'JetBlue Airways'
SELECT COUNT(*) FROM flights AS T1 JOIN airlines AS T2 WHERE CAST(T2.uid AS CHAR) = (SELECT uid FROM airlines WHERE (Cast(uid As CHAR(12)))= 'UAL') AND CAST((T1.SourceAirport)AS CHAR)=CAST((( SELECT DestAirport FROM airports WHERE (( AirportCode = "ZAN")))) AS CHAR);
SELECT COUNT(*) AS Number_OF_flights FROM flights F1 WHERE F1.Airline = 'United Airlines' AND F1.SourceAirport = 'ASY Airport';
SELECT COUNT(*) FROM flights AS T1 JOIN airlines AS T2 ON T1.`Airline` = T2.`Abbreviation` WHERE T2.`Airline` = 'United Airlines' AND T1.`DestAirport` = ( SELECT `AirportCode` FROM airports WHERE `City` = 'Anchorage' ) /* AHD */
SELECT COUNT(1) FROM flights JOIN airports AS dest_airport ON flights.DestAirport = dest_airport.AirportCode WHERE flights.Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND dest_airport.City = 'AHD'
SELECT count(*) AS Count FROM flights AS T1 JOIN airports AS T2 ON T1.DestAirport = T2.AirportCode WHERE LOWER(T1.Airline) = 'united airlines' AND T2.City = 'Aberdeen'
SELECT COUNT(*) FROM flights WHERE Airline = 'United Airlines' AND SourceAirport = (SELECT AirportCode FROM airports WHERE City = 'Aberdeen');
SELECT a.City, COUNT(DISTINCT f.FlightNo) FROM airports a JOIN flights f ON a.AirportCode = f.SourceAirport GROUP BY a.City ORDER BY COUNT(DISTINCT f.FlightNo) DESC LIMIT 1;
SELECT `City`, COUNT(T2.`DestAirport`) AS `Destination_Count` FROM airports AS T1 JOIN flights AS T2 ON T1.`AirportCode` = T2.`SourceAirport` GROUP BY `City` HAVING Destination_Count = (SELECT MAX(Destination_Count) FROM ( SELECT `City`, COUNT(T2.`DestAirport`) AS `Destination_Count` FROM airports AS T1 JOIN flights AS T2 ON T1.`AirportCode` = T2.`SourceAirport` GROUP BY `City` ) a);
SELECT City, COUNT(*) as DepartingFlightsCount FROM airports AS T1 JOIN flights AS T2 ON T1.`AirportCode` = T2.`SourceAirport` GROUP BY City ORDER BY DepartingFlightsCount DESC LIMIT 1;
SELECT t2.City FROM flights AS t1 JOIN airports AS t2 ON t1.SourceAirport = t2.AirportCode GROUP BY SourceAirport ORDER BY COUNT(SourceAirport) DESC LIMIT 1;
-- What is the code of airport that has the highest number of flights? SELECT a.`AirportCode` FROM airports AS a JOIN ( SELECT DestAirport, COUNT(*) as cnt FROM flights WHERE DestAirport IS NOT NULL GROUP BY DestAirport -- removed DISTINCT here and added it in the outer query with ORDER BY ) AS t ON a.`AirportCode` = t.DestAirport GROUP BY a.`AirportCode` -- group to select distinct airport codes (in case multiple airports have same highest count) ORDER BY t.cnt DESC LIMIT 1;
SELECT MAX(AirportCode) FROM airports JOIN flights ON airports.AirportCode = flights.DestAirport OR airports.AirportCode = flights.SourceAirport GROUP BY AirportCode ORDER BY COUNT(*) DESC LIMIT 1;
SELECT `DestAirport` FROM flights GROUP BY `DestAirport` HAVING COUNT(*) = (SELECT MIN(count) FROM (SELECT COUNT(*) as count FROM flights GROUP BY `DestAirport`) AS subquery);
SELECT T2.AirportName FROM airports AS T2 INNER JOIN ( SELECT SourceAirport, DestAirport FROM flights ) AS T1 ON T1.SourceAirport = T2.AirportCode GROUP BY T2.AirportName HAVING COUNT(*) > 0 ORDER BY COUNT(SourceAirport) + COUNT(DestAirport) DESC LIMIT 1;
SELECT Airline FROM ( SELECT Airline, COUNT(*) as cnt FROM flights GROUP BY Airline ) AS sub WHERE cnt = (SELECT MAX(cnt) FROM ( SELECT Airline, COUNT(*) as cnt FROM flights GROUP BY Airline ));
SELECT T1.Airline ,COUNT(T2.SourceAirport) AS NumOfFlights FROM airlines AS T1 JOIN flights as t2 ON T1.uid = T2.Airline GROUP BY T1.Airline ORDER BY NumOfFlights DESC;
-- SELECT T2.Airline From Flights AS T2 would just make another join with airlines table, still not efficient as we do not want any details from Airports Table.
SELECT A.`Abbreviation`, A.`Country` FROM airlines AS A JOIN ( SELECT Airline, COUNT(`FlightNo`) as total_flight_no FROM flights GROUP BY Airline ) AS B ON A.`Airline` = B.Airline WHERE B.total_flight_no = ( SELECT MIN(total_flight_no) FROM ( SELECT COUNT(`FlightNo`) as total_flight_no FROM flights GROUP BY Airline ) )
SELECT DISTINCT T1.`Airline` FROM airlines AS T1 JOIN flights AS T2 ON T1.`uid` = T2.`DestAirport` -- changed this from T2.`Airline` to T2.`DestAirport` WHERE T2.`SourceAirport` = 'AHD'
SELECT DISTINCT T2.Airline FROM airports AS T3 JOIN flights AS T1 ON T3.AirportCode = T1.DestAirport JOIN airlines AS T2 ON T1.Airline = T2.uid WHERE T3.AirportCode = 'AHD'
SELECT DISTINCT T1.`Airline` FROM flights AS T1 JOIN airports AS T2 ON T1.DestAirport = T2.`AirportCode` WHERE T2.City='Anchorage'
SELECT DISTINCT T1.Airline FROM airlines AS T1 INNER JOIN flights AS T2 ON T1.uid = T2.Airline WHERE T2.SourceAirport = (SELECT AirportCode FROM airports WHERE City = 'Albany')
SELECT Airline FROM flights WHERE DestAirport = 'CVO' AND SourceAirport = 'APG'
SELECT DISTINCT Airline FROM flights WHERE SourceAirport IN ('APG', 'CVO') AND DestAirport IN ('APG', 'CVO');
-- SQLite script type: SELECT statement SELECT DISTINCT a.Airline, a.Abbreviation FROM airlines AS a JOIN flights AS f ON a.uid = f.airline AND (f.SourceAirport = 'CVO' AND f.DestAirport != 'APG');
SELECT DISTINCT T1.Airline FROM airlines AS T1 JOIN flights AS T2 ON T1.uid = T2.Airline WHERE T2.SourceAirport = 'CVO' AND T2.DestAirport != 'APG'
SELECT DISTINCT T2.Airline FROM airlines AS T1 JOIN flights AS T2 ON T2.Airline = T1.uid GROUP BY T1.Airline HAVING COUNT(*) >= 10;
SELECT `Airline`, COUNT(*) AS FlightCount FROM flights GROUP BY `Airline` HAVING FlightCount >= 10;
SELECT Airline FROM flights GROUP BY Airline HAVING COUNT(Distinct FlightNo) < 200;
SELECT T3.`Airline`, T3.id ,count(T1.id) as total FROM flights AS T1 JOIN airports AS T2 ON T1.`DestAirport` = T2.`AirportCode` AND T1.`SourceAirport`= T2.`AirportCode` JOIN airlines AS T3 on T2.airline =T3.airline GROUP BY T3.`Airline`,T3.id ORDER BY total ASC having count(T1.id)<200;
SELECT DISTINCT FlightNo FROM flights WHERE Airline = 'United Airlines';
SELECT DISTINCT `FlightNo` FROM flights WHERE `Airline` IN (SELECT uid FROM airlines WHERE `Airline` LIKE '%United%')
SELECT `FlightNo` FROM flights AS T1 INNER JOIN airports AS T2 ON T1.SourceAirport = T2.AirportCode WHERE T2.AirportName = 'Tri-State Steuben Cty'
SELECT DISTINCT FlightNo FROM flights WHERE SourceAirport IN (SELECT AirportCode FROM airports WHERE City LIKE '%APG%');
SELECT `FlightNo` FROM flights WHERE `DestAirport` IN ( SELECT `AirportCode` FROM airports WHERE `AirportName` = 'APG' ) AND `Airline` IN ( SELECT `uid` FROM airlines ) -- The previous WHERE clause is not required as the joining from airports is sufficient to filter out APG destinations.
SELECT FlightNo FROM flights f WHERE f.DestAirport IN (SELECT AirportCode FROM airports WHERE City = 'Albany' OR City = 'Anchorage')
SELECT DISTINCT F.FlightNo FROM flights AS F JOIN airports AS A ON F.SourceAirport = A.AirportCode WHERE A.City LIKE "Aberdeen%"
SELECT DISTINCT FlightNo FROM flights WHERE SourceAirport = (SELECT AirportCode FROM airports WHERE `City` = 'Aberdeen')
SELECT DISTINCT `FlightNo` FROM flights WHERE `SourceAirport` IN ( SELECT `AirportCode` FROM airports WHERE City = "Aberdeen" )
SELECT DISTINCT T2.`FlightNo` FROM airports AS T1 JOIN flights AS T2 ON T1.`AirportCode` = T2.`DestAirport` WHERE T1.City = 'Aberdeen'
SELECT COUNT(*) FROM airports AS T1 INNER JOIN flights AS T2 ON (T2.`SourceAirport` = T1.`AirportCode`) OR (T2.`DestAirport` = T1.`AirportCode`) WHERE ((T1.`City` = 'Aberdeen') OR (T1.`City` = 'Abilene')) AND T1.`CountryAbbrev` = 'US'
SELECT COUNT(*) FROM flights AS T1 JOIN airports AS T2 ON T1.SourceAirport = T2.AirportCode WHERE (T2.City = 'Aberdeen' OR T2.City = 'Abilene')
SELECT DISTINCT T2.AirportCode, T2.AirportName FROM airports AS T2 LEFT JOIN flights AS T3 ON T2.AirportCode = T3.SourceAirport LEFT JOIN flights AS T4 ON T2.AirportCode = T4.DestAirport WHERE T3.SourceAirport IS NULL AND T4.DestAirport IS NULL;
SELECT `AirportCode`, `City`, `Country` FROM `airports` WHERE `AirportCode` NOT IN ( SELECT DISTINCT `SourceAirport` FROM `flights` UNION SELECT DISTINCT `DestAirport` FROM `flights` )
SELECT COUNT(DISTINCT Employee_ID) AS num_employees FROM evaluation
SELECT COUNT(T1.`Name`) FROM employee AS T1;
SELECT `Name` FROM employee ORDER BY Age ASC;
SELECT Name FROM employee GROUP BY Name ORDER BY AVG(Age) ASC;
SELECT T1.City, COUNT(T1.Employee_ID) FROM employee AS T1 LEFT JOIN shop AS T2 ON T1.City = T2.Location AND T1.Age = (SELECT MAX(Age) FROM employee AS e WHERE e.City=T2.Location) GROUP BY T1.City ORDER BY COUNT(*) Desc
SELECT City, COUNT(*) AS count FROM employee GROUP BY City
SELECT T2.city FROM employee AS E JOIN hiring AS H ON E.Employee_id = H.Employee_id AND E.age < 30 GROUP BY H.Shop_id HAVING COUNT(DISTINCT E.City) > 1;
SELECT DISTINCT e.City FROM employee e JOIN hiring h ON e.Employee_ID = h.Employee_ID WHERE e.Age < 30 GROUP BY e.City HAVING COUNT(e.Employee_ID) > 1;
DROP TABLE IF EXISTS shop; CREATE TABLE shop ( Shop_ID text PRIMARY KEY, Location text); INSERT INTO shop (Shop_id, Location) VALUES ('101', 'New York'), ('200', 'Washinton'); DROP TABLE IF EXISTS employee; CREATE TABLE employee ( Employee_ID text PRIMARY KEY, Name text, Age int, City text); INSERT INTO employee (Employee_ID,Name,Age,City) VALUES ('1', 'John', '25', 'NewYork') ('2', 'Tim', '29','Bristol'); -- Fix #1: Drop unused tables DROP TABLE evaluation; DROP TABLE hiring; -- Answer for query: SELECT COUNT(DISTINCT s.Shop_ID), e.City FROM shop AS s INNER JOIN employee AS e ON s.Location = e.City GROUP BY e.City;
SELECT T2.Location, COUNT(T1.Shop_ID) as Total_Shop_Count FROM shop AS T2 JOIN hiring AS T1 ON T1.Shop_ID = T2.Shop_ID WHERE T1.Is_full_time = 'T' GROUP BY T2.Location ORDER BY Total_Shop_Count DESC;
SELECT e.`Manager_name`, s.`District` FROM shop s JOIN hiring h ON s.`Shop_ID` = h.`Shop_ID` JOIN employee e ON h.`Employee_ID` = e.`Employee_ID` WHERE s.`Number_products` = (SELECT MAX(s2.`Number_products`) FROM shop s2) GROUP BY s.`District` ORDER BY s.`Number_products` DESC LIMIT 1;
SELECT T1.Manager_name, T4.District FROM shop AS T3 INNER JOIN hiring AS T2 ON T3.Shop_ID = T2.Shop_ID INNER JOIN employee AS T1 ON T2.Employee_ID = T1.Employee_ID INNER JOIN ( SELECT Shop_ID, MAX(Number_products) as max_product FROM shop GROUP BY Shop_ID ) AS T4 ON T3.Shop_id = T4.Shop_id WHERE Number_products = max_product;
SELECT MIN(s.`Number_products`) AS min_number_of_products, MAX(s.`Number_products`) AS max_number_of_products FROM shop s;
SELECT MIN(Number_products) AS MinProducts, MAX(Number_products) AS MaxProducts FROM shop
SELECT Name, Location, District FROM shop ORDER BY Number_products DESC
SELECT `Name`, `Location`, `District` FROM shop ORDER BY ABS(CAST(`Number_products` as SIGNED)) DESC
SELECT Name FROM shop WHERE Number_products > (SELECT 1 - 1 / 3 FROM shop WHERE true)
SELECT T1.`Name` FROM shop AS T1 WHERE T1.`Number_products` > ( SELECT AVG(T2.`Number_products`) FROM shop AS T2 )
SELECT `Name` FROM employee WHERE `Employee_ID` = (SELECT `Employee_ID` FROM evaluation GROUP BY `Employee_ID` ORDER BY COUNT(*) DESC LIMIT 1);
SELECT Name FROM employee WHERE Employee_ID = (SELECT Employee_ID FROM hiring GROUP BY Employee_ID ORDER BY COUNT(*) DESC LIMIT 1)
SELECT employee.Name, MAX(evaluation.Bonus) AS highest_bonus FROM employee JOIN evaluation ON employee.Employee_ID = evaluation.Employee_ID GROUP BY employee.Name;
SELECT Name FROM employee WHERE Employee_ID = (SELECT Employee_ID FROM evaluation ORDER BY Bonus DESC LIMIT 1)
SELECT `Name` FROM employee WHERE Employee_ID NOT IN (SELECT `Employee_ID` FROM evaluation GROUP BY `Employee_ID`)
-- What are the names of the employees who never received any evaluation? SELECT E.Name FROM employee AS E LEFT JOIN evaluation AS F ON E.Employee_ID = F.Employee_ID WHERE F.Year_awarded IS NULL GROUP BY E.Name;
SELECT S.`Name`, COUNT(*) AS `Number of Employees` FROM shop S JOIN hiring H ON S.Shop_ID = H.Shop_ID GROUP BY S.Shop_ID ORDER BY `Number of Employees` DESC LIMIT 1;
SELECT T1.`Name` FROM shop AS T1 JOIN hiring AS T2 ON T1.`Shop_ID` = T2.`Shop_ID` GROUP BY T1.`Name` ORDER BY COUNT(DISTINCT T2.`Employee_ID`) DESC LIMIT 1;
SELECT `Name` FROM shop WHERE Shop_ID NOT IN (SELECT `Shop_ID` FROM hiring)
SELECT DISTINCT S.`Name` AS Shop_name FROM shop AS S LEFT JOIN employee AS E ON S.Shop_ID = E.Employee_ID WHERE E.Employee_ID IS NULL;
SELECT sho.`Name`, COUNT(emp.`Employee_ID`) AS Num_of_Employees FROM shop sho JOIN hiring hir ON sho.`Shop_ID` = hir.`Shop_ID` JOIN employee emp ON hir.`Employee_ID` = emp.`Employee_ID` GROUP BY sho.`Shop_ID`
SELECT T1.Name, COUNT(T3.Employee_ID) as Number_of_employees FROM shop AS T1 JOIN hiring AS T2 ON T1.Shop_ID = T2.Shop_ID JOIN employee AS T3 ON T2.Employee_ID = T3.Employee_ID GROUP BY T1.Shop_ID, T1.`Name`
SELECT SUM(Bonus) FROM evaluation;
SELECT SUM(`Bonus`) FROM evaluation;
SELECT `Start_from`, `Is_full_time`, SHOP_Name, Employee_name FROM (SELECT h.`Start_from`, h.`Is_full_time`, s.Name AS SHOP_Name, e.Name AS Employee_name FROM hiring h INNER JOIN shop s ON h.Shop_ID = s.Shop_ID INNER JOIN employee e ON h.Employee_ID = e.Employee_ID) AS temp;
SELECT * FROM hiring AS T1 JOIN employee AS T2 ON T1.`Employee_ID` = T2.`Employee_ID` JOIN shop AS T3 ON T1.`Shop_ID` = T3.`Shop_ID`
SELECT DISTINCT s1.District, s3.Name FROM shop s3 JOIN shop s1 ON s1.Shop_ID = s3.Shop_ID AND s1.Number_products < 3000 JOIN shop s2 ON s2.Shop_ID != s3.Shop_ID AND s2.Shop_ID != s1.Shop_ID WHERE s2.Number_products > 10000;
-- Find the districts in which there are both shops selling less than 3000 products and shops selling more than 10000 products. SELECT s.District FROM shop AS s JOIN hiring AS h ON s.Shop_ID = h.Shop_ID GROUP BY s.District HAVING SUM(CASE WHEN s.Number_products < 3000 AND (h.Is_full_time = 'T' OR h.Is_full_time IS NULL) THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN s.Number_products > 10000 AND (h.Is_full_time = 'F' OR h.Is_full_time IS NULL) THEN 1 ELSE 0 END) > 0;
SELECT COUNT(DISTINCT `District`) FROM shop;
SELECT COUNT(DISTINCT District) FROM shop
SELECT COUNT(*) FROM Documents
SELECT COUNT(DISTINCT Document_Name) FROM Documents
SELECT Documents.`Document_ID`, Documents.`Document_Name`, Documents.`Document_Description` FROM Documents
SELECT D.Document_ID, D.Document_Name, D.Document_Description FROM Documents AS D
SELECT D.`Document_Name`, T.`Template_ID` FROM Documents AS D JOIN Templates AS T ON D.`Template_ID` = T.`Template_ID` WHERE LOWER(D.`Document_Description`) LIKE '%w%'
SELECT Documents.`Document_Name`, Templates.`Template_ID` FROM Documents JOIN Templates ON Documents.`Template_ID` = Templates.`Template_ID` WHERE Documents.`Document_Description` LIKE '%w%'
SELECT Document_ID, Template_ID, document_description AS Document_Description FROM Documents WHERE Document_name = 'Robbin CV'
SELECT d.Document_ID, t.Template_ID, d.Document_Description FROM Documents AS d JOIN Templates AS t ON d.Template_ID = t.Template_ID WHERE d.`Document_Name` = 'Robbin CV'
SELECT COUNT(DISTINCT `Template_ID`) FROM Documents
SELECT COUNT(DISTINCT T1.`Template_Type_Code`) FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code`
SELECT COUNT(*) FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code = 'PPT'
SELECT COUNT(DISTINCT `Documents`.Document_Name) FROM `Documents` JOIN `Templates` ON `Documents`.`Template_ID` = `Templates`.`Template_ID` WHERE `Templates`.Template_Type_Code = 'PPT'
SELECT T1.`Template_ID`, COUNT(T3.`Document_ID`) FROM Templates AS T1 LEFT JOIN Documents AS T2 ON T2.`Template_ID` = T1.`Template_ID` LEFT JOIN Paragraphs AS T3 ON T3.`Document_ID` = T2.`Document_ID` GROUP BY T1.`Template_ID`
SELECT T1.`Template_ID`, COUNT(*) FROM Documents AS T1 JOIN Templates AS T2 ON T1.`Template_ID` = T2.`Template_ID` GROUP BY T1.`Template_ID` ORDER BY COUNT(*) DESC
SELECT t1.`Template_Type_Code` , COUNT(t2.`Document_ID`) FROM Ref_Template_Types t1 INNER JOIN Documents t2 ON t1.`Template_Type_Code` = t2.`Template_ID` GROUP BY t1.`Template_Type_Code`;
SELECT T1.`Template_ID`, T1.`Template_Type_Code` FROM Templates AS T1 JOIN Documents AS T2 ON T1.`Template_ID` = T2.`template_id` GROUP BY T1.`Template_ID`, T1.`Template_Type_Code` ORDER BY COUNT(*) DESC LIMIT 1;
SELECT DISTINCT D.`Document_Name`, T.`Template_ID` FROM Documents D JOIN Templates T ON D.`Template_ID` = T.`Template_ID` GROUP BY T.`Template_ID` HAVING COUNT(D.`Template_ID`) > 1
SELECT DISTINCT T1.`Template_ID` FROM Templates AS T1 JOIN Documents AS T2 ON T1.`Template_ID` = T2.`Template_ID` GROUP BY T2.`Document_Name` HAVING COUNT(T2.`Template_ID`) > 1
SELECT DISTINCT T1.`Template_ID` FROM Templates AS T1 LEFT JOIN Documents AS T2 ON T1.`Template_ID` = T2.`Template_ID`;
SELECT `Template_ID`, `Version_Number` FROM Templates WHERE `Template_ID` NOT IN ( SELECT DISTINCT `Template_ID` FROM documents);
SELECT COUNT(Template_ID) AS Template_Count FROM Templates;
SELECT COUNT(*) FROM Templates;
SELECT T.TEMPLATE_ID, T.VERSION_NUMBER, TT.TEMPLATE_TYPE_CODE FROM Templates T JOIN Ref_Template_Types TT ON T.TEMPLATE_TYPE_CODE = TT.Template_Type_Code;
SELECT T1.*, T2.* FROM Templates AS T1 INNER JOIN Ref_Template_TYPES AS T2 ON T1.template_type_code = T2.template_type_code
SELECT DISTINCT `Template_Type_Code` FROM Documents JOIN Templates ON Documents.`Template_ID` = Templates.`Template_ID`;
SELECT `Template_Type_Code`, COUNT(DISTINCT `Document_ID`) AS num_documents FROM Documents INNER JOIN Templates ON Documents.`Template_ID` = Templates.`Template_ID` GROUP BY `Template_Type_Code`
SELECT `Template_ID` FROM Templates AS T1 CROSS JOIN Ref_Template_Types AS T2 WHERE (T2.`Template_Type_Code` = 'PP' OR T2.`Template_Type_Code` = 'PPT')
# Fix old SQL errors and simplify it. # SQLite Version 3.32.3 in-memory database. PRAGMA foreign_keys=off; -- Create Table Templates with necessary columns first. CREATE TABLE Templates ( `Template_ID` INTEGER PRIMARY KEY AUTOINCREMENT, `Version_Number` INTEGER, `Template_Type_Code` TEXT, `Date_Effective_From` TEXT ); INSERT INTO Templates ( Template_ID, Version_Number, Template_Type_Code, Date_Effective_From) VALUES (1, 5, 'PP', '2012-04-05'), (2, 8, 'PPT', '2012-07-11'), (3, 9, 'Paper', '2020-01-15'); CREATE TABLE Ref_Template_Types ( `Template_Type_Code` TEXT PRIMARY KEY, `Template_Type_Description` TEXT ); INSERT INTO Ref_Template_Types VALUES ('PP', 'Presentation'), ('PPT', 'Paper'), ('Paper', 'Advertisement'); -- Then attach database and execute the query in it. ATTACH 'database.db' AS db; # Now can execute your python script safely on this corrected SQL in SQLite. SELECT DISTINCT T.`Template_ID` FROM `db.Templates` AS T INNER JOIN `Ref_Template_Types` AS R ON T.`Template_Type_Code` = R.`Template_Type_Code` WHERE R.`Template-Type_Code` IN ('PP', 'PPT'); # Output the correct query result
SELECT COUNT(*) FROM Templates AS T1 JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T2.`Template_Type_Description` = 'CV'
SELECT COUNT(`Template_ID`) FROM Templates WHERE Template_Type_Code = (SELECT `Template_Type_Code` FROM Ref_Template_Types WHERE Template_Type_Description = 'CV')
SELECT T1.`Version_Number`, T2.`Template_Type_Description` AS Template_Types FROM Templates AS T1 JOIN Ref_Template_Types AS T2 ON T1.Template_TYPE_CODE = T2.Template_TYPE_CODE WHERE T1.Version_number > 5
SELECT `Version_Number`, `Template_Type_Code` FROM Templates WHERE `Version_Number` > 5;
SELECT RT.`Template_Type_Description`, COUNT(DISTINCT T.`Template_ID`) FROM Templates AS T JOIN Ref_Template_Types AS RT ON T.`Template_Type_Code` = RT.`Template_Type_Code` GROUP BY RT.`Template_Type_Description`;
SELECT RTT.`Template_Type_Code`, COUNT(T.`Template_ID`) AS TotalTplPerType, COUNT(DISTINCT D.`Document_ID`) AS TotalDocPerPageType FROM Ref_Template_Types AS RTT JOIN Templates AS T ON RTT.`Template_Type_Code` = T.`Template_Type_Code` LEFT JOIN Documents AS D ON T.`Template_ID` = D.`Template_ID` GROUP BY RTT.`Template_Type_Code`;
SELECT RTT.Template_Type_Code, COUNT(T.Template_ID) AS Number_of_Templates FROM Templates T JOIN Ref_Template_Types RTT ON T.Template_Type_Code = RTT.Template_Type_Code GROUP BY RTT.Template_Type_Code ORDER BY Number_of_Templates DESC;
SELECT T1.`Template_Type_Code`, COUNT(T2.`Document_ID`) as count FROM Ref_Template_Types AS T1 JOIN Documents AS T2 ON T1.`Template_Type_Code` = T2.`Template_ID` GROUP BY T1.`Template_Type_Code` ORDER BY count DESC LIMIT 1;
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types WHERE Template_Type_Code IN ( SELECT Template_Type_Code FROM Templates GROUP BY Template_Type_Code HAVING COUNT(*) < 3 )
SELECT `Template_Type_Code` FROM Ref_Template_Types WHERE `Template_Type_Code` IN (SELECT `Template_Type_Code` FROM Templates GROUP BY `Template_Type_Code` HAVING COUNT(*) < 3)
SELECT T2.`Template_Type_Code`, T2.`Version_Number` FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T2 ON T2.`Template_Type_Code` = T1.`Template_Type_Code` WHERE (T2.`Version_Number`) = (SELECT MIN(`Version_Number`) FROM Templates)
SELECT T1.Version_Number, T2.`Template_Type_Description` FROM Templates AS T1 INNER JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T1.Version_Number = (SELECT MIN(T1.Version_Number) FROM Templates T1)
SELECT RT.`Template_Type_Code` FROM Documents D JOIN Templates T ON D.`Template_ID` = T.`Template_ID` JOIN Ref_Template_Types RT ON T.`Template_Type_Code` = RT.`Template_Type_Code` WHERE D.`Document_Name` = 'Data base'
SELECT T3.`Template_Type_Code` FROM Ref_Template_Types AS T3 JOIN Templates AS T2 ON T3.`Template_Type_Code` = T2.`Template_Type_Code` JOIN Documents AS T1 ON T2.`Template_ID` = T1.`Template_ID` WHERE T1.`Document_Name` = 'Data base'
SELECT T1.`Document_Name` FROM Documents AS T1 JOIN Templates ON T1.`Template_ID` = Templates.`Template_ID` WHERE Templates.`Template_Type_Code` = 'BK'
SELECT Documents.`Document_Name` FROM Templates JOIN Documents ON Templates.`Template_ID` = Documents.`Template_ID` JOIN Ref_Template_Types ON Templates.`Template_Type_Code` = Ref_Template_Types.`Template_Type_Code` WHERE Ref_Template_Types.`Template_Type_Description`=' BK'
SELECT Ref_Template_Types.`Template_Type_Code`, COUNT(Templates.`Template_ID`) AS total FROM Ref_Template_Types JOIN Templates ON Ref_Template_Types.`Template_Type_Code` = Templates.`Template_Type_Code` GROUP BY Ref_Template_Types.`Template_Type_Code`;
SELECT Rt.`Template_Type_Code`, COUNT(D.`Document_Name`) AS `Number_of_documents` FROM Ref_Template_Types Rt JOIN Documents D ON Rt.`Template_Type_Code` = D.`Template_ID` GROUP BY Rt.`Template_Type_Code`;
SELECT T2.Template_Type_Code FROM Templates AS T1 INNER JOIN Ref_Template_Types AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code INNER JOIN Documents AS T3 ON T1.Template_ID = T3.Template_ID GROUP BY T2.Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1;
-- type: sql SELECT Templates.`Template_Type_Code`, COUNT(Templates.`Template_ID`) AS total_documents FROM Ref_Template_Types JOIN Templates ON Ref_Template_Types.`Template_Type_Code` = Templates.`Template_Type_Code` GROUP BY Templates.`Template_Type_Code` ORDER BY total_documents DESC LIMIT 1;
-- Show all template type codes that are not used by any document. SELECT DISTINCT T2.`Template_Type_Code` FROM Ref_Template_Types T1 JOIN Templates T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T2.`Template_ID` IS NOT NULL;
SELECT `Template_Type_Code` FROM Ref_Template_Types WHERE Template_Type_Code NOT IN ( SELECT `Template_Type_Code` FROM Templates );
SELECT tt.Template_Type_Code, tt.Template_Type_Description FROM Ref_Template_Types AS tt;
SELECT `Template_Type_Code`, `Template_Type_Description` FROM `Ref_Template_Types`
error: No SQL found in the input string
SELECT `Template_Type_Description` FROM Ref_Template_Types WHERE `Template_Type_Code` = 'AD'
SELECT T1.`Template_Type_Description` FROM Ref_Template_Types AS T1 WHERE `Template_Type_Code` = ( SELECT `Template_Type_Code` FROM Templates WHERE Template_ID IN ( SELECT Document_ID FROM Documents WHERE (`Document_Name` LIKE '%Robbin CV%' OR `Document_Name` LIKE 'Robbin CV') ) AND `Version_Number` = ( SELECT MAX(`Version_Number`) FROM Templates WHERE Template_ID IN ((SELECT `Template_ID` FROM Documents)) ) )
SELECT TT.Template_Type_Code FROM Ref_Template_Types TT JOIN Templates T ON TT.Template_Type_Code = T.Template_Type_Code WHERE TT.Template_Type_Description = 'Book'
SELECT DISTINCT `Template_Type_Description` FROM Ref_Template_Types JOIN Templates ON Ref_Template_Types.`Template_Type_Code` = Templates.`Template_Type_Code` JOIN Documents ON Templates.`Template_ID` = Documents.`Template_ID`
SELECT DISTINCT T3.`Template_Type_Description` FROM Documents AS T1 JOIN Templates AS T2 ON T1.`Template_ID` = T2.`Template_ID` JOIN Ref_Template_Types AS T3 ON T2.`Template_Type_Code` = T3.`Template_Type_Code`
SELECT `Template_ID` FROM Templates JOIN Ref_Template_Types ON Templates.`Template_Type_Code` = Ref_Template_Types.`Template_Type_Code` WHERE Ref_Template_Types.`Template_Type_Description` = 'Presentation'
SELECT Documents.`Document_ID`, Templates.`template_id` FROM Documents JOIN Templates ON Documents.`Template_ID` = Templates.`Template_ID` JOIN Ref_Template_Types AS T2 ON Templates.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T2."Template_Type_Description" = 'Presentation'
SELECT COUNT(Paragraph_ID) FROM Paragraphs;
SELECT COUNT(`Paragraph_ID`) AS `count` FROM Paragraphs
SELECT COUNT(*) FROM Paragraphs AS P JOIN Documents AS D ON P.`Document_ID` = D.`Document_ID` WHERE `D`.`Document_Name` = 'Summer Show'
SELECT COUNT(T2.Paragraph_Text) FROM Documents AS T1 JOIN Paragraphs AS T2 ON T1.Document_ID = T2.Document_ID WHERE T1.Document_Name = 'Summer Show'
SELECT T4.`Paragraph_Text`, T1.`Template_Type_Description` FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` JOIN Documents AS T3 ON T3.`Template_ID` = T2.`Template_ID` JOIN Paragraphs AS T4 ON T4.`Document_ID` = T3.`Document_ID` WHERE T4.`Paragraph_Text` = 'Korea '
SELECT P.Paragraph_Text, T.Template_Details FROM Paragraphs AS P JOIN Documents AS D ON P.Document_ID = D.Document_ID JOIN Templates AS T ON D.Template_ID = T.Template_ID WHERE P.Paragraph_Text LIKE '%Korea%'
SELECT Paragraph_ID, Paragraph_Text FROM Paragraphs WHERE Document_ID = (SELECT Document_ID FROM Documents WHERE Document_Name = 'Welcome to NY')
SELECT P.`Paragraph_ID`, P.`Paragraph_Text` FROM Paragraphs AS P JOIN Documents AS D ON P.`Document_ID` = D.`Document_ID` AND D.`Document_Name` = 'Welcome to NY'
SELECT DISTINCT P.`Paragraph_Text` FROM Paragraphs AS P INNER JOIN Documents AS D ON P.`Document_ID` = D.`Document_ID` WHERE D.`Document_Name` = 'Customer reviews'
SELECT `Paragraph_Text` FROM Paragraphs WHERE `Document_ID` = (SELECT `Document_ID` FROM Documents WHERE `Document_Name` = 'Customer reviews')
SELECT Documents.Document_ID, COUNT(Paragraphs.Paragraph_ID) AS Total_Participant_Count FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY Documents.Document_ID;
SELECT T1.`Document_ID`, COUNT(T2.`Paragraph_ID`) FROM Documents AS T1 JOIN Paragraphs AS T2 ON T1.`Document_ID` = T2.`Document_ID` GROUP BY T1.`Document_ID` ORDER BY T1.`Document_ID`
SELECT D.`Document_ID`, D.`Document_Name`, COUNT(P.`Paragraph_ID`) AS `Number_of_PARAGRAPHS` FROM Documents AS D JOIN Paragraphs AS P ON D.`Document_ID` = P.`Document_ID` GROUP BY D.`Document_ID`, D.`Document_Name`
SELECT D.Document_ID, D.Document_Name, COUNT(*) AS Paragraph_Count FROM Documents AS D JOIN Paragraphs AS P ON D.Document_ID = P.Document_ID GROUP BY D.Document_ID, D.Document_Name;
SELECT DISTINCT Documents.`Document_ID` FROM Documents INNER JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID HAVING COUNT(DISTINCT Paragraphs.Paragraph_ID) >= 2
SELECT DISTINCT d.Document_ID FROM Documents d GROUP BY d.Document_ID;
SELECT D.`Document_ID`, D.`Document_Name` FROM Documents D JOIN ( SELECT P.`Document_ID`, COUNT(P.Paragraph_ID) AS Paragraph_Count FROM Paragraphs P GROUP BY P.`Document_ID` ORDER BY Paragraph_Count DESC LIMIT 1 ) T ON D.`Document_ID` = T.`Document_ID`;
SELECT DISTINCT D.`Document_Name`, D.`Document_ID` FROM Documents AS D JOIN Paragraphs AS P ON P.`Document_ID`=D.`Document_ID` GROUP BY D.`Document_ID` ORDER BY COUNT(P.`Paragraph_ID`) DESC LIMIT 1;
SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY COUNT(Paragraphs.Paragraph_ID) ASC LIMIT 1;
-- Step 1: Identify the table and columns for the fewest paragraphs SELECT D.Document_ID FROM Documents D JOIN Paragraphs P ON D.Document_ID = P.Document_ID GROUP BY D.Document_ID, D.Template_ID ORDER BY COUNT(P.Paragraph_Text) ASC LIMIT 1;
SELECT Documents.Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID HAVING COUNT(Paragraphs.Paragraph_ID) BETWEEN 1 AND 2
SELECT `Document_ID` FROM Documents AS D WHERE EXISTS ( SELECT * FROM Paragraphs P WHERE D.`Document_ID` = P.`Document_ID` ) AND ( SELECT COUNT(P2.`Paragraph_ID`) FROM Paragraphs AS P2 WHERE D.`Document_ID` = P2.`Document_ID` ) BETWEEN 1 AND 2;
SELECT `Paragraph_ID`, `Document_Name` FROM Documents INNER JOIN Paragraphs ON Documents.`Document_ID` = Paragraphs.`Document_ID` WHERE `Paragraph_Text` IN ('Brazil', 'Ireland')
SELECT DISTINCT T2.`Document_ID` FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.`Document_ID` = T2.`Document_ID` WHERE T1.`Paragraph_Text` IN ('Brazil', 'Ireland')
SELECT COUNT(*) AS Num_Teachers FROM teacher;
SELECT COUNT(*) AS Total_Teachers FROM teacher;
SELECT Name FROM teacher ORDER BY Age ASC;
SELECT `Name` FROM teacher ORDER BY `Age` DESC NULLS LAST
SELECT Teacher_ID, Name, Age, Hometown FROM teacher ORDER BY Age DESC LIMIT 1;
SELECT Name, Hometown, Age FROM teacher
SELECT DISTINCT T1.`Name` FROM teacher AS T1 INNER JOIN course_arrange ON T1.`Teacher_ID` = course_arrange.`Teacher_ID` WHERE T1.`Hometown` != 'Little Lever Urban District'
SELECT Name FROM teacher WHERE Hometown <> 'Little Lever Urban District'
SELECT Name FROM teacher WHERE Age IN (32, 33)
SELECT Name FROM teacher WHERE Age IN (SELECT Grade FROM course_arrange WHERE Teacher_ID = 7) OR Age IN (SELECT Grade FROM course_arrange WHERE Teacher_ID = 'John Deloor')
SELECT T1.Hometown FROM teacher AS T1 JOIN course_arrange AS T2 ON T2.Teacher_ID = T1.Teacher_ID WHERE T2.Grade = (SELECT MIN(GRADE) FROM course_arrange)
SELECT `Hometown` FROM teacher WHERE Age = (SELECT MIN(Age) FROM teacher)
SELECT Hometown, COUNT(Teacher_ID) AS Number_of_teachers FROM teacher GROUP BY Hometown;
SELECT T1.Hometown, COUNT(T1.Name) FROM `teacher` AS T1 GROUP BY T1.Hometown
SELECT T1.Hometown FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.Teacher_ID = T2.Teacher_ID GROUP BY T1.Hometown ORDER BY COUNT(T2.Teacher_ID) DESC LIMIT 1;
SELECT Hometown, COUNT(*) as Count FROM teacher GROUP BY Hometown ORDER BY Count DESC
SELECT T1.Hometown FROM teacher as T1 JOIN course_arrange AS T3 ON T1.Teacher_ID = T3.Teacher_ID GROUP BY T1.Hometown HAVING COUNT(DISTINCT T1.Name) >= 2
SELECT DISTINCT T.Hometown FROM (SELECT course_arrange.Teacher_ID, teacher.Name, teacher.Age, teacher.Hometown FROM course_arrange JOIN teacher ON course_arrange.Teacher_ID = teacher.Teacher_ID GROUP BY teacher.Age HAVING COUNT(course_arrange.Course_ID) >= 2) AS T JOIN teacher ON T.Teacher_ID = teacher.Teacher_ID;
SELECT DISTINCT T2.Name, T1.`Course` FROM `course` AS T1 JOIN ( SELECT * FROM teacher JOIN `course_arrange` AS t3 ON Teacher_ID = t3.Teacher_ID; ) AS T4 on T1.Course_ID= T2.Course_ID AND T2. IS NOT NULL GROUP BY T1.`Course`
SELECT T1.Name, T3.Course FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.Teacher_ID = T2.Teacher_ID JOIN course AS T3 ON T2.Course_ID = T3.Course_ID;
SELECT T1.`Name`, T3.`Course` FROM teacher AS T1 JOIN course_arrange AS T2 ON T2.`Teacher_ID` = T1.`Teacher_ID` JOIN course AS T3 ON T2.`Course_ID` = T3.`Course_ID` ORDER BY T1.`Name` ASC
SELECT T1.Name, T2.Course FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.Teacher_ID = T2.Teacher_ID JOIN course AS T3 ON T3.Course_ID = T2.Course_ID GROUP BY T1.Name, T2.Course ORDER BY T1.Name ASC;
SELECT T1.Name FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.Teacher_ID = T2.Teacher_ID JOIN course AS T3 ON T2.Course_ID = T3.Course_ID WHERE T3.Course = 'Math'
-- What are the names of the people who teach math courses? SELECT DISTINCT T1.`Name` FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.`Teacher_ID` = T2.`Teacher_ID` JOIN course AS T3 ON T2.`Course_ID` = T3.`Course_ID` WHERE T3.`Course` LIKE 'Math' ORDER BY T1.`Name` ASC;
SELECT T3.Name, COUNT(T4.Course_ID) FROM teacher AS T3 JOIN course_arrange AS T4 ON T3.Teacher_ID = T4.Teacher_ID GROUP BY T3.Name;
SELECT T.`Name`, COUNT(CA.`Course_ID`) AS Course_Count FROM teacher T JOIN course_arrange CA ON T.`Teacher_ID` = CA.`Teacher_ID` JOIN course C ON CA.`Course_ID` = C.`Course_ID` GROUP BY T.`Name`;
SELECT Name FROM teacher AS T WHERE Teacher_ID IN ( SELECT Teacher_ID FROM course_arrange GROUP BY Teacher_ID HAVING COUNT(Course_ID) > 1 )
SELECT T2.Name FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.`Teacher_ID` = T2.`Teacher_ID` GROUP BY T2.Name HAVING COUNT(DISTINCT T1.Course_ID) > 1
SELECT `Name` FROM teacher WHERE `Teacher_ID` NOT IN (SELECT `Teacher_ID` FROM course_arrange)
SELECT Name FROM teacher WHERE Teacher_ID NOT IN (SELECT DISTINCT Teacher_ID FROM course_arrange);
SELECT COUNT(`ID`) FROM `visitor` WHERE Age < 30;
SELECT Name FROM visitor WHERE Level_of_membership > 4 Order by level_of_membership desc;
SELECT DISTINCT `Age` , AVG(`Age`) FROM visitor WHERE `Level_of_membership` <= 4
SELECT Name, Level_of_membership FROM visitor WHERE Level_of_membership > 4 ORDER BY Age ASC;
SELECT museum.`Name`, museum.`Museum_ID` FROM museum JOIN ( SELECT `Museum_ID`, MAX(`Num_of_Staff`) AS max_staff FROM museum GROUP BY `Museum_ID` ) ON museum.`Museum_ID` = museum.`Museum_ID` WHERE museum.`Num_of_Staff` = (SELECT MAX(max_staff) FROM ( SELECT `Museum_ID`, MAX(`Num_of_Staff`) AS max_staff FROM museum GROUP BY `Museum_ID` ) AS subquery)
SELECT AVG(`Num_of_Staff`) FROM museum WHERE `Open_Year` < '2009'
SELECT Open_Year, Num_of_Staff FROM museum WHERE Name LIKE '%Plaza Museum%'
-- find the names of museums which have more staff than the minimum staff number of all museums opened after 2010. SELECT DISTINCT Name FROM museum WHERE Num_of_Staff > ( SELECT MIN(Num_of_Staff) FROM museum WHERE CAST(REPLACE(Open_Year, '20', '') AS INT) > 10 ) -- Evidence: -- The minimum staff number of all museums opened after 2010 is indeed higher than any previous year when you convert the Open_Year to four-digit date, we just use CAST function.
SELECT visitor.ID, visitor.Name, visitor.Age FROM visitor JOIN visit ON visitor.ID = visit.visitor_ID GROUP BY visit.visitor_ID HAVING COUNT(DISTINCT Museum_ID) > 1;
SELECT vs.`ID`, Name, `Level_of_membership` FROM visitor vs JOIN visit v ON vs.ID = v.`visitor_ID` WHERE v.`Num_of_Ticket` > 0 AND v.`Total_spent` = ( SELECT MAX(`Total_spent`) FROM visit v2 WHERE v2.`Num_of_Ticket` > 0 )
SELECT M.Museum_ID, M.Name FROM museum AS M JOIN visit AS V ON M.Museum_ID = V.Museum_ID GROUP BY M.Museum_ID ORDER BY SUM(V.Num_of_Ticket) DESC LIMIT 1;
SELECT `Name` FROM museum WHERE `Museum_ID` NOT IN (SELECT `Museum_ID` FROM visit) OR `Museum_ID` = 0;
SELECT T1.`Name`, T1.`Age` FROM visitor AS T1 JOIN visit AS T2 ON T1.`ID` = T2.`Visitor_ID` WHERE T2.`Num_of_Ticket` = ( SELECT MAX(`Num_of_Ticket`) FROM visit )
SELECT SUM(`Num_of_Ticket`) / COUNT(visitor_ID) AS Average_tickets, MAX(`Num_of_Ticket`) AS Max_tickets FROM visit;
SELECT SUM(visit.Num_of_Ticket) AS Total_Ticket_Expense FROM visitor v JOIN visit ON v.ID = visit.visitor_ID WHERE v.Level_of_membership = 1;
SELECT V.`Name` FROM visitor AS V JOIN visit AS MV ON V.ID = MV.visitor_ID JOIN museum AS M ON MV.Museum_ID = M.Museum_ID WHERE (M.Open_Year < '2009' AND MV.Museum_ID IN (SELECT Museum_ID FROM museum WHERE Open_Year > '2011')) OR ((M.Open_Year > '2011') AND MV.Museum_ID NOT IN (SELECT Museum_ID FROM museum WHERE Open_Year = '2011')) GROUP BY V.`Name` HAVING COUNT(V.ID) = 2 ORDER BY COUNT(V.ID)
SELECT Num_of_Staff FROM museum m WHERE m.Museum_ID NOT IN (SELECT v.Museum_ID FROM visit v WHERE v.Total_spent > 200 GROUP BY Museum_ID HAVING SUM(Total_spent) / COUNT(DISTINCT visitor_ID) > 300)
SELECT COUNT(T1.`Name`) FROM museum AS T1 WHERE T1.`Open_Year` BETWEEN '2008' AND '2013'
SELECT COUNT(*) FROM players
SELECT COUNT(player_id) FROM players p INNER JOIN ( SELECT winner_id, loser_id FROM matches ) AS m ON p.player_id = m.winner_id OR p.player_id = m.loser_id ;
SELECT SUM(`best_of`) AS Total_Matches FROM matches WHERE `round` IN ('F', 'QF');
SELECT COUNT(*) FROM ( SELECT winner_id AS match_winner FROM matches UNION ALL SELECT loser_id AS match_loser FROM matches ) AS players;
SELECT `first_name`, `birth_date` FROM players WHERE `country_code` = 'USA' ORDER BY `birth_date` DESC;
SELECT `first_name`, `birth_date` FROM players AS P1 JOIN ( SELECT winner_name, winner_id FROM matches WHERE year=(SELECT MIN(year) FROM (`matches`)) GROUP BY winner_name) M ON P1.player_id=M.winner_id AND P1.country_code='USA';
SELECT AVG(`winner_age`) AS avg_winner_age, AVG(`loser_age`) AS avg_loser_age FROM matches WHERE `best_of` IS NOT NULL;
SELECT "Losers" AS group_name, AVG(YEAR(strftime('%Y', 'now')) - CAST(SUBSTR(p2.first_name || p2.last_name, 1, 4) AS INT)) AS avg_age FROM players p1 JOIN players p2 ON p1.player_id = p2.player_id AND (p2.hand IN ('L') OR p2.hand='R') UNION ALL SELECT "Winners" AS group_name, AVG(YEAR(strftime('%Y', 'now')) - CAST(SUBSTR(p2.first_name || p2.last_name, 1, 4) AS INT)) AS avg_age FROM players p1 JOIN players p2 ON p1.player_id = p2.player_id WHERE (p2.hand IN ('L') OR p2.hand= 'R')
SELECT AVG(r.winning_ranking) AS average_rank FROM ( SELECT winner_rank AS winning_ranking FROM matches UNION SELECT winner_rank_points / 10000 AS winning_ranking FROM matches ) r JOIN players p ON r.winning_ranking = p.player_id WHERE p.hand IN ('R', 'L')
SELECT AVG(ranking) AS `average_rank_for_winners` FROM players p JOIN matches m ON p.player_id = m.loser_id JOIN rankings r ON p.player_id = r.player_id;
SELECT MAX(T2.`ranking`) FROM players AS T1 INNER JOIN rankings AS T2 ON T1.player_id = T2.player_id WHERE T1.player_id IN ( SELECT T3.loser_id FROM matches AS T3 )
SELECT MAX(`ranking`) AS Best_Best_Loser_Rank FROM `rankings` WHERE player_id IN (SELECT loser_id FROM matches);
SELECT COUNT(`country_code`) FROM players;
SELECT COUNT(DISTINCT country_code) FROM players;
SELECT COUNT(DISTINCT loser_name) AS distinct_loser_names FROM matches;
SELECT COUNT(*) AS distinct_losers FROM ( SELECT DISTINCT winner_name FROM matches ) AS subquery
SELECT DISTINCT d.tourney_name FROM ( SELECT tourney_id, COUNT(*) AS num_matches FROM matches GROUP BY tourney_id ) b JOIN matches d ON b.tourney_id = d.tourney_id WHERE b.num_matches >= 10;
SELECT DISTINCT tourney_name FROM matches WHERE winner_id != '' OR loser_id != ''
SELECT DISTINCT winner_name FROM matches WHERE year IN (2013, 2016);
SELECT first_name, last_name FROM players WHERE player_id IN ( SELECT winner_id FROM matches WHERE year IN (2016, 2013) GROUP BY winner_id HAVING COUNT(DISTINCT year) = 2)
-- List the number of all matches who played in years of 2013 or 2016. SELECT COUNT(DISTINCT player_id) AS num_matches FROM players INNER JOIN MATCHES ON P1.`player_id` = `winner_id` OR P2.`player_id` = `loser_id` WHERE EXTRACT(YEAR FROM `tourney_date`) IN (2013, 2016) GROUP BY EXTRACT(YEAR FROM tourney_date) ORDER BY num_matches DESC;
SELECT COUNT(*) FROM matches WHERE year BETWEEN 2013 AND 2016
SELECT `country_code`, `first_name` FROM players WHERE player_id IN ( SELECT winner_id FROM matches WHERE tourney_name = 'WTA Championships' INTERSECT SELECT winner_id FROM matches WHERE tourney_name = 'Australian Open' )
SELECT first_name, country_code FROM players AS P JOIN ( SELECT `winner_id` FROM matches WHERE tourney_name IN ('WTA Championships', 'Australian Open') ) M ON P.player_id = M.winner_id;
SELECT first_name, country_code FROM players WHERE birth_date = (SELECT MAX(birth_date) FROM players);
SELECT first_name, country_code FROM players ORDER BY birth_date ASC LIMIT 1
SELECT first_name, last_name FROM players ORDER BY birth_date ASC;
SELECT CONCAT(first_name, ' ', last_name) AS name, birth_date FROM players ORDER BY birth_date ASC;
SELECT first_name, last_name FROM players WHERE hand = 'L' ORDER BY STRFTIME('%Y%m%d', birth_date) ASC;
SELECT first_name || ' ' || last_name AS fullnames FROM players JOIN matches ON (winner_id = player_id AND hand = 'L') OR (loser_id = player_id AND hand = 'L') WHERE hand = 'L' ORDER BY birth_date ASC;
SELECT first_name, country_code FROM players p INNER JOIN rankings r ON p.player_id = r.player_id WHERE r.tours = ( SELECT MAX(tours) FROM rankings );
SELECT first_name, country_code FROM players p JOIN rankings r ON p.player_id = r.player_id GROUP BY p.first_name, p.country_code HAVING COUNT(r.tours) = (SELECT MAX(tours) FROM rankings)
SELECT year FROM (SELECT year, COUNT(*) as count FROM matches GROUP BY year) AS subquery ORDER BY count DESC LIMIT 1;
SELECT year FROM ( SELECT year, COUNT(*) as count FROM matches GROUP BY year ) t ORDER BY count DESC LIMIT 1
SELECT P.name, R.rank_points FROM players AS P JOIN rankings AS R ON P.player_id = R.player_id WHERE P.hand IN ('R', 'L') AND R.ranking_points IN ( SELECT MAX(R1.rank_points) FROM rankings AS R1 JOIN matches AS M ON R1.player_id = M.winner_id GROUP BY R1.player_id, M.surface HAVING COUNT(DISTINCT M.year) >= 2 AND M.surface IN ('Hard', 'Clay', 'Grass') ) ORDER BY R.ranking_points DESC LIMIT 1;
# correct SQL SELECT P.first_name, P.last_name AS name, MAX(R.ranking_points) max_win_ranking FROM players P JOIN matches M ON (P.player_id = M.winner_id) JOIN ( SELECT player_id, MAX(ranking_points) ranking_points FROM rankings GROUP BY player_id ) R ON P.player_id = R.player_id GROUP BY P.first_name, P.last_name;
SELECT p.first_name, p.last_name FROM players AS p JOIN rankings AS r ON p.player_id = r.player_id WHERE r.ranking_points = (SELECT MAX(r2.ranking_points) FROM rankings AS r2 JOIN players AS p2 ON r2.player_id = p2.player_id JOIN matches AS m ON r2.player_id = m.winner_id AND m.tourney_name = 'Australian Open')
SELECT p.first_name, p.last_name FROM players AS p JOIN matches AS m ON p.player_id = m.winner_id WHERE (p.country_code, tourney_name) IN (('USA', 'Australian Open'));
SELECT T1.first_name, T2.loser_name as Loser , T2.minutes, T3.winner_name as Winner FROM players AS T1 JOIN matches AS T2 ON T1.player_id = T2.loser_id JOIN matches AS T3 ON T2.match_num = T3.match_num AND T2.minutes = ( SELECT MAX(T4.minutes) FROM matches T4 ) WHERE T2.minutes = ( SELECT MAX(minutes) FROM matches );
SELECT T1.first_name, T2.winner_name AS winner, T2.loser_name AS loser, T3.score AS long_score_from_winner, T4.score AS long_score_from_loser, T3.minutes AS winner_minutes, T4.minutes AS loser_minutes FROM players AS T1 JOIN `matches` AS T2 ON T1.player_id = T2.loser_id LEFT JOIN `matches` T3 ON T1.player_id = T3.winner_id AND T3.minutes > ( SELECT MIN(minutes) FROM `matches`) LEFT JOIN `matches` T4 ON T1.player_id = T4.loser_id AND T4.minutes > ( SELECT MAX(minutes) FROM `matches`)
SELECT p.first_name, AVG(r.ranking) FROM players AS p JOIN rankings AS r ON p.player_id = r.player_id GROUP BY p.first_name;
SELECT T1.first_name, AVG(T2.ranking) AS avg_raking FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name;
SELECT P. `first_name`, SUM(R.`ranking_points`) AS total_ranking_points FROM players P INNER JOIN rankings R ON (P.`player_id` = R.`player_id`) GROUP BY P.`first_name` ORDER BY total_ranking_points DESC;
SELECT p.first_name, r.ranking_points AS total_ranking_points FROM players p JOIN rankings r ON p.player_id = r.player_id GROUP BY p.first_name;
SELECT `country_code`, COUNT(DISTINCT `player_id`) AS num_players FROM `players` GROUP BY `country_code`
SELECT pl.country_code, COUNT(*) FROM players AS pl JOIN matches AS m ON pl.player_id = m.loser_id AND pl.player_id = m.winner_id GROUP BY pl.country_code
SELECT country_code FROM ( SELECT country_code, COUNT(*) as countplayer FROM players GROUP BY country_code ORDER BY countplayer DESC LIMIT 1 ) AS C
SELECT country_code, COUNT(*) as num_of_players FROM players GROUP BY country_code HAVING COUNT(*) = ( SELECT MAX(num_of_players) FROM ( SELECT country_code, COUNT(*) as num_of_players FROM players GROUP BY country_code ) AS subquery )
SELECT p.country_code FROM players p JOIN ( SELECT player_id, COUNT(*) FROM players GROUP BY player_id ) AS subquery ON p.player_id = subquery.player_id GROUP BY subquery.player_id HAVING COUNT(*) > 50;
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(player_id) > 50
SELECT `ranking_date`, SUM(`tours`) AS total_tours FROM rankings GROUP BY `ranking_date`
SELECT ranking_date AS dates, SUM(tours) AS total_tours FROM rankings GROUP BY ranking_date;
SELECT YEAR, COUNT(*) AS num_matches FROM matches GROUP BY YEAR ORDER BY YEAR
SELECT year, COUNT(tourney_id) as matches_count FROM matches WHERE (year = '2013' AND tourney_level IN ('I', 'W')) OR (year IN ('2016', '2017') AND (tourney_name IN ('US Open', 'Indian Wells'))) GROUP BY year;
WITH youngest_player AS ( SELECT `player_id` FROM players ORDER BY `birth_date` ASC LIMIT 1 ), winning_players AS ( SELECT DISTINCT m.`winner_id` FROM matches AS m JOIN players AS p ON m.`winner_id` = p.`player_id` ) SELECT p.`first_name`, p.`last_name`, r.`ranking` FROM winning_players wp JOIN players p ON wp.`winner_id` = p.`player_id` JOIN rankings r ON p.`player_id` = r.`player_id` WHERE p.`player_id` IN (SELECT `winner_id` FROM youngest_player);
SELECT p.first_name, p.last_name, r.ranking FROM players AS p JOIN rankings AS r ON p.player_id = r.player_id JOIN ( SELECT winner_hand, MAX(tourney_date) AS max_tourney_date FROM matches GROUP BY winner_hand ) AS ranked_matches ON p.hand = ranked_matches.winner_hand AND p.birth_date > (SELECT MIN(birth_date) FROM players) ORDER BY p.birth_date ASC LIMIT 3;
SELECT COUNT(DISTINCT winner_id) FROM matches JOIN players ON matches.winner_id = players.player_id WHERE tourney_level = 'W' AND players.hand = 'L' AND matches.tourney_name LIKE '%WTA Championships%'
SELECT COUNT(*) FROM matches AS T1 JOIN players AS T2 ON T1.winner_id = T2.player_id WHERE T1.tourney_name LIKE '%WTA Championships%' AND T2.hand = 'L'
SELECT p.first_name, p.country_code, p.birth_date FROM players p JOIN rankings r ON p.player_id = r.player_id WHERE r.ranking_points = (SELECT MAX(ranking_points) FROM rankings);
SELECT p.first_name, p.country_code, p.birth_date FROM players p JOIN rankings r ON p.player_id = r.player_id WHERE r.ranking_points IN ( SELECT MAX(ranker.ranking_points) FROM rankings ranker WHERE ranker.ranking_points IS NOT NULL ) ORDER BY birht_date ASC;
SELECT COUNT(*) AS Number_of_players, `hand`, CASE WHEN `hand` = 'R' THEN ( SELECT COUNT(player_id) FROM players ) ELSE 0 END AS Num_R, CASE WHEN `hand` = 'L' THEN ( SELECT COUNT(player_id) FROM players ) ELSE 0 END AS Num_L FROM players GROUP BY (`hand`)
SELECT `hand`, COUNT(*) * 1.0 / (SELECT COUNT(*) FROM `matches`) AS `ratio_per_match` FROM players GROUP BY `hand`
SELECT COUNT(*) FROM ship WHERE disposition_of_ship = 'Captured'
SELECT name, tonnage FROM ship ORDER BY name ASC;
SELECT T1.`name`, T3.`date`, T1.`result` FROM battle AS T1 LEFT JOIN ship AS T2 ON T1.`id` = T2.`lost_in_battle` LEFT JOIN battle AS T3 ON T2.`lost_in_battle` = T3.`id`
SELECT b.id AS Battle_id, COALESCE(SUM(d.killed) FILTER (WHERE d.caused_by_ship_id IS NOT NULL), 0) AS Total_Killed, COALESCE(MIN(CASE WHEN d.caused_by_ship_id IS NOT NULL THEN d.killed END), 0) AS Min_Killed, COALESCE(MAX(CASE WHEN d.caused_by_ship_id IS NOT NULL THEN d.killed END), 0) AS Max_Killed FROM battle b LEFT JOIN death d ON b.id = d.caused_by_ship_id -- Assuming 'note' column doesn't need to be involved. GROUP BY b.id;
SELECT AVG(killed) + AVG(injured) AS avg_total_harm FROM death
SELECT d.`killed`, d.`injured` FROM death AS d JOIN ship AS s ON s.`lost_in_battle` = d.`caused_by_ship_id` WHERE s.tonnage = 't'
SELECT `name`, `result` FROM battle WHERE `bulgarian_commander` <> 'Boril'
SELECT DISTINCT T2.`id`, T1.name FROM `ship` AS T1 JOIN battle AS T2 ON T2.id = T1.lost_in_battle WHERE T1.ship_type = 'Brig'
SELECT T1.id, T2.name FROM battle AS T1 JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE T2.disposition_of_ship <> 'Scuttled' AND (SELECT SUM(T4.killed + T4.injured) FROM death AS T4 WHERE T4.caused_by_ship_id = T2.id) > 10;
SELECT s.`id`, s.`name` FROM `ship` AS s JOIN death AS d ON s.`lost_in_battle` = d.`caused_by_ship_id` GROUP BY s.`id` ORDER BY SUM(`d`.killed) + SUM(`d`.injured) DESC LIMIT 1;
SELECT DISTINCT `name` FROM battle WHERE (`bulgarian_commander` = 'Kaloyan' AND `latin_commander` IN ('Thierry de Termond', 'John of Brienne', 'Boniface of Montferrat')) OR (`bulgarian_commander` IN ('Kaloyan', 'Boril', 'Unknown', 'Ivan Asen II') AND `latin_commander` = 'Baldwin I')
SELECT COUNT(DISTINCT result) AS Number_of_differents_results FROM battle;
SELECT COUNT(*) FROM battle WHERE id NOT IN ( SELECT distinct(T1.`lost_in_battle`) FROM ship AS T1 JOIN battle AS T2 ON T1.`lost_in_battle` = T2.id WHERE tonnage = '225' )
SELECT T1.`name`, T1.`date` FROM battle AS T1 JOIN ship AS T2 ON T1.`id` = T2.`lost_in_battle` WHERE T2.name IN ('Lettice', 'HMS Atalanta') AND T2.disposition_of_ship IN ('Scuttled','Wrecked','Sank');
SELECT name, result, ( SELECT bulgarian_commander FROM battle AS T2 WHERE T2.id = T1.id LIMIT 1) AS bulgarianCommander FROM battle AS T1 WHERE id NOT IN ( SELECT id FROM ship WHERE location = 'English Channel' AND ( disposition_of_ship != 'Scuttled' OR disposition_of_ship IS NULL ) );
SELECT DISTINCT d.`note` FROM death d JOIN battle b ON d.caused_by_ship_id = b.id AND b.`name` LIKE '%East%'
SELECT `line_1`, `line_2` FROM Addresses;
SELECT line_1 AS street_number, line_2 AS city_and_zipcode, line_3 AS address_line_three FROM Addresses;
SELECT COUNT(*) FROM Courses AS t1 INNER JOIN Sections AS t2 ON t1.course_id = t2.course_id;
SELECT COUNT(`section_name`) FROM Sections;
SELECT `department_description` FROM Departments WHERE `department_name` = 'math'
SELECT section_description FROM Sections WHERE course_id IN (SELECT course_id FROM Courses WHERE course_name = 'math')
SELECT `zip_postcode` FROM Addresses WHERE `city` = 'Port Chelsea'
SELECT zip_postcode FROM Addresses WHERE city = 'Port Chelsea'
SELECT `Department_name`, COUNT(DISTINCT `Degree_summary_name`) as degree_count FROM Degree_Programs JOIN Departments AS Department ON Degree_Programs.department_id = Department.department_id GROUP BY `Department_name` ORDER BY degree_count DESC;
SELECT DP.department_id, COUNT(SE.student_id) as count FROM Degree_Programs DP JOIN Student_Enrolment SE ON DP.degree_program_id = SE.degree_program_id GROUP BY DP.department_id ORDER BY count DESC LIMIT 1;
SELECT COUNT(`department_name`) FROM `Departments`;
SELECT COUNT(DISTINCT `department_name`) FROM Departments;
SELECT COUNT(`degree_summary_name`) FROM Degree_Programs
SELECT COUNT(DISTINCT `degree_summary_name`) FROM `Degree_Programs`
SELECT COUNT(DISTINCT degree_summary_name) FROM Degree_Programs AS T1 JOIN Departments AS T2 ON T1.department_id = T2.department_id WHERE T2.department_name = 'engineering';
SELECT COUNT(*) FROM Degree_Programs dp WHERE dp.degree_summary_description LIKE '%Engineering%';
SELECT S.section_name, C.course_name AS Course_Name, S.section_description FROM `Sections` S -- Joined Sections table with Courses LEFT JOIN `Courses` C ON S.course_id = C.course_id GROUP BY S.section_name, C.course_name ORDER BY section_name;
SELECT section_name, section_description FROM Sections
SELECT c.`course_name`, sc.course_id FROM Courses c JOIN ( SELECT course_id FROM Sections GROUP BY course_id HAVING COUNT(section_id) <= 2 ) s ON c.`course_id` = s.course_id;
SELECT Course_Name, Course_id FROM Courses WHERE Course_id NOT IN ( SELECT course_id FROM Sections GROUP BY course_id HAVING COUNT(section_id) >= 2 )
SELECT `section_name` FROM `Sections` ORDER BY `section_name` ASC NULLS LAST;
SELECT section_name FROM Sections ORDER BY section_name DESC;
SELECT semester_name, semester_id FROM Semesters WHERE semester_id IN ( SELECT semester_id FROM Student_Enrolment GROUP BY semester_id ORDER BY COUNT(*) DESC LIMIT 1 )
SELECT semester_id, semester_name, COUNT(DISTINCT student_enrolment_id) FROM ( SELECT Student_Enrolment.semester_id, Student_Enrolment.semester_id AS semester_enrolment_id, Semesters.semester_name, Student_Enrolment.student_enrolment_id FROM Student_Enrolment JOIN Semesters ON Student_Enrolment.semester_id = Semesters.semester_id ) t GROUP BY semester_id, semester_name ORDER BY COUNT(*) DESC LIMIT 1;
SELECT `department_description` FROM Departments WHERE `department_name` LIKE '%the computer%'
SELECT D.department_description FROM Departments AS D WHERE D.department_name LIKE '%computer%'
SELECT T2.first_name, T2.middle_name, T2.last_name, T2.student_id FROM Student_Enrolment_Courses AS T1 JOIN Students AS T2 ON T1.student_enrolment_id = T2.student_id WHERE T1.course_id IN ( SELECT course_id FROM Sections GROUP BY course_id HAVING COUNT(course_id) >= 2 ) ORDER BY student_id;
SELECT S.student_id, S.first_name, S.middle_name, S.last_name FROM Students AS S JOIN Student_Enrolment AS SE ON S.student_id = SE.student_id GROUP BY S.student_id, S.first_name, S.middle_name, S.last_name HAVING COUNT(SE.degree_program_id) >= 2;
SELECT S.first_name AS FirstName, S.middle_name AS MiddleName, S.last_name AS LastName FROM Students S JOIN Student_Enrolment SE ON S.student_id = SE.student_id WHERE SE.degree_program_id IN ( SELECT degree_program_id FROM Degree_Programs WHERE degree_summary_name = 'Bachelor' )
SELECT S.`first_name`, S.`middle_name`, S.`last_name` FROM Students S JOIN Student_Enrolment SE ON S.student_id = SE.student_id WHERE SE.degree_program_id IN (SELECT degree_program_id FROM Degree_Programs WHERE degree_summary_name LIKE 'Bachelor')
error: No SQL found in the input string
SELECT `degree_summary_name` FROM `Degree_Programs` WHERE `degree_summary_name` = (SELECT deg.`degree_summary_name` FROM `Student_Enrolment` sem INNER JOIN `Degree_Programs` deg ON sem.`degree_program_id` = deg.`degree_program_id` GROUP BY deg.`degree_summary_name` ORDER BY COUNT(sem.student_enrolment_id) DESC LIMIT 1)
SELECT T2.`degree_summary_name` FROM Student_Enrolment AS T1 JOIN Degree_Programs AS T2 ON T1.`student_enrolment_id` = ( SELECT student_enrolment_id FROM ( SELECT student_enrolment_id, COUNT(*) as count FROM Student_Enrolment GROUP BY student_enrolment_id ) AS T3 ORDER BY `count` DESC LIMIT 1 ) GROUP BY T2.`degree_summary_name`
SELECT Student_Enrolment.degree_program_id, SUM(CASE WHEN Student_enrolment.semester_id IS NOT NULL THEN 1 ELSE 0 END) AS total_semesters FROM Student_Enrolment GROUP BY Student_Enrolment.degree_program_id ORDER BY total_semesters DESC LIMIT 1;
SELECT s.student_id, s.first_name, s.middle_name, s.last_name, COUNT(se.student_id) as num_enrollments FROM Student_Enrolment se JOIN Students s ON se.student_id = s.student_id GROUP BY s.student_id, s.first_name, s.middle_name, s.last_name ORDER BY COUNT(se.student_id) DESC LIMIT 1;
SELECT Students.`first_name`, Students.`middle_name`, Students.`last_name`, Students.`student_id`, COUNT(Student_Enrolment_Courses.`course_id`) AS `number_of_enrollments` FROM Students JOIN Student_Enrolment ON Students.`student_id` = Student_Enrolment.`student_id` JOIN Student_Enrolment_Courses ON Student_Enrolment.`student_enrolment_id` = Student_Enrolment_Courses.`student_enrolment_id` GROUP BY Students.`student_id` ORDER BY number_of_enrollments DESC LIMIT 1;
SELECT T1.semester_name FROM Semesters AS T1 LEFT JOIN Student_Enrolment AS T2 ON T1.semester_id = T2.semester_id GROUP BY T1.semester_id HAVING SUM(T2.student_enrolment_id) IS NULL;
SELECT `semester_name` FROM Semesters WHERE semester_id NOT IN (SELECT semester_id FROM Student_Enrolment)
SELECT `course_name` FROM Courses WHERE `course_id` IN ( SELECT `course_id` FROM Student_Enrolment_Courses )
SELECT T3.course_name FROM Student_Enrolment_Courses AS T1 JOIN Courses AS T3 ON T1.course_id = T3.course_id;
SELECT `course_name` FROM Courses WHERE course_id = (SELECT student_course_id FROM Student_Enrolment_Courses GROUP BY course_id ORDER BY COUNT(*) DESC LIMIT 1);
SELECT Courses.`course_name` AS `MaxStudentsCourse` FROM Courses JOIN ( SELECT Student_Enrolment_Courses.`course_id`, COUNT(Student_Enrolment_Courses.`student_enrolment_id`) AS `total_students_count` FROM Student_Enrolment_Courses GROUP BY Student_Enrolment_Courses.`course_id` ) course_cnt ON Courses.`course_id` = course_cnt.`course_id` WHERE course_cnt.total_students_count = (SELECT MAX(total_students_count) FROM ( SELECT COUNT(`student_enrolment_id`) AS total_students_count FROM `Student_Enrolment` ) as max_cnt);
SELECT s.last_name FROM Students AS s INNER JOIN Addresses AS a ON s.current_address_id = a.address_id WHERE a.state_province_county = 'North Carolina' AND s.student_id NOT IN ( SELECT student_id FROM Student_Enrolment )
SELECT Students.last_name FROM Students INNER JOIN Addresses ON Students.current_address_id = Addresses.address_id WHERE Addresses.state_province_county = 'North Carolina' AND NOT EXISTS ( SELECT 1 FROM Student_Enrolment WHERE Student_Enrolment.student_id = Students.student_id );
SELECT DISTINCT T1.`Transcript_date`, T1.`Transcript_id` FROM Transcripts AS T1 JOIN Transcript_Contents AS T2 ON T1.`Transcript_id` = T2.`transcript_id` JOIN Student_Enrolment_Courses AS T3 ON T3.`student_course_id` = T2.`student_course_id` JOIN Student_Enrolment_Courses AS T4 ON T3.student_enrolment_id = T4.student_enrolment_id WHERE T3.course_id IN (SELECT student_course_id FROM Student_Enrolment_Courses GROUP BY student_course_id HAVING COUNT(*) >= 2) GROUP BY T1.`Transcript_date`, T1.`Transcript_id`
SELECT `transcript_date`, `transcript_id` FROM Transcripts WHERE (select count(*) FROM Transcript_Contents AS TC INNER JOIN Student_Enrolment_Courses SEC ON TC.student_course_id = SEC.student_course_id WHERE TC.transcript_id = Transcripts.`transcript_id`) >= 2;
SELECT cell_mobile_number FROM Students WHERE first_name = 'Timmothy' AND last_name = 'Ward'
SELECT cell_mobile_number FROM Students WHERE first_name = 'Timmothy' AND last_name = 'Ward'
SELECT first_name, middle_name, last_name FROM Students ORDER BY date_first_registered ASC LIMIT 1;
SELECT CONCAT(first_name, ' ', middle_name, ' ', last_name) AS full_names FROM Students ORDER BY date_first_registered ASC LIMIT 1;
WITH -- Get student IDs from Student_Enrolment where DATE_LEFT is NULL (ongoing students) ongoing_students AS ( SELECT s.student_id FROM Students s WHERE s.date_left IS NULL ) SELECT m.First_Name, o.Middle_Name, n.Last_Name FROM ( SELECT d.student_id, MAX(c.Date_Parte) AS Date_last_copmleted,--get last completed date of student, assuming there are records. MIN(f.missing_value_part)--calculate missing year from transcript in the next academic ) t JOIN ongoing_students o ON tstudent_id=o.student_id JOIN ( SELECT s/student_id, d.date_left + INTERVAL 1 YEAR FROM Students s WHERE S.DateLEFT IS NULL --find out students OR student_id IN (SELECT student_ID FROM Student_enrolment WHERE Transcript_date >= Date_parte(coursecdate_part)) --students who have transcript record since last year JOIN Courses c ON se.CourseID = c.CourseID GROUP BY se.student_id ) se ON tstudent_id=se.student_id LEFT JOIN ( SELECT s/student_id, MAX(t.date_left - INTERVAL (year(t.Dateparte()-year(current_date())-INT(Case WHEN c.years is not null THEN c.years ELSE 0 END)))) year FROM Student_Enrolment se JOIN Courses C ON SE.COURSEID = c.Course_ID ) q On se.student_id=se.student_id INNER join ( SELECT s.student_id FROM Students s RIGHT JOIN ( SELECT s.student_id, MAX(t.date_left + INTERVAL 1 YEAR - date_part year(coursecdate_part)) AS missing_value_part , FROM Student_Enrolment SE JOIN Courses c ON se.CourseID = c.CourseID GROUP BY S/student_ID ) d on t.student_id=d.student_id
SELECT first_name, middle_name, last_name FROM Students WHERE student_id = (SELECT Min(student_id) FROM Students WHERE ssn = (SELECT MIN(ssn) FROM Students));
SELECT distinct(first_name) FROM Students WHERE permanent_address_id != current_address_id;
SELECT s.`first_name` FROM Students s JOIN Addresses p ON s.permanent_address_id = p.address_id JOIN Addresses c ON s.current_address_id = c.address_id WHERE p.line_1 != c.line_1 AND p.line_2 != c.line_2 AND p.line_3 != c.line_3 GROUP BY s.`first_name`
SELECT A.`address_id`, A.line_1, A.line_2, A.line_3 FROM Addresses AS A JOIN Students AS S ON A.`address_id` = S.current_address_id GROUP BY A.`address_id` ORDER BY COUNT(S.student_id) DESC LIMIT 1;
SELECT Addresses.`address_id`, Addresses.line_1, Addresses.line_2 FROM Students JOIN Addresses ON Students.`permanent_address_id` = Addresses.`address_id` GROUP BY Addresses.address_id ORDER BY COUNT(Students.student_id) DESC LIMIT 1;
SELECT AVG(`transcript_date`/1000) AS avg_transcript_date FROM Transcripts;
SELECT AVG(transcript_date) AS avg_transcript_date FROM Transcripts;
SELECT `transcript_date`, `other_details` FROM Transcripts WHERE `transcript_id` = (SELECT MIN(`transcript_id`) FROM Transcripts)
SELECT T2.student_course_id, T3.course_name FROM Transcript_Contents AS T2 JOIN Student_Enrolment_Courses AS T1 ON T2.student_course_id = T1.student_course_id JOIN Courses AS T3 ON T1.course_id = T3.course_id;
SELECT COUNT(`transcript_id`) FROM Transcripts;
SELECT COUNT(*) FROM Transcripts;
SELECT `transcript_date` FROM Transcripts ORDER BY `transcript_date` DESC LIMIT 1;
SELECT MAX(transcript_date) FROM Transcripts;
SELECT COUNT(DISTINCT tc.transcript_id) AS max_count, ec.course_name FROM Transcript_Contents tc JOIN Student_Enrolment_Courses sec ON tc.student_course_id = sec.student_course_id JOIN Courses c ON sec.course_id = c.course_id JOIN Student_Enrolment se ON sec.student_enrolment_id = se.student_enrolment_id GROUP BY ec.course_name;
SELECT MAX(t2.course_count), t1.student_enrolment_id FROM Student_Enrolment AS t1 JOIN ( SELECT student_course_id, COUNT(*) as course_count FROM Transcript_Contents AS t3 GROUP BY student_course_id ) AS t2 ON t1.student_enrolment_id = t2.student_course_id;
SELECT T.transcript_date, T.transcript_id FROM ( SELECT `Transcript_ID`, COUNT(`student_course_id`) AS CT FROM Transcript_Contents GROUP BY `Transcript_ID` ) AS S JOIN ( SELECT `transcript_date`, COUNT(TC.student_course_id) AS CTa FROM ( SELECT T.`transcript_date`, COUNT(T.`student_course_id`) AS student_count FROM Transcript_Contents as TC INNER JOIN Student_Enrolment_Courses as SC ON TC.student_course_id = SC.student_course_id GROUP BY T.`transcript_date` ) T GROUP BY T.transcript_date ) AS R ON S.CT = R.CTa HAVING CT=a;
SELECT transcript_id, student_course_id, MIN(num_results) AS least_num_results FROM ( SELECT t1.transcript_id,t2.student_course_id,COUNT(*) AS num_results FROM Transcripts AS t1 JOIN Transcript_Contents AS t2 ON t1.transcript_id = t2.transcript_id GROUP BY transcipt_id, student_course_id ) tmp GROUP BY transcript_id
SELECT semester_name FROM Semesters WHERE semester_id IN ( SELECT semester_id FROM Student_Enrolment GROUP BY semester_id HAVING SUM(CASE WHEN degree_program_id = (SELECT degree_program_id FROM Degree_Programs WHERE degree_summary_name = 'Bachelor') THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN degree_program_id = (SELECT degree_program_id FROM Degree_Programs WHERE degree_summary_name = 'Master') THEN 1 ELSE 0 END) > 0 )
-- What is the id of the semester that had both Masters and Bachelors students enrolled? SELECT T2.semester_id FROM Student_Enrolment AS T1 JOIN Semesters AS T2 ON T1.semester_id = T2.semester_id GROUP BY T2.semester_id HAVING ( SELECT COUNT(*) FROM ( SELECT * FROM Degree_Programs AS DP WHERE DP.degree_summary_name IN ('Master', 'Bachelor') AND DP.department_id = T1.degree_program_id ) R ) > 0;
SELECT COUNT(DISTINCT current_address_id) FROM Students;
SELECT DISTINCT `line_1`, `line_2`, `line_3`, `city`, `zip_postcode`, `state_province_county`, `country`, `other_address_details` FROM Addresses WHERE address_id IN ( SELECT current_address_id FROM Students UNION SELECT permanent_address_id FROM Students )
SELECT first_name, last_name, email_address, cell_mobile_number, ssn FROM Students ORDER BY last_name ASC, first_name ASC;
SELECT `other_student_details` FROM Students ORDER BY `last_name` DESC, `first_name` DESC;
SELECT C.course_name, D.department_name FROM Courses AS C JOIN Departments AS D ON C.course_id = D.department_id JOIN Sections AS S ON C.course_id = S.course_id WHERE S.section_name = 'h';
SELECT `section_description` FROM Sections WHERE `section_name` = 'h'
SELECT first_name FROM Students WHERE cell_mobile_number = '09700166582' OR permanent_address_id IN (SELECT address_id FROM Addresses WHERE country='Haiti');
SELECT `first_name` FROM Students WHERE permanent_address_id IN ( SELECT address_id FROM Addresses WHERE country = 'Haiti' ) OR cell_mobile_number LIKE '%09700166582%'
SELECT `Title` FROM Cartoon ORDER BY `Title` ASC;
SELECT Title FROM Cartoon ORDER BY LOWER(Title) ASC;
SELECT `Title` FROM `Cartoon` WHERE `Directed_by` = 'Ben Jones'
SELECT `Title` FROM Cartoon WHERE LOWER(`Directed_by`) LIKE '%ben jones%'
SELECT COUNT(*) FROM Cartoon c WHERE c.Written_by = 'Joseph Kuhr';
SELECT COUNT(Title) FROM Cartoon WHERE Written_by = 'Joseph Kuhr'
SELECT DISTINCT c.Title, d.directed_by FROM Cartoon AS c JOIN TV_series AS tv ON c.channel = tv.channel JOIN TV_Channel AS t ON tv.Channel = t.id JOIN Cartoon AS d ON t.id = d.channel ORDER BY t.series_name, c.Original_air_date;
# Table: TV_Channel [ (id, id.), (series_name, series name. Value examples: ['myDeejay', 'Sky Radio', 'Sky Music', 'Rock TV', 'Radio Capital TiVù', 'Music Box Italia'].), (Country, country. Value examples: ['Italy', 'United Kingdom', 'Poland'].), (Language, language. Value examples: ['Italian', 'English'].), (Content, content. Value examples: ['music'].), (Pixel_aspect_ratio_PAR, pixel aspect ratio par. Value examples: ['4:3', '16:9', '4:3 / 16:9'].), (Hight_definition_TV, hight definition tv. Value examples: ['no', 'yes'].), (Pay_per_view_PPV, pay per view ppv. Value examples: ['no'].), (Package_Option, package option. Value examples: ['Sky Famiglia', 'no ( FTV )', 'Sky Famiglia + Sky HD', 'Option'].) ] # Table: TV_series [ (id, id.), (Episode, episode. Value examples: ['Winterland', 'The Year of the Rabbit', 'The Legend of Dylan McCleen', 'The Hanged Man', 'Keepers', 'Home By Another Way'].), (Air_Date, air date. Value examples: ['September 24, 2007', 'October 8, 2007', 'October 29, 2007', 'October 22, 2007', 'October 15, 2007', 'October 1, 2007'].), (Channel, channel.), (Rating, rating. Value examples: ['3.7', '5.8', '5.3', '4.4', '4.3', '4.0'].), (Share, share. Value examples: [6.0, 7.0, 9.0, 5.0].) ] # Table: Cartoon [ (id, id.), (Title, title. Value examples: ['The Rise of the Blue Beetle!', 'The Eyes of Despero!', 'Terror on Dinosaur Island!', 'Return of the Fearsome Fangs!', 'Journey to the Center of the Bat!', 'Invasion of the Secret Santas!'].), (Directed_by, directed by. Value examples: ['Michael Chang', 'Brandon Vietti', 'Ben Jones'].), (Written_by, written by. Value examples: ['Todd Casey', 'Steven Melching', 'Joseph Kuhr', 'J. M. DeMatteis', 'Michael Jelenic', 'Matt Wayne'].), (Channel, channel.), (Original_air_date, original air date. Value examples: ['November21,2008', 'November14,2008', 'January9,2009', 'January30,2009', 'January23,2009', 'January2,2009'].) ] # Foreign keys TV_series.`Channel` = TV_Channel.`id` Cartoon.`Channel` = TV_Channel.`id` # Question What is the name and directors of all the cartoons that are ordered by air date? # Submitted SQL Query
SELECT Title FROM Cartoon WHERE Directed_by IN ('Michael Chang', 'Brandon Vietti', 'Ben Jones');
SELECT DISTINCT Title FROM Cartoon WHERE Directed_by IN ('Ben Jones', 'Brandon Vietti')
SELECT Country, COUNT(*) as num_channels FROM TV_Channel GROUP BY Country ORDER BY num_channels DESC LIMIT 1;
SELECT Country, COUNT(id) AS num_channels FROM TV_Channel GROUP BY Country ORDER BY num_channels DESC LIMIT 1;
SELECT COUNT(DISTINCT `series_name`) AS series_name_count, COUNT(DISTINCT `Content`) AS content_count FROM TV_Channel
SELECT COUNT(DISTINCT `Content`) AS Different_Content, COUNT(DISTINCT `series_name`) AS Different_Series FROM TV_Channel;
SELECT Content FROM TV_Channel WHERE series_name = 'Sky Radio';
SELECT tvc.`Content` FROM `TV_Channel` AS tvc JOIN `TV_Series` AS tvs ON tvs.`Channel` = tvc.`id` WHERE tvc.`series_name` = 'Sky Radio'
SELECT Package_Option FROM TV_Channel WHERE series_name = 'Sky Radio'
SELECT DISTINCT series_name AS Package_Options FROM TV_Channel WHERE series_name = 'Sky Radio'
SELECT COUNT(id) FROM TV_Channel WHERE Language = 'English'
SELECT COUNT(*) FROM TV_Channel WHERE Language IN ('English')
SELECT Language, COUNT(id) FROM TV_Channel GROUP BY Language ORDER BY COUNT(id) ASC LIMIT 1;
SELECT `Language`, COUNT(id) as total_channels FROM TV_Channel GROUP BY `Language` HAVING COUNT(id) = ( SELECT MAX(num_count) FROM ( SELECT Language, COUNT(id) as num_count FROM TV_Channel GROUP BY Language ) AS subquery )
SELECT DISTINCT T1.Language, COUNT(T2.id) as 'Number_of_TvChannel_using_language' FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.channel GROUP BY T1.Language;
-- Type: SQL -- Script: SELECT TC.`Language`, COUNT(TV.`id`) AS Total_TVs FROM TV_Channel AS TC JOIN TV_series AS TS ON TC.`id` = TS.`Channel` GROUP BY TC.`Language`;
SELECT series_name FROM TV_Channel WHERE id IN ( SELECT Channel FROM Cartoon WHERE Title = 'The Rise of the Blue Beetle!' )
SELECT T1.`series_name` FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.`id` = T2.`Channel` WHERE T2.`Title` = 'The Rise of the Blue Beetle!'
SELECT COALESCE(T1.Title, '') AS title FROM TV_Channel AS T2 JOIN Cartoon AS T1 ON T2.id = T1.Channel WHERE series_name = 'Sky Radio' LIMIT 1000
SELECT Title FROM Cartoon WHERE Channel = (SELECT id FROM TV_Channel WHERE series_name = 'Sky Radio')
SELECT `Episode`, `Rating` FROM TV_series WHERE Rating = (SELECT MIN(Rating) FROM TV_series) ORDER BY `Rating` ASC;
SELECT `Episode` FROM TV_series ORDER BY `Rating` DESC;
SELECT Episode, Rating FROM ( SELECT tv_series.Episode AS Episode ,tv_series.Rating As Rating, DENSE_RANK() OVER(PARTITION BY tv_series.Rating ORDER BY tv_series.id DESC)AS Ranking FROM TV_series ) A WHERE A.Ranking <= 3;
SELECT t2.`Episode`, t2.`Rating` FROM TV_series t2 JOIN ( SELECT `Episode`, MAX(`Rating`) as max_rating FROM TV_series GROUP BY `Episode` ) AS c ON t2.`Episode`=c.`Episode` AND t2.`Rating`=c.max_rating ORDER BY max_rating DESC, t2.Rating DESC LIMIT 3;
SELECT MIN(Share) , MAX(Share) FROM tv_series
-- Corrected Query to Get Maximum and Minimum Share for the TV Series SELECT ( SELECT MIN(`Weekly_Rank`) FROM `TV_series` ) AS `Minimum_Wednesday`, ( SELECT MAX(`Share`) FROM `TV_series` WHERE `18_49_Rating_Share`= "2.7/7" ) AS `Maximum_Wednesday`
SELECT air_date FROM TV_series WHERE Episode = "A Love of a Lifetime"
SELECT `Air_Date` FROM `TV_series` WHERE `Episode` = 'Home By Another Way'
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime'
SELECT AVG(TS.`Weekly_Rank`) FROM `TV_series` AS TS JOIN `TV_Channel` AS TC ON TS.`Channel` = TC.`id` WHERE TS.`Episode` = 'A Love of a Lifetime'
SELECT TC.`series_name` , TVS.Episode FROM TV_channel TC INNER JOIN TV_series TVS ON TC.id = TVS.Channel WHERE TVS.Episode = 'A_Love_of_a_Lifetime'
SELECT T1.series_name FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T2.`Channel` = T1.`id` WHERE T2.Episode = 'A Love of a Lifetime';
SELECT `Episode` FROM TV_series WHERE Channel=(SELECT `id` FROM TV_Channel WHERE series_name='Sky Radio')
SELECT `Episode` FROM TV_series AS T1 JOIN TV_Channel AS T2 ON T1.Channel = T2.id WHERE T2.`series_name` = 'Sky Radio'
SELECT T1.`Directed_by`, COUNT(T1.id) FROM Cartoon AS T1 JOIN TV_Channel AS T2 ON T1.`Channel` = T2.`id` GROUP BY T1.`Directed_by`
SELECT T1.Directed_by, COUNT(T2.id) as num_cartoons FROM Cartoon AS T1 JOIN TV_Channel AS T2 ON T2.id = T1.Channel GROUP BY T1.Directed_by;
SELECT `Production_code`, channel FROM ( SELECT C.`Production_code`, T2.id AS channel, C.`Title` FROM Cartoon AS C JOIN TV_Channel AS T1 ON C.channel = T1.id ORDER BY C. `Original_air_date` DESC LIMIT 1 ) subquery;
SELECT c.id, tc.Series_name AS Channel_id, ts.Title, ts.maxdate FROM TV_Channel tc INNER JOIN Cartoon c ON tc.id = c.Channel INNER JOIN ( SELECT id, Title, MAX(Original_air_date) as maxdate FROM tv_series GROUP BY id ) ts ON c.channel = ts.id AND c.original_air_date = ts.maxdate WHERE c.original_air_date = ts.maxdate ORDER BY ts.maxdate DESC;
SELECT `Package_Option`, `series_name` FROM TV_Channel WHERE Hight_definition_TV = 'yes'
SELECT T1.`Package_Option`, T1.`series_name` FROM `TV_Channel` AS T1 JOIN `TV_series` AS t2 ON T2.`Channel` = T1.`id` WHERE T1.Hight_definition_TV = 'yes' ORDER BY T1.Package_Option ASC;
SELECT `Country`, COUNT(*) FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T2.Channel = T1.id WHERE Written_by = 'Todd Casey' GROUP BY `Country`
SELECT DISTINCT T2.Country FROM Cartoon AS T1 JOIN TV_Channel AS T2 ON T1.Channel = T2.id WHERE T1.Written_by = 'Todd Casey';
SELECT T1.id FROM TV_Channel AS T1 LEFT JOIN ( SELECT Channel, COUNT(*) as count FROM Cartoon WHERE Written_by = 'Todd Casey' GROUP BY Channel ) AS T4 ON T1.id = T4.Channel WHERE T4.count IS NULL;
SELECT T1.`Country` FROM TV_Channel AS T1 LEFT JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Channel IS NULL AND `Written_by` != 'Todd Casey';
SELECT `series_name`, T1.`Country` FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T2.id IN (SELECT Channel FROM Cartoon WHERE directed_by = 'Ben Jones' OR directed_by='Michael Chang')
SELECT T1.`series_name`, T1.`Country` FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.`id` = T2.`Channel` AND (T2.`Directed_by` IN ('Ben Jones', 'Michael Chang'))
SELECT id, Country FROM TV_Channel WHERE Language != 'English'
SELECT `Pixel_aspect_ratio_PAR`, `Country` FROM `TV_Channel` WHERE `Language` != 'English'
SELECT T1.id FROM TV_Channel AS T1 WHERE T1.Country IN ( SELECT country FROM TV_channel GROUP BY country HAVING COUNT(id) > 2 )
SELECT T1.id FROM TV_Channel AS T1 JOIN TV_series as T2 ON T1.id = T2.channel GROUP BY T1.id HAVING COUNT(T2.channel) > 2
-- find the id of tv channels that do not play any cartoon directed by Ben Jones. SELECT id FROM TV_Channel WHERE id NOT IN (SELECT Channel FROM Cartoon WHERE Directed_by = 'Ben Jones')
SELECT `id` FROM TV_Channel WHERE `id` NOT IN ( SELECT T2.`id` AS id FROM Cartoon AS T1 JOIN TV_Channel AS T2 ON T1.`Channel` = T2.`id` WHERE Directed_by = 'Ben Jones' )
SELECT T2.`series_name` FROM Cartoon AS T1 INNER JOIN TV_Channel AS T2 ON T2.id = T1.Channel WHERE T1.directed_by = 'Ben Jones' AND Title IS NULL;
SELECT DISTINCT TV_Channel.`Package_Option` FROM TV_Channel, Cartoon WHERE Cartoon.Directed_by IS NULL AND TV_Channel.id = Cartoon.Channel;
SELECT COUNT(*) FROM poker_player
SELECT COUNT(*) AS Count_of_Poker_Players FROM poker_player;
SELECT `Earnings` FROM poker_player ORDER BY `Earnings` DESC;
SELECT Earnings FROM poker_player GROUP BY Earnings ORDER BY Earnings DESC;
SELECT T1.`Final_Table_Made`, T1.`Best_Finish` FROM poker_player AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY Final_Table_Made LIMIT 1
SELECT Final_Table_Made, Best_Finish FROM poker_player;
-- What is the average earnings of poker players? SELECT AVG(poker_player.Earnings) AS Earnings_aver FROM poker_player;
SELECT COUNT(Money_Rank), SUM(Earnings) FROM poker_player
SELECT T1.`Money_Rank` FROM poker_player AS T1 JOIN people AS T2 ON T1.'People_ID' = T2.People_ID WHERE T1.`Earnings` = (SELECT MAX(T1.Earnings) FROM poker_player AS T1 JOIN people AS T2 ON T1.'People_ID' = T2.People_ID)
SELECT `MONEY_RANK` FROM `poker_player` WHERE `Earnings` = (SELECT MAX(`Earnings`) FROM `poker_player`)
SELECT MAX(T1.`Final_Table_Made`) / COUNT(T1.Poker_Player_ID) FROM poker_player AS T1 JOIN people AS T2 ON T1.`People_ID` = T2.`People_ID` WHERE T1.`Earnings` < 200000;
SELECT MAX(T1.`Final_Table_Made`) FROM people AS T2 INNER JOIN poker_player AS T1 ON T1.`People_ID` = T2.`People_ID` WHERE T1.`Earnings` < 200000; -- -- SELECT MAX(T1.`Final_Table_Made`) -- FROM poker_player AS T1 INNER JOIN people AS T2 ON T2.`People_ID` = T1.`People_ID` WHERE -- T1.`Earnings` < (SELECT MIN(`Earnings`) FROM poker_player);
SELECT `Name` FROM poker_player AS p JOIN people AS pe ON p.`People_ID` = pe.`People_ID`;
SELECT t2.`Name` FROM poker_player AS t1 JOIN people AS t2 ON t1.People_ID = t2.People_ID
SELECT P.`Name` FROM poker_player AS PP JOIN people AS P ON PP.`People_ID` = P.`People_ID` WHERE PP.Earnings > 300000.0;
SELECT `Name` FROM people AS T1 JOIN poker_player AS T2 ON T1.`People_ID` = T2.`People_ID` WHERE T2.`Earnings` > 300000.0;
SELECT DISTINCT pe.Name AS PLAYER_NAME FROM poker_player AS pp JOIN people AS pe ON pp.People_ID = pe.People_ID ORDER BY pp.Final_Table_Made ASC;
SELECT `Name`, Final_Table_Made FROM poker_player AS T2 JOIN people AS T1 ON T2.`People_ID` = T1.`People_ID` ORDER BY Final_Table_Made ASC
SELECT `Birth_Date` FROM people AS T2 JOIN poker_player AS T1 ON T1.`People_ID` = T2.`People_ID` WHERE Earnings = ( SELECT MIN(Earnings) FROM poker_player )
SELECT people.Birth_Date FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings DESC LIMIT 1
SELECT MAX(T1.`Money_Rank`) FROM poker_player AS T1 JOIN people AS T2 ON T1.`People_ID` = T2.`People_ID` WHERE T2.`Height` = (SELECT MAX(`Height`) FROM people)
SELECT MAX(Money_Rank) FROM ( SELECT T3.Money_Rank FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID JOIN poker_player as t3 ON t3.people_id = ( SELECT People_ID FROM people ORDER BY Height DESC LIMIT 1 ) ) AS subquery;
SELECT CAST(SUM(`Earnings`) AS REAL) / COUNT(DISTINCT `players`.`People_ID`) AS avg_earnings FROM poker_player AS `players` JOIN people ON players.`People_ID` = people.`People_ID` WHERE people.Height > 200 AND players.Earnings IS NOT NULL;
SELECT AVG(T2.Earnings) AS Average_Earnings FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID GROUP BY T2.People_ID HAVING COUNT(T2.Final_Table_Made) > 1
SELECT p.Name, pp.People_ID FROM poker_player AS pp JOIN people AS p ON pp.People_ID = p.People_ID ORDER BY pp.Earnings DESC;
SELECT `Name` FROM people p JOIN poker_player pp ON p.People_ID = pp.People_ID ORDER BY pp.Earnings DESC;
SELECT `Nationality`, COUNT(`People_ID`) AS Number_of_people FROM people GROUP BY `Nationality`
SELECT Nationality, COUNT(*) AS Count FROM people GROUP BY Nationality
SELECT Nationality FROM people GROUP BY Nationality ORDER BY COUNT(Nationality) DESC LIMIT 1;
SELECT c.`Nationality` FROM (SELECT `Nationality`, COUNT(*) as cnt FROM people GROUP BY `Nationality`) AS c JOIN (SELECT MAX(cnt) as max_cnt FROM (SELECT `Nationality`, COUNT(*) as cnt FROM people GROUP BY `Nationality`) AS subquery) AS s ON c.cnt = s.max_cnt;
SELECT distinct(T.`Nationality`) FROM people AS T JOIN poker_player AS S ON T.`People_ID` = S.`People_ID` GROUP BY T.`Nationality` HAVING COUNT(DISTINCT T.`Nationality`) > 1;
SELECT Nationality FROM people p JOIN poker_player pl ON p.People_ID = pl.People_ID GROUP BY p.Nationality HAVING COUNT(pl.People_ID) >= 2;
SELECT p.Name, ppl.Birth_Date FROM people p JOIN poker_player ppl ON p.People_ID = pll.People_ID ORDER BY p.Name ASC;
SELECT Name, Birth_Date FROM people ORDER BY Name ASC;
SELECT DISTINCT Name FROM people WHERE Nationality != 'Russia'
SELECT Name FROM people WHERE Nationality != 'Russia'
SELECT `Name` FROM people WHERE People_ID NOT IN ( SELECT Poker_Player_ID FROM poker_player )
SELECT Name FROM people WHERE People_ID NOT IN ( SELECT People_ID FROM poker_player )
SELECT COUNT(DISTINCT `Nationality`) AS 'Distinct_Nationalities' FROM people;
SELECT COUNT(`Nationality`) FROM (SELECT DISTINCT `Nationality` FROM people)AS temp_table;
SELECT COUNT(DISTINCT `state`) FROM VOTES;
SELECT C.`contestant_number`, C.`contestant_name` FROM CONTESTANTS C WHERE C.`contestant_name` IS NOT NULL ORDER BY C.`contestant_name` DESC;
SELECT VOTES.vote_id, VOTES.phone_number, VOTES.state FROM VOTES
SELECT MAX(`area_code`), MIN(`area_code`) FROM `AREA_CODE_STATE`;
SELECT MAX(created) as Last_Date_Created FROM VOTES WHERE state = 'CA'
SELECT `contestant_name` FROM CONTESTANTS WHERE `contestant_name` != 'Jessie Alloway'
SELECT DISTINCT V.`state`, V.`created` FROM `VOTES` AS V ORDER BY V.`created` DESC LIMIT 1 OFFSET 0
SELECT c.`contestant_name`, c.`contestant_name` FROM CONTESTANTS c JOIN ( SELECT v.`contestant_number` , COUNT(*) as total_votes FROM VOTES v GROUP BY v.`contestant_number` ) t ON c.`contestant_number` = t.`contestant_number` WHERE t.total_votes >= 2;
SELECT C.`contestant_name`, V.vote_count FROM ( SELECT T2.`contestant_number`, COUNT(T1.`vote_id`) AS vote_count FROM VOTES AS T1 JOIN CONTESTANTS AS T2 ON T1.`contestant_number` = T2.`contestant_number` GROUP BY T2.`contestant_number` ) V JOIN CONTESTANTS C ON V.`contestant_number` = C.`contestant_number` ORDER BY V.vote_count DESC LIMIT 1
SELECT COUNT(*) FROM VOTES AS T1 JOIN AREA_CODE_STATE AS T2 ON T1.`state` = T2.`state` WHERE T2.state IN ('NY', 'CA')
SELECT COUNT(DISTINCT C.contestant_number) FROM CONTESTANTS C LEFT JOIN VOTES V ON C.contestant_number = V.contestant_number WHERE V.contestant_number IS NULL
SELECT acs.`area_code` FROM VOTES AS v JOIN AREA_CODE_STATE AS acs ON v.`state` = acs.`state` WHERE v.state IS NOT NULL AND acs.state IS NOT NULL GROUP BY acs.`area_code` HAVING COUNT(*) = ( SELECT MAX(`v_total_votes`) FROM (SELECT acs.`area_code`, COUNT(v.`vote_id`) as v_total_votes FROM VOTES AS v JOIN AREA_CODE_STATE AS acs ON v.`state` = acs.`state` WHERE v.state IS NOT NULL AND acs.state IS NOT NULL GROUP BY acs.`area_code`) AS subquery)
SELECT V.created, V.state, V.phone_number FROM CONTESTANTS C JOIN VOTES V ON C.contestant_number = V.contestant_number WHERE C.contestant_name = 'Tabatha Gehling'
SELECT AREA_CODE_STATE.area_code FROM AREA_CODE_STATE INNER JOIN VOTES ON AREA_CODE_STATE.state = VOTES.state AND VOTES.contestant_number IN ( SELECT contestant_number FROM CONTESTANTS WHERE contestant_name IN ('Tabatha Gehling','Kelly Clauss') ) GROUP BY AREA_CODE_STATE.area_code HAVING COUNT(DISTINCT VOTES.contestant_number)=2
SELECT "contestant_name" FROM CONTESTANTS WHERE instr(`contestant_name`, "Al") > 0 ORDER BY "contestant_name"
SELECT Name FROM country WHERE IndepYear >= (SELECT MIN(IndepYear) + 50 FROM country);
-- Fix: Renamed `IndependYear` to its actual spelling, `IndepYear` SELECT Name FROM country WHERE (IndepYear > '1950' AND HeadOfState IS NOT NULL)
SELECT COUNT(*) FROM country WHERE GovernmentForm = 'Republic'
SELECT COUNT(*) FROM country WHERE Lower(GovernmentForm) = 'republic';
SELECT SUM(T1.SurfaceArea) FROM country AS T1 WHERE T1.Region = 'Caribbean'
SELECT SUM(c.SurfaceArea) FROM ( SELECT SurfaceArea FROM country WHERE Region = 'Caribbean' UNION ALL SELECT SurfaceArea FROM country WHERE Region = 'Caribbean' ) c;
SELECT Continent FROM country WHERE Code2 = 'AW'
error: No SQL found in the input string
SELECT co.`Region` FROM city AS c JOIN country AS co ON co.Code = c.CountryCode WHERE c.Name = 'Kabul'
SELECT c.Region FROM country as c INNER JOIN city AS cl ON c.Code = cl.CountryCode WHERE cl.Name='Kabul';
SELECT Language FROM countrylanguage WHERE CountryCode = 'AW' AND IsOfficial = 'F' ORDER BY Percentage DESC LIMIT 2 OFFSET 0;
SELECT Language FROM countrylanguage WHERE Percentage IS NULL AND CountryCode = 'AW'
SELECT `Population`, `LifeExpectancy` FROM country WHERE Name = 'Brazil';
SELECT T1.Population, T1.LifeExpectancy FROM country AS T1 JOIN (SELECT CountryCode FROM countrylanguage WHERE Language = 'Portuguese') AS T2 ON T2.CountryCode = T1.Code WHERE T1.Name = 'Brazil'
SELECT `Region`, Population FROM country WHERE Name = 'Angola'
SELECT T1.`Region`, T3.`Population` FROM country AS T1 JOIN city AS T2 ON T1.`Code` = T2.`CountryCode` JOIN city AS T3 ON T1.`Code` = T3.`CountryCode` WHERE T2.`Name` = 'Angola';
SELECT AVG(T1.LifeExpectancy) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Region LIKE '%Central Africa%' AND T2.IsOfficial = 'T'
SELECT SUM(c.LifeExpectancy) / COUNT(*) FROM country c JOIN city ci ON c.Code = ci.CountryCode WHERE ci.District = 'Central Africa';
SELECT c.Name FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE c.Continent = 'Asia' ORDER BY c.LifeExpectancy ASC LIMIT 1;
SELECT Name FROM country WHERE Continent = 'Asia' AND Population = (SELECT MIN(Population) FROM country WHERE Continent = 'Asia')
-- SQL execution: SELECT SUM FROM city AND SELECT MAX(C2.GNP) -- WHERE city join country (T1 & C1)...(result from executing this):
SELECT COUNT(c.Population) AS num_people, c.Continent, max(GNPOld) as max_gnp FROM city AS ct JOIN country AS c ON ct.CountryCode = c.Code WHERE c.Continent='Asia' AND ct.Population > 0 GROUP BY c.Continent, ORDER BY max(GNPOld) DESC
SELECT AVG(`LifeExpectancy`) FROM country WHERE continent = 'Africa' AND governmentform = 'Republic'
-- Note that the WHERE keyword is used to filter out countries in Africa which are republics, after joining the two tables and selecting LifeExpectancy from both.
SELECT SUM(SurfaceArea) AS Total_Surface_Area FROM country WHERE CONTINENT IN ('asia', 'europe')
SELECT SUM(T1.SurfaceArea) FROM country AS T1 JOIN countrylanguage AS T2 ON T2.CountryCode = T1.Code WHERE T1.Continent IN('Asia', 'Europe')
SELECT COUNT(DISTINCT `Population`) as total_population FROM city WHERE District = 'Gelderland';
SELECT c.Population FROM city c WHERE c.District = 'Gelderland'
SELECT (CASE WHEN SUM(GNP) IS NULL OR COUNT(*)=1 THEN NULL ELSE AVG(GNP) END) AS avg_gnp, (CASE WHEN SUM(Population) IS NULL OR COUNT(*)=1 THEN NULL ELSE SUM(Population) END) AS tot_pop FROM country WHERE GovernmentForm = 'US Territory';
SELECT SUM(T2.SurfaceArea) / COUNT(*) AS averageSurfaceArea, COALESCE(SUM(T4.Population), 0) AS totalPopulation FROM countrylanguage T1 JOIN country T2 ON T1.CountryCode = T2.Code JOIN city T3 ON T2.Code = T3.CountryCode INNER JOIN country T4 ON T4.Code = T2.Code WHERE T4.GNP > 0
SELECT COUNT(DISTINCT Language) FROM countrylanguage;
SELECT COUNT(DISTINCT T2.`Language`) FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode;
SELECT COUNT(DISTINCT c.GovernmentForm) AS number_of_governments FROM country c JOIN city a ON c.Code = a.CountryCode WHERE c.Continent = 'Africa'
SELECT COUNT(DISTINCT GovernmentForm) FROM country WHERE Continent = 'Africa'
-- What is the total number of languages used in Aruba? SELECT SUM(T2.Percentage) FROM city AS T1 JOIN countrylanguage AS T2 ON T1.CountryCode = T2.CountryCode -- Changed Code2 to CountryCode WHERE T1.Name = 'Aruba';
SELECT COUNT(*) FROM city AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code INNER JOIN countrylanguage AS T3 ON T2.Code = T3.CountryCode WHERE T2.Name = 'Aruba'
SELECT COUNT(*) FROM countrylanguage AS T1 JOIN country AS T2 ON T1.`CountryCode` = T2.`Code` WHERE T1.LANGUAGE IN (SELECT `Language` FROM country WHERE `Name` = 'Afghanistan') AND T1.`IsOfficial` = 'T'
SELECT COUNT(Language) AS Total_Languages, SUM(Percentage) AS Official_Percentage FROM countrylanguage WHERE CountryCode = 'AF'
SELECT c.Name, cl.IsOfficial FROM country AS c JOIN countrylanguage AS cl ON c.Code = cl.CountryCode GROUP BY cl.Language ORDER BY COUNT(cl.Language) DESC LIMIT 1
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode GROUP BY country.Name ORDER BY count(DISTINCT countrylanguage.Language) DESC LIMIT 1;
SELECT c.Continent, COUNT(DISTINCT cl.Language) AS LanguageCount FROM country AS c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE cl.IsOfficial IS NOT NULL AND c.Region IN ('North America', 'South America') /* North and South America */ GROUP BY c.continent ORDER BY LanguageCount DESC LIMIT 1; TYPE: SQL
SELECT T2.Continent, COUNT(*) FROM countrylanguage AS T1 JOIN country AS T2 ON T1.CountryCode = T2.Code GROUP BY T2.Continent ORDER BY COUNT(*) DESC;
SELECT COUNT(*) FROM country AS T1 -- table country JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode -- joins "country" with "countrylanguage" WHERE Language='Dutch' AND IsOfficial='F' AND CountryCode IN ( SELECT `CountryCode` FROM countrylanguage WHERE `Language`='English')
SELECT COUNT(*) FROM ( SELECT DISTINCT T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE LOWER(T2.Language) IN ('english', 'dutch') ) AS t3;
error: No SQL found in the input string
SELECT T2.`Name` FROM `countrylanguage` T1 JOIN `country` T2 ON T2.`Code`= T1.`CountryCode` WHERE T1.`Language` IN ( 'English' , 'French' );
SELECT DISTINCT T1.Name, T2.Percentage FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode AND T2.Language IN ('English', 'French')
SELECT DISTINCT c.Code FROM country c JOIN countrylanguage l1 ON c.`Code` = l1.CountryCode JOIN countrylanguage l2 ON c.`Code` = l2.CountryCode WHERE l1.Language = 'English' AND l1.IsOfficial = 'T' AND l2.Language = 'French' AND l2.IsOfficial = 'T';
SELECT COUNT(`Continent`) FROM countrylanguage AS T1 JOIN country AS T2 ON T1.`CountryCode` = T2.`Code` WHERE `Language` = 'Chinese'
SELECT SUM(T2.Percentage) FROM country AS T1 JOIN countrylanguage AS T2 ON T2.CountryCode = T1.Code WHERE T2.Language = 'Chinese';
SELECT C.`Region` FROM countrylanguage AS CL JOIN country AS C ON CL.CountryCode = C.Code WHERE (CL.Language = 'English' OR CL.Language = 'Dutch') AND CL.IsOfficial = 'T'
SELECT DISTINCT c.District FROM city c INNER JOIN country co ON c.CountryCode = co.Code WHERE co.Region IN ('Caribbean', 'Eastern Africa');
SELECT T1.Name, T1.Code2 ,T1.Capital FROM `country` AS T1 INNER JOIN countrylanguage AS T2 ON T2.CountryCode = T1.Code WHERE T2.Language IN ('English', 'Dutch');
SELECT c.Name FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode AND cl.IsOfficial = TRUE AND (cl.Language IN ('English', 'Dutch'));
SELECT CONCAT(CountryName, ', ', Language) AS mostPopularLanguage FROM ( SELECT c.Name AS CountryName, cl.Language, PERCENT_RANK() OVER (PARTITION BY cl.CountryCode ORDER BY cl.Percentage DESC) AS percentile_ranking FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE c.Continent = 'Asia' AND cl.IsOfficial = 'T' )t WHERE t.percentile_ranking > 0.75;
SELECT Language, COUNT(*) AS Count FROM countrylanguage JOIN country ON country.Code = countrylanguage.CountryCode WHERE country.Continent = 'Asia' GROUP BY Language ORDER BY Count DESC LIMIT 1
SELECT cl.`Language` FROM countrylanguage AS cl INNER JOIN country AS c ON cl.`CountryCode` = c.Code WHERE c.GovernmentForm = 'Republic' AND cl.`IsOfficial` = 'T' GROUP BY cl.`Language` HAVING COUNT(c.Code) = 1;
SELECT Language FROM countrylanguage cl JOIN country AS c ON cl.`CountryCode` = c.Code WHERE c.GovernmentForm = 'Republic' GROUP BY Language HAVING COUNT(DISTINCT `CountryCode`) = 1;
SELECT city.Name FROM city JOIN countrylanguage ON city.`CountryCode` = countrylanguage.CountryCode WHERE countrylanguage.Language = 'English' AND IsOfficial = 'T' ORDER BY city.Population DESC, countrylanguage.Percentage DESC LIMIT 1;
SELECT c.`ID`, c.`Name`, cl.`Percentage` FROM city c JOIN countrylanguage cl ON c.`CountryCode` = cl.`CountryCode` WHERE cl.`Language` = 'English' AND c.`Population` = (SELECT MAX(`Population`) FROM city);
<code class="language-sql"> SELECT c.name, s.population, cl.lifeexpectancy FROM city c INNER JOIN country cl ON c.CountryCode = cl.Code WHERE cl.Continent = 'Asia' AND cl.SurfaceArea = (SELECT MAX(surface_area) FROM country WHERE Continent = 'Asia') </code>
-- What are the name, population, and life expectancy of the largest Asian country by land? SELECT c.Name, c.Population, c.LifeExpectancy FROM country AS c JOIN city AS ct ON c.Code = ct.CountryCode WHERE c.Continent = 'Asia' ORDER BY c.SurfaceArea DESC;
SELECT AVG(country.`LifeExpectancy`) FROM country JOIN city ON country.Code = city.CountryCode JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language != 'English' AND `isofficial` NOT LIKE '(F%)'
SELECT AVG(c.LifeExpectancy) FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE cl.Language != 'English'
SELECT COUNT(DISTINCT T1.Name) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE (T2.Language != 'English' OR T2.IsOfficial IS NULL OR T2.Percentage < 1)
SELECT COUNT(T1.`Name`) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language != 'English' AND (T2.IsOfficial = 'F' OR T2.Percentage < 0.5)
SELECT Language, Percentage FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code WHERE country.HeadOfState LIKE 'Beatrix' AND IsOfficial = 'T' ORDER BY Percentage DESC LIMIT 1;
SELECT cl.Language, T2.Capital, cl.IsOfficial, cl.Percentage FROM countrylanguage as cl INNER JOIN country AS T2 ON cl.CountryCode = T2.Code WHERE T2.HeadOfState LIKE '%Beatrix%' AND IsOfficial='T'
SELECT COUNT(DISTINCT T2.`Language`) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.`Code` = T2.`CountryCode` WHERE T1.`IndepYear` < 1930 AND T2.`IsOfficial` = 'T';
-- To get maximum and minimum of 'surface area' or 'Population' SELECT MIN(c.SurfaceArea) OVER (), MAX(c.Population) FROM country c;
SELECT Name FROM country WHERE SurfaceArea > (SELECT MAX(SurfaceArea) FROM country WHERE Continent = 'Europe')
SELECT name, SurfaceArea AS surface_area FROM country WHERE SurfaceArea > (SELECT MAX(SurfaceArea) FROM country WHERE Continent = 'Europe')
SELECT Name FROM country WHERE Continent = 'Africa' AND Population < ( SELECT MIN( c.Population ) AS min_population FROM country AS c INNER JOIN countrylanguage AS cl ON c.Code = cl.CountryCode WHERE c.Continent = 'Asia' AND CL.Percentage > 50 );
-- Which African countries have a smaller population than that of any country in Asia? SELECT c.`Name` FROM city AS T JOIN country AS c ON T.`CountryCode` = c.`Code` WHERE c.`Continent` = 'Asia' AND T.`Population` < ( SELECT MAX(c2.`Population`) FROM country c2 )
-- Which Asian countries have a population that is larger than any country in Africa? SELECT DISTINCT c1.Name FROM country c1 JOIN country c2 ON c1.Population > c2.Population WHERE c1.Continent = 'Asia' AND c2.Continent = 'Africa';
SELECT T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.IsOfficial = 'T' AND T1.Continent = 'Asia' AND T1.Population > (SELECT MAX(T3.Population) FROM country AS T3 JOIN countrylanguage AS T7 ON T3.Code = T7.CountryCode WHERE T7.IsOfficial = 'T' AND T3.Continent = 'Africa')
SELECT DISTINCT T2.`Code` FROM countrylanguage AS T1 JOIN country AS T2 ON T1.`CountryCode` = T2.`Code` WHERE T1.`Language` != 'English';
SELECT `Code` FROM `country` WHERE `Code` NOT IN (SELECT `CountryCode` FROM `countrylanguage` WHERE `Language` = 'English')
SELECT C.Code FROM countrylanguage CL JOIN country C ON CL.CountryCode = C.Code WHERE CL.Language <> 'English' ORDER BY C.Population DESC LIMIT 1;
SELECT DISTINCT c.Code FROM country AS c WHERE c.Code NOT IN ( SELECT CountryCode FROM countrylanguage WHERE Language = 'English')
SELECT Code FROM country EXCEPT SELECT T1.Code FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.`Code` = T2.CountryCode WHERE T2.Language != "English" AND T1.GovernmentForm != "Republic"
SELECT Code FROM country WHERE NOT EXISTS ( SELECT 1 FROM countrylanguage WHERE countrylanguage.Language = 'English' AND countrylanguage.CountryCode = country.Code ) AND GovernmentForm != 'Republic'
error: No SQL found in the input string
SELECT c.`Name` FROM city AS c JOIN country AS co ON c.`CountryCode` = co.`Code` JOIN countrylanguage AS cl ON co.`Code` = cl.`CountryCode` WHERE cl.`Language` NOT IN ('English') AND co.`Continent` = 'Europe'
SELECT DISTINCT T2.Name FROM countrylanguage AS T1 JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE Percentage > 0 AND Language = 'Chinese' AND CONTINENT = 'Asia'
SELECT DISTINCT T1.Name FROM city AS T1 JOIN country AS T2 ON T1.CountryCode = T2.Code JOIN countrylanguage AS T3 ON T2.Code = T3.CountryCode WHERE T2.Continent = 'Asia' AND T3.Language = 'Chinese' AND T3.IsOfficial = 'T'
SELECT country.Name, country.IndepYear, country.SurfaceArea FROM country ORDER BY country.Population ASC LIMIT 1;
SELECT Name, IndepYear, SurfaceArea FROM country WHERE Population = (SELECT MIN(Population) FROM country)
SELECT `Population`, `Name`, `HeadOfState` FROM country WHERE SurfaceArea = (SELECT MAX(`SurfaceArea`) FROM country)
SELECT c.Name, c.Population, c.HeadOfState FROM country c JOIN ( SELECT Code FROM country GROUP BY Code HAVING SurfaceArea = ( SELECT MAX(SurfaceArea) FROM country ) ) t ON c.Code = t.Code;
SELECT C.`Name`, COUNT(DISTINCT CL.`Language`) AS num_of_languages_spoken FROM country AS C JOIN countrylanguage AS CL ON C.`Code` = CL.`CountryCode` GROUP BY C.`Name` HAVING COUNT(*) >= 3;
SELECT c.`Name`, COUNT(DISTINCT cl.`Language`) AS numberoflanguages FROM country c JOIN countrylanguage cl ON c.`Code` = cl.`CountryCode` GROUP BY c.`Name` HAVING COUNT(DISTINCT cl.`Language`) > 2;
SELECT District, COUNT(ID) FROM city GROUP BY District HAVING Population > ( SELECT AVG(Population) FROM city );
SELECT `District`, COUNT(*) FROM city WHERE Population > (SELECT AVG(Population) FROM city) GROUP BY `District`
SELECT c.GovernmentForm, t1.Population AS TotalPopulation, AVG(c.LifeExpectancy) AS AverageLifeExpectancy FROM country AS c JOIN city AS t1 ON c.`Code` = t1.CountryCode GROUP BY c.GovernmentForm HAVING AverageLifeExpectancy > 72
SELECT C.GovernmentForm, SUM(C.Population) AS TotalPopulation FROM country C INNER JOIN city AS City ON C.Code = City.CountryCode WHERE C.LifeExpectancy IS NOT NULL AND C.LifeExpectancy > 72 GROUP BY C.GovernmentForm;
SELECT c.Continent, AVG(c.LifeExpectancy) AS avg_lifetime, SUM(ct.Population) AS total_population FROM country c JOIN city ct ON c.Code = ct.CountryCode WHERE c.Continent IN ('Africa', 'Asia') GROUP BY c.Continent HAVING avg_lifetime < 72;
SELECT Continent, SUM(Population) AS total_population, AVG(LifeExpectancy) AS avg_life_expectancy FROM country WHERE LifeExpectancy < 72 GROUP BY Continent
SELECT Name, SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 5;
SELECT co.`Name`, ca.SurfaceArea AS Surface_Area FROM country co JOIN city ci ON co.Code = ci.CountryCode JOIN ( SELECT cl.`CountryCode`, MAX(ca.SurfaceArea) AS SurfaceArea FROM countrylanguage cl JOIN country ca ON cl.`CountryCode` = ca.`Code` GROUP BY cl.`CountryCode` ) AS largest_countries ON co.Code = largest_countries.`CountryCode` ORDER BY largest_countries.SurfaceArea DESC LIMIT 5;
SELECT Name FROM country ORDER BY Population DESC NULLS LAST LIMIT 3;
SELECT c.Name, COUNT(c.CountryCode) as PopulationCount FROM city c GROUP BY c.Name ORDER BY PopulationCount DESC LIMIT 3;
SELECT `Name`, `Population` FROM country WHERE (`Population` IN (SELECT `Population` FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY `Population` ASC) AS rownum FROM country) AS subquery WHERE rownum <= 3)) OR (`Population` = (SELECT MIN(`Population`) FROM country));
SELECT Name FROM country ORDER BY Population ASC LIMIT 3
SELECT COUNT(Code) FROM country WHERE Continent = 'Asia'
SELECT COUNT(DISTINCT `Code`) FROM `country` WHERE Continent = 'Asia'
SELECT `Name` FROM country WHERE Continent = 'Europe' AND Population > 80000
SELECT c.Name FROM country as c INNER JOIN city AS sc ON c.Code = sc.CountryCode WHERE c.Continent = 'Europe' AND sc.Population = 80000;
SELECT SUM(`Population`) AS Total_Population, AVG(`SurfaceArea`) AS Avg_Surface_Area FROM country WHERE `Continent` = 'North America' AND `SurfaceArea` > 3000;
SELECT SUM(T1.Population) AS TotalPopulation, AVG(T2.SurfaceArea) AS AverageSurfaceArea FROM city AS T1 JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T2.Continent = 'North America' AND T2.SurfaceArea > 3000;
SELECT `Name`, `Population` FROM city WHERE `Population` BETWEEN 160000 AND 900000
SELECT Name FROM city WHERE Population >= 160000 AND Population <= 900000;
SELECT Language FROM countrylanguage GROUP BY Language ORDER BY COUNT(CountryCode) DESC LIMIT 1;
SELECT ci.Language FROM countrylanguage ci INNER JOIN ( SELECT CountryCode , LANGUAGE , Sum(Percentage) AS total_percentage FROM countrylanguage GROUP BY CountryCode , LANGUAGE ) co ON ci.CountryCode = co.CountryCode AND ci.Language = co.LANGUAGE GROUP BY ci.Language HAVING co.total_percentage=(SELECT MAX(total_percentage) FROM ( /* grouped calculation of percentage per language */ SELECT CountryCode, Language, Sum(Percentage) AS total_percentage FROM countrylanguage GROUP BY CountryCode,Language) T);
SELECT DISTINCT c.`Name`, cl.`Language`, cl.`Percentage` FROM `country` c JOIN `countrylanguage` cl ON c.`Code` = cl.`CountryCode` ORDER BY c.`Name`
-- Corrected SQL SELECT DISTINCT CountryCode, Language AS `Language_Spoken_by_Max_Percentage_People` FROM countrylanguage T1 JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE (T1.Percentage, T2.Population) IN ( SELECT T4.Percentage, T3.Population FROM countrylanguage AS T4 JOIN country AS T3 ON T4.CountryCode = T3.Code GROUP BY T4.Language ) ORDER BY CountryCode;
SELECT COUNT(DISTINCT CountryCode) FROM countrylanguage WHERE Language = 'Spanish' AND IsOfficial = 'T';
SELECT COUNT(T1.Name) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.IsOfficial='T' AND T2.Language='Spanish'
SELECT T1.Code FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE LOWER(T2.Language)='spanish' ORDER BY CAST(T2.Percentage AS REAL) DESC;
SELECT c.`Code` FROM country c INNER JOIN countrylanguage cl ON c.`Code` = cl.CountryCode WHERE cl.`Language` = 'Spanish' AND cl.Percentage > 50;
SELECT COUNT(*) AS 'Number of Conductors' FROM conductor;
SELECT COUNT(*) AS Total_Conductor FROM conductor;
SELECT `Name` FROM conductor WHERE Age IN (SELECT MIN(Age) FROM conductor) ORDER BY Age ASC
SELECT Name, Age FROM conductor ORDER BY Age ASC;
SELECT DISTINCT Name FROM conductor WHERE Nationality != 'USA'
SELECT `Name` FROM `conductor` WHERE `Nationality` NOT LIKE 'USA%'
SELECT `Orchestra`, Record_Company FROM orchestra ORDER BY Year_of_Founded ASC
SELECT record_company FROM orchestra ORDER BY year_of_founded DESC;
SELECT AVG(Attendance) AS Average_Attendance FROM show
SELECT AVG(Attendance) AS average_attendance FROM show WHERE Attendance > 10001.0 AND Result = 'L'
SELECT MAX(`Share`), MIN(`Share`) FROM performance WHERE `Type` != 'Live final'
SELECT MAX(`Official_ratings_(millions)`) AS max_share, MIN(`Official_ratings_(millions)`) AS min_share FROM performance WHERE `Type` NOT LIKE '% Live final%';
SELECT COUNT(DISTINCT Nationality) FROM conductor WHERE Year_of_Work = (SELECT MAX(Year_of_Work) FROM conductor)
SELECT COUNT(DISTINCT `Nationality`) AS distinct_nationalities FROM conductor;
SELECT `Name` FROM conductor ORDER BY Year_of_Work DESC
SELECT Name FROM conductor ORDER BY Year_of_Work DESC
SELECT Name FROM conductor WHERE Year_of_Work = (SELECT MAX(Year_of_Work) FROM conductor)
SELECT Name FROM conductor WHERE Age = (SELECT MIN(Age) FROM conductor);
SELECT C.`Name`, O.`Orchestra` FROM conductor AS C JOIN performance AS P ON C.Conductor_ID = P.Orchestra_ID JOIN orchestra AS O ON P.Orchestra_ID = O.Orchestra_ID;
SELECT T1.Name, T2.Orchestra FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID
SELECT T1.Name FROM conductor AS T1 GROUP BY T1.Name HAVING COUNT(T1.Conductor_ID) > 1
SELECT name FROM conductor WHERE Conductor_ID IN ( SELECT o.Conductor_ID FROM orchestra o GROUP BY o.Conductor_ID HAVING COUNT(DISTINCT Orchestra) > 1 )
SELECT c.`Name`, COUNT(o.`Conductor_ID`) AS Orchestra_Conducting_Performance FROM conductor c JOIN orchestra o ON c.`Conductor_ID` = o.`Conductor_ID` GROUP BY c.`Name` ORDER BY Orchestra_Conducting_Performance DESC LIMIT 1;
SELECT T1.`Name` FROM conductor AS T1 JOIN orchestra AS T2 ON T1.`Conductor_ID` = T2.`Conductor_ID` GROUP BY T1.`Conductor_ID` ORDER BY COUNT(T2.`Orchestra_ID`) DESC LIMIT 1
SELECT T3.name FROM orchestra AS T2 JOIN conductor AS T3 ON T2.`Conductor_ID` = T3.`Conductor_ID` WHERE T2.`Year_of_Founded` >= 2008 -- We are given the information about conductors but no performance, so we don't actually need to join the "performance" table with this query as you'll just be using orchestra.
SELECT `Name` FROM conductor WHERE Conductor_ID IN ( SELECT Conductor_ID FROM orchestra WHERE Year_of_Founded > 2008)
SELECT `Record_Company`, COUNT(Orchestra_ID) AS `Number_of_Orchestras` FROM orchestra GROUP BY Record_Company ORDER BY Number_of_Orchestras DESC;
SELECT Record_Company, COUNT(Orchestra_ID) FROM orchestra GROUP BY Record_Company;
SELECT Major_Record_format, COUNT(*) AS Count FROM orchestra GROUP BY Major_Record_format ORDER BY Count ASC;
SELECT Major_Record_Format, COUNT(*) AS Frequency FROM orchestra GROUP BY Major_Record_Format ORDER BY Frequency DESC
SELECT Record_Company FROM ( SELECT Record_Company, COUNT(*) AS num_orchestras FROM orchestra GROUP BY Record_Company ) X WHERE num_orchestras = ( SELECT MAX(num_orchestras) FROM ( SELECT Record_Company, COUNT(*) AS num_orchestras FROM orchestra GROUP BY Record_Company ) Y );
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(Conductor_ID) DESC LIMIT 1;
SELECT DISTINCT `Orchestra` FROM orchestra WHERE Orchestra_ID NOT IN ( SELECT `Orchestra_ID` FROM performance );
SELECT T1.`Orchestra` FROM orchestra AS T1 LEFT JOIN performance AS T2 ON T1.`Orchestra_ID` = T2.`Orchestra_ID` WHERE T2.`Performance_ID` IS NULL;
SELECT DISTINCT Record_Company FROM orchestra WHERE Year_of_Founded < (SELECT MIN(Year_of_Founded) FROM orchestra EXCEPT SELECT Year_of_Founded FROM orchestra WHERE Year_of_Founded > 2003) OR Year_of_Founded > 2003
SELECT distinct Record_Company FROM orchestra WHERE YEAR_of_Founded < 2003 INTERSECT SELECT Record_Company FROM orchestra WHERE YEAR_of_Founded > 2003;
SELECT COUNT(*) FROM ( SELECT 1 FROM orchestra WHERE Major_Record_Format = 'CD' UNION ALL SELECT 1 FROM orchestra WHERE Major_Record_Format = 'DVD') AS T
SELECT COUNT(DISTINCT Orchestra) FROM orchestra WHERE Major_Record_Format IN ('CD', 'DVD')
-- Show the years in which orchestras that have given more than one performance are founded. SELECT DISTINCT o.`Year_of_Founded` FROM orchestra o JOIN performance p ON o.`Orchestra_ID` = p.`Orchestra_ID` GROUP BY o.`Year_of_Founded` HAVING COUNT(p.`Performance_ID`) > 1;
SELECT DISTINCT O.`Year_of_Founded` FROM orchestra AS O JOIN performance AS P ON O.`Orchestra_ID` = P.`Orchestra_ID` GROUP BY O.`Year_of_Founded` HAVING COUNT(DISTINCT P.`Performance_ID`) > 1;
SELECT DISTINCT COUNT(*) FROM Highschooler;
SELECT COUNT(*) AS count_of_high_schoolers FROM Highschooler;
SELECT `name`, `grade` FROM Highschooler
SELECT H.name, H.grade FROM Highschooler AS H LEFT JOIN Friend AS F ON H.ID = F.student_id WHERE F.student_id IS NULL -- or in place of the left join (and corresponding where clause) -- SELECT H.name, H.grade FROM Highschooler AS H LEFT OUTER JOIN Likes L ON H.ID = L.liked_id ORDER BY H.grade DESC LIMIT 1;
SELECT DISTINCT h.name, Highschooler.grade FROM Highschooler AS h INNER JOIN Friend ON h.ID = Friend.student_id WHERE NOT EXISTS ( SELECT 1 FROM Likes WHERE Likes.student_id = Highschooler.ID AND Highschooler.name LIKE '%a' ) ORDER BY Highschooler.grade ASC;
SELECT ID, name, grade FROM Highschooler
SELECT `grade` FROM Highschooler WHERE `name` = 'Kyle'
SELECT `grade` FROM Highschooler WHERE name = 'Kyle' AND grade = (SELECT MIN(`grade`) FROM Highschooler) OR id IN ( SELECT F.`student_id` FROM Friend AS F WHERE F.`friend_id` IN ( SELECT L.`liked_id` FROM Likes as L WHERE L.`student_id` = 16 )) OR grade=(SELECT MAX(`grade`) FROM Highschooler);
SELECT name FROM Highschooler WHERE grade = 10;
SELECT name FROM Highschooler WHERE grade = 10;
SELECT ID FROM Highschooler WHERE name = 'Kyle'
SELECT `ID` FROM Highschooler WHERE `name` = 'Kyle';
SELECT COUNT(*) FROM Highschooler WHERE grade IN (9, 10)
SELECT COUNT(*) AS high_schoolers FROM Highschooler WHERE grade IN (9,10)
SELECT grade, COUNT(*) AS Total_Highschoolers FROM Highschooler GROUP BY grade
SELECT H.grade, COUNT(*) as total_count FROM Highschooler H GROUP BY H.grade;
SELECT `grade`, COUNT(*) FROM Highschooler GROUP BY `grade` ORDER BY COUNT(*) DESC LIMIT 1
SELECT grade, student_count FROM ( SELECT grade, COUNT(ID) AS student_count, RANK() OVER (ORDER BY COUNT(ID) DESC) as Rank_from_all_grades FROM Highschooler GROUP BY grade ) WHERE rank_from_all_grades = 1;
SELECT STUDENT ID FROM `GRADE`=COUNT(HighSchooler id)FROM WHERE grade = "12" GROUP BY high school GROUPS (SELECT id) FROM WHERE Schooo= "12"` SELECT id COUNT(id)=10 HAVING FROM Schoool WHERE GROUPS "High School Grade"
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(grade) = (SELECT COUNT(DISTINCT grade) FROM Highschooler WHERE grade IN (9,10,11,12))
SELECT T1.ID, COUNT(T2.student_id) AS num_of_friends FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.id = T2.student_id GROUP BY T1.ID
SELECT H1.name, COUNT(F.student_id) FROM Highschooler AS H1 JOIN Friend AS F ON H1.ID = F.student_id GROUP BY H1.name;
SELECT Highschooler.name, COUNT(Friend.student_id) FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Highschooler.name;
-- What are the names of the high schoolers and how many friends does each have? SELECT H.`name`, COUNT(DISTINCT F.friend_id) as total_friends_count, COUNT(F.friend_id) as school_friends_count FROM Highschooler AS H JOIN Friend AS F ON H.ID = F.student_id WHERE H.name IS NOT NULL -- to avoid 'None' values GROUP BY H.`name`;
SELECT name FROM Highschooler WHERE ID IN (SELECT friend_id FROM Friend UNION SELECT student_id FROM Friend) GROUP BY ID ORDER BY COUNT(*) DESC LIMIT 1;
SELECT T3.name FROM Highschooler AS T3 JOIN Friend AS T4 ON T3.id = T4.student_id GROUP BY T3.name HAVING COUNT(T3.id) = ( SELECT MAX(total_friends) FROM ( SELECT COUNT(student_id) AS total_friends FROM Friend GROUP BY student_id ) AS sub_query );
SELECT name FROM Highschooler WHERE id IN ( SELECT student_id FROM Friend GROUP BY student_id HAVING COUNT(student_id) >= 3 )
SELECT name FROM Highschooler WHERE ID IN ( SELECT friend_id FROM Friend GROUP BY friend_id HAVING COUNT(student_id) >= 3 )
SELECT T1.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id WHERE T2.friend_id IN (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T2.ID != T1.friend_id AND T1.student_id = (SELECT ID FROM Highschooler WHERE name = 'Kyle') EXCEPT SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T2.ID = T1.student_id GROUP BY T2.name HAVING COUNT(*) > 1;
SELECT COUNT(*) FROM Friend AS F INNER JOIN Highschooler AS H ON F.student_id = H.ID WHERE H.name = 'Kyle'
SELECT T1.name, COUNT(T1.id) as friend_count FROM Highschooler AS T1 JOIN Friend AS T2 ON T2.student_id = T1.id AND T1.name = 'Kyle' GROUP BY T1.id
SELECT `ID` FROM Highschooler WHERE ID NOT IN (SELECT friend_id FROM Friend) AND ID NOT IN (SELECT student_id FROM Friend)
SELECT H.ID FROM Highschooler AS H LEFT JOIN Friend AS F ON H.ID = F.student_id WHERE F.student_id IS NULL
SELECT name FROM Highschooler WHERE ID NOT IN (SELECT friend_id FROM Friend) OR ID = (SELECT friend_id FROM Friend)
SELECT `name`, `grade` FROM Highschooler WHERE `ID` NOT IN (SELECT `student_id` FROM Friend) OR `ID` NOT IN (SELECT `friend_id` FROM Friend)
SELECT ID FROM Highschooler WHERE ID IN ( SELECT student_id FROM Likes INTERSECT SELECT friend_id FROM Friend ) AND ID IN ( SELECT friend_id FROM Friend INTERSECT SELECT liked_id FROM Likes );
-- Select ID of students who both have friends and are liked SELECT id FROM Highschooler WHERE id IN ( SELECT student_id FROM Friend ) AND id IN ( SELECT student_id FROM Likes );
SELECT name FROM highschooler WHERE ID IN ( SELECT student_id FROM highschooler AS T1 JOIN Friend AS T2 ON (T1.id = T2.student_id) GROUP BY T1.ID HAVING COUNT(T2.student_id) > 0 INTERSECT SELECT student_id FROM Likes AS T1 JOIN highschooler AS T2 ON (T1.liked_id = T2.ID) GROUP BY T2.name HAVING COUNT(T1.liked_id) > 0 )
SELECT h.name FROM highschooler AS h WHERE h.id IN ( SELECT f.student_id FROM friend AS f INTERSECT SELECT l.liked_id FROM likes AS l )
SELECT L1.student_id, COUNT(L1.liked_id) as like_count FROM Highschooler AS H1 INNER JOIN Likes AS L1 ON H1.ID = L1.student_id GROUP BY L1.student_id;
SELECT L.student_id, COUNT(*) AS likes_count FROM Likes L GROUP BY L.student_id;
SELECT H.`name`, COUNT(DISTINCT L.liked_id) AS number_of_likes FROM Highschooler AS H JOIN Likes AS L ON H.ID = L.student_id GROUP BY H.name
SELECT H.name, COUNT(L.liked_id) as likes FROM highschooler H JOIN likes L ON H.id = L.student_id GROUP BY H.name;
SELECT name FROM Highschooler ORDER BY (SELECT COUNT(*) FROM Likes WHERE Likes.student_id = Highschooler.ID) DESC LIMIT 1;
SELECT T3.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.ID JOIN Highschooler AS T3 ON T1.liked_id = T3.ID GROUP BY T3.ID ORDER BY COUNT(T3.ID) DESC LIMIT 1;
SELECT name FROM Highschooler AS T1 WHERE T1.ID IN ( SELECT student_id FROM Likes GROUP BY student_id HAVING COUNT(*) > 1 )
SELECT `name`, count(*) FROM Highschooler AS T1 JOIN Likes AS T2 ON T1. `ID` = T2. `student_id` GROUP BY T1. `name` HAVING COUNT(T2. `liked_id`) >= 2
SELECT H.name FROM Highschooler H JOIN Friend F ON H.id = F.student_id WHERE H.grade > 5 GROUP BY H.id HAVING COUNT(F.friend_id) >= 2;
SELECT name FROM Highschooler WHERE grade > 5 AND ID IN ( SELECT student_id FROM Friend GROUP BY student_id HAVING COUNT(*) > 2 )
SELECT student_id, COUNT(DISTINCT liked_id) FROM Highschooler JOIN Likes ON student_id = id WHERE name = 'Kyle';
SELECT COUNT(*) FROM Likes JOIN Highschooler ON Likes.student_id = Highschooler.ID WHERE Highschooler.name = 'Kyle'
## Type: SELECT SELECT AVG(H1.grade) AS average_grade FROM Highschooler H1 JOIN Friend F ON H1.ID = F.student_id GROUP BY H1.id HAVING COUNT(DISTINCT F.friend_id) > 0;
SELECT AVG(t2.`grade`) FROM Friend t1 JOIN Highschooler t2 ON (t1.student_id = t2.id OR t1.friend_id = t2.id) WHERE t1.student_id = t2.id GROUP BY t2.id
SELECT MIN(T1.grade) AS Student_Grade FROM Highschooler T1 LEFT JOIN Friend T2 ON T1.ID = T2.student_id AND T2.friend_id IS NULL GROUP BY T1.name
SELECT MIN(Highschooler.grade) as Min_Grade FROM Highschooler LEFT JOIN Friend ON Highschooler.ID = Friend.student_id OR Highschooler.ID = Friend.friend_id WHERE Highschooler.ID NOT IN (SELECT student_id FROM Friend UNION SELECT friend_id FROM Friend)
SELECT T1.state FROM Owners AS T1 INNER JOIN Professionals AS T2 ON T1.owner_id = -T2.professional_id GROUP BY T1.state HAVING COUNT(T1.state) BETWEEN 5 AND 6
SELECT DISTINCT O.state AS owner_state, P.state AS professional_state FROM Owners O JOIN Professionals P ON 1=1;
SELECT AVG(T1.age) FROM Dogs T1 JOIN Treatments T2 ON T1.dog_id = T2.dog_id
SELECT ROUND(AVG(T1.date_of_birth), 2) AS average_birthdate FROM Dogs AS T1 JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id;
SELECT DISTINCT P.professional_id, P.last_name, P.cell_number FROM Professionals P WHERE (P.state = 'Indiana') OR ( SELECT COUNT(T.treatment_id) FROM Treatments T WHERE T.professional_id = P.professional_id ) > 2;
SELECT P.professional_id, P.last_name AS last_name_professional, COALESCE(P.cell_number, "null") as cell_phone FROM Professionals P WHERE LOWER(P.state) = 'indiana' AND P.professional_id IN ( SELECT T.professional_id FROM Treatments T INNER JOIN Treatment_Types TT ON T.treatment_type_code = TT.role_code GROUP BY T.professional_id HAVING COUNT(DISTINCT T.date_of_treatment) > 2)
SELECT d.name FROM Dogs AS d WHERE (SELECT COUNT(cost_of_treatment) FROM Treatments WHERE dog_id = d.dog_id) < 2 * 500;
SELECT name FROM Dogs WHERE dog_id = (SELECT dog_id FROM Treatments WHERE cost_of_treatment < 1000 GROUP BY dog_id HAVING SUM(cost_of_treatment) < 1000)
SELECT DISTINCT p.first_name AS Not_Dog_Name FROM Professionals p LEFT JOIN Owners o ON p.email_address = o.email_address LEFT JOIN Dogs d ON o.owner_id = d.owner_id WHERE p.first_name NOT IN ( SELECT name FROM Dogs )
SELECT first_name FROM Owners EXCEPT SELECT first_name FROM Professionals UNION SELECT name FROM Dogs
SELECT P.`professional_id`, P. `role_code`, P.email_address FROM Professionals P LEFT JOIN Treatments T ON P.professional_id = T.professional_id WHERE T.treatment_type_code IS NULL;
SELECT p.professional_id, CONCAT(p.first_name, ' ', p.last_name) AS role, p.email_address FROM professionals p LEFT JOIN treatments t ON p.professional_id = t.professional_id WHERE t.treatment_id IS NULL;
SELECT `owner_id`, `first_name`, `last_name` FROM Owners WHERE `owner_id` = (SELECT `owner_id` FROM Dogs GROUP BY `owner_id` ORDER BY COUNT(*) DESC LIMIT 1)
SELECT O.owner_id, O.first_name, O.last_name FROM Owners O INNER JOIN Dogs D ON O.owner_id = D.owner_id GROUP BY O.owner_id, O.first_name, O.last_name ORDER BY COUNT(D.dog_id) DESC LIMIT 1;
SELECT Professionals.`professional_id`, Treatments.treatment_type_code AS role_code, Professionals.first_name FROM Professionals INNER JOIN Treatments ON Professionals.professional_id = Treatments.professional_id GROUP BY Professionals.professional_id, Treatments.treatment_type_code, Professionals.first_name;
SELECT T.treatment_id, P.role_code AS Role, P.first_name AS FirstName, DS.size_code As DogSize, DR.breed_code As Breed FROM Treatments T JOIN Professionals P ON (T.professional_id = P.professional_id) JOIN Dogs D ON (T.dog_id = D.dog_id) JOIN Sizes DS ON (DS.size_code = D.size_code) JOIN Breeds DR ON (DR.breed_code = D.breed_code) LEFT JOIN ( SELECT size_code, COUNT(dog_id) AS Count FROM Dogs GROUP BY size_code ) subquery ON DS.size_code = subquery.size_code WHERE subquery.Count IS NULL AND T.treatment_id NOT IN( SELECT treatment_id FROM Treatments JOIN Dogs D ON (T.dog_id = D.dog_id) GROUP BY dog_id HAVING COUNT(DISTINCT treatment_id) > 1 ) OR subquery.Count > 1;
SELECT B.breed_name FROM Breeds AS B JOIN Dogs AS D ON B.breed_code = D.breed_code GROUP BY B.breed_name ORDER BY COUNT(D.dog_id) DESC LIMIT 1;
SELECT T2.breed_name FROM Dogs AS T1 JOIN Breeds AS T2 ON T1.breed_code = T2.breed_code GROUP BY T2.breed_name ORDER BY COUNT(DISTINCT T1.dog_id) DESC LIMIT 1;
SELECT owner_id, last_name, COALESCE(SUM(CASE WHEN t.dog_id IS NOT NULL THEN 1 ELSE 0 END), 0) as treatment_count FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id LEFT JOIN Treatments t ON d.dog_id = t.dog_id GROUP BY owner_id, last_name;
SELECT O.owner_id, P.last_name as OwnerLastname, CO.TotalCost FROM ( SELECT dog_id, SUM(cost_of_treatment) as TotalCost FROM Treatments GROUP BY dog_id ) AS CO JOIN Dogs D ON CO.dog_id = D.dog_id JOIN Owners O ON D.owner_id = O.owner_id JOIN Professionals P ON EXISTS (SELECT 1 FROM Treatments T WHERE T.date_of_treatment LIKE '2018-03-24%' AND T.professional_id = P.professional_id AND T.dog_id = CO.dog_id) ORDER BY CO.TotalCost DESC LIMIT 1;
SELECT ttc.description FROM Treatment_Types ttc WHERE ttc.treatment_type_code IN ( SELECT MIN(t2.treatment_type_code) FROM Treatments t2 GROUP BY t2.treatment_type_code HAVING MAX(cost_of_treatment) = MIN(cost_of_treatment) );
WITH treatment_min_costs AS ( WITH tempTable AS ( SELECT MIN(cost_of_treatment) as min_cost, treatment_type_code FROM Treatments GROUP BY treatment_type_code ) SELECT * FROM tempTable GROUP BY min_cost, treatment_type_code HAVING COUNT(*) = (SELECT COUNT(treatment_type_code) FROM Treatment_Types) AND min_cost = MIN(cost_of_treatment)) SELECT tt.type_description AS TYPE_DESCRIPTION, tc.min_cost FROM Treatment_Types tt INNER JOIN treatment_min_costs tc ON tt.treatment_type_code = tc.treatment_type_code
SELECT o.owner_id, o.zip_code, SUM(t.cost_of_treatment) AS total_cost FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id JOIN Treatments t ON d.dog_id = t.dog_id GROUP BY o.owner_id, o.zip_code ORDER BY total_cost DESC LIMIT 1;
-- First drop the Tables if exists. DROP TABLE IF EXISTS Owners; DROP TABLE IF EXISTS Addresses; DROP TABLE IF EXISTS Sizes; DROP TABLE IF EXISTS Breeds; DROP TABLE IF EXISTS Dogs; DROP TABLE IF EXISTS Treatment_Types; DROP TABLE IF EXISTS Professionals; DROP TABLE IF EXISTS Treatments; -- Now create and populate the Owners Table CREATE TABLE Owners ( owner_id INT PRIMARY KEY, name VARCHAR(255), last_name VARCHAR(100) ); INSERT INTO Owners (owner_id, name, last_name) VALUES (1, 'Watsica', 'Havenstein'), (2, 'Walter', 'Denesik'), (3, 'Ullrich', 'Ziemann'), (4, 'Tillman', 'Lynch'), (5, 'Pouros', 'Gislason'), (6, 'OReilly', ''); -- Next create and populate the Addresses Table CREATE TABLE Addresses ( owner_id INT NOT NULL, street VARCHAR(255), city VARCHAR(100), state VARCHAR(100), zip_code VARCHAR(20), PRIMARY KEY(owner_id) ); INSERT INTO Addresses (owner_id, street, city, state, zip_code) VALUES -- Make sure to match ids with Owners id (1, '92912 Langworth Valleys Apt. 743\nThompsonborough,', 'West Heidi', 'Indiana', '98844'), (2, '88665 Terence Lodge Apt. 904\nCorneliusfort, NC 194', 'South Rockyport', 'Connecticut', '84515'), (3, '7783 Abraham Alley\nPort Madelynhaven, KY 59172-273', 'Raynorfort', 'Wyoming', '80775'), (4, '7284 Torphy Flats Apt. 610\nDiannaburgh, SC 78560', 'North Odellfurt', 'Wisconsin', '77129'), (5, '72532 Hane Course\nLake Berylland, ND 95283', 'North Adelberttown', 'Utah', '67980'), (6, '6915 Oberbrunner Point Suite 491\nGleasonville, LA ', 'New Maryjane', 'SouthCarolina', '54312'); -- Next create the Sizes Table CREATE TABLE Sizes ( size_code INT PRIMARY KEY, size VARCHAR(10) ); INSERT INTO Sizes (size_code, size) VALUES -- Make sure to put small and big values for size. (1, 'X'), (2, 'Y'); -- Then create the Breeds Table CREATE TABLE Breeds ( breed_code VARCHAR(20) PRIMARY KEY, breed_name VARCHAR(50) ); INSERT INTO Breeds (breed_code, breed_name) VALUES ('A', 'German Shepherd'), ('B', 'Labrador Retriever'); -- Now create the Dogs Table and populate it CREATE TABLE Dogs ( dog_id INT NOT NULL PRIMARY KEY, size_code INT NOT NULL, breed_code VARCHAR(20) NOT NULL, owner_id INT NOT NULL, FOREIGN KEY (owner_id) REFERENCES Owners(owner_id) ); INSERT INTO Dogs (dog_id, size_code, breed_code, owner_id) VALUES -- Example insertion values. Replace them with actual dog data (1, 1, 'A', 1), (2, 2, 'B', 3), (3, 1, 'B', 5); -- Next create the Treatment_Types Table CREATE TABLE Treatment_Types ( treatment_type_id INT NOT NULL PRIMARY KEY, treatment_type_code VARCHAR(10) UNIQUE ); INSERT INTO Treatment_Types (treatment_type_id, treatment_type_code) VALUES (1, 'T'), (2, 'S'); -- After that create and populate the Professionals Table CREATE TABLE Professionals ( professional_id INT NOT NULL PRIMARY KEY, name VARCHAR(255) ); INSERT INTO Professionals (professional_id, name) VALUES -- Example insertion values. Replace them with actual data. (1, 'John Doe'), (2, 'Jane Doe'); -- Now create the Treatments table CREATE TABLE Treatments ( treatment_id INT NOT NULL PRIMARY KEY, dog_id INT NOT NULL, professional_id INT NOT NULL, treatment_type_code VARCHAR(10) NOT NULL, date_of_treatment DATE NOT NULL, cost_of_treatment INT NOT NULL, FOREIGN KEY (dog_id) REFERENCES Dogs(dog_id), FOREIGN KEY (professional_id, date_of_treatment) REFERENCES Professionals(professional_id), FOREIGN KEY (treatment_type_code) REFERENCES Treatment_Types(treatment_type_code) ); INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES -- Make sure to put a valid data for existing foreign keys. (1, 1, 1, 'T', '2022-10-16', 220), (2, 3, 2, 'S', '2022-02-25', 300); -- Finally query the tables. SELECT O.name, D.size_code, T.treatment_type_code FROM Owners O JOIN Addresses A ON O.owner_id = A.owner_id JOIN Dogs D ON O.owner_id = D.owner_id JOIN Treatments T ON D.dog_id = T.dog_id;
SELECT P.professional_id, P.cell_number FROM Professionals P JOIN Treatment_Types TT ON TT.TREATMENT_TYPE_CODE = ( SELECT T.treatment_type_code FROM Treatments T GROUP BY T.treatment_type_code HAVING COUNT(T.treatment_type_code) > 1 ) JOIN Professionals P1 ON P.professional_id=P1.professional_id;
SELECT P.professional_id, P.cell_number FROM Professionals P JOIN Treatments T ON P.professional_id = T.professional_id GROUP BY P.professional_id, P.cell_number HAVING COUNT(DISTINCT T.treatment_type_code) >= 2;
SELECT `first_name`, `last_name` FROM Professionals WHERE professional_id IN (SELECT professional_id FROM Treatments WHERE cost_of_treatment < (SELECT AVG(cost_of_treatment) FROM Treatments))
# Since we have subqueries within our SQL, it might result in SQL error, # so here I use temporary table to solve that problem first CREATE TEMPORARY TABLE temp_treatments AS ( SELECT professional_id, AVG(cost_of_treatment) as avg_cost FROM Treatments GROUP BY professional_id ); WITH t AS ( SELECT DISTINCT p.professional_id , (SELECT cost_of_treatment FROM Treatments WHERE dog_id = d.dog_id ORDER BY date_of_treatment LIMIT 1 ) as mincost --, ROUND (( SELECT SUM(cost_of_treatment) / 2 ), 0) as avgcost ,(SELECT COUNT(cost_of_treatment) FROM Travelments where professional_id=p.professional_id )as tcountdcount from Professionals p JOIN Treatments t ON p.professional_id = t.professional_id join Dogs d ON t.dog_id=d.dog_id ) -- This will get desired output, please find it below: SELECT first_name , last_name FROM t INNER JOIN professionals on t.professional_id = professionals.professional_id where mincost < ( SELECT avg_cost FROM temp_treatments );
SELECT T1.date_of_treatment, P.first_name, T1.treatment_type_code AS treatment_type FROM Treatments AS T1 JOIN Professionals AS P ON T1.professional_id = P.professional_id;
SELECT STRFTIME('%Y-%m-%d', T.date_of_treatment) AS treatment_date, P.first_name AS professional_first_name, T.cost_of_treatment FROM Treatments T JOIN Professionals P ON P.professional_id = T.professional_id ORDER BY T.date_of_treatment;
SELECT cost_of_treatment AS Cost, treatment_type_description AS 'Treatment Type Description' FROM Treatments join Treatment_Types as TT2 ON Treatments.treatment_type_code = TT2.treatment_type_code;
SELECT T1.cost_of_treatment, TT.treatment_type_code FROM Treatments T1 JOIN Treatment_Types TT ON T1.treatment_type_code = TT.treatment_type_code ORDER BY cost_of_treatment;
SELECT Owners.first_name, Owners.last_name, Sizes.size_description AS size FROM Owners JOIN Dogs ON Owners.owner_id = Dogs.owner_id JOIN Sizes ON Dogs.size_code = Sizes.size_code;
SELECT O.first_name AS Owner_First_Name, O.last_name AS Owner_Last_Name, T.size_description AS Dog_Size FROM Owners O JOIN Dogs D ON O.owner_id = D.owner_id JOIN Sizes T ON D.size_code = T.size_code;
SELECT o.first_name, d.name FROM Owners AS o JOIN Dogs AS d ON o.owner_id = d.owner_id;
SELECT o.first_name, d.name FROM Owners AS o JOIN Dogs AS d ON o.owner_id = d.owner_id;
SELECT DISTINCT D.name, T.Date_of_treatment FROM Dogs D LEFT JOIN Treatments T On D.dog_id = T.Dog_id;
WITH tempSize AS ( SELECT size_code FROM Sizes GROUP BY size_code HAVING COUNT(*) = ( SELECT MIN(population) FROM Sizes ) ) SELECT D.name, -- name field from Dogs table, this should be matched against value of column dog_id in table Treatments T.date_of_treatment as "date of treatment" FROM Treatments T JOIN Dogs D ON T.dog_id = D.dog_id WHERE D.size_code IN (SELECT size_code FROM tempSize);
SELECT O.first_name, D.name FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id WHERE O.state = 'Virginia';
SELECT DISTINCT O.last_name , D.name FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id WHERE O.state = 'Virginia';
SELECT d.date_arrived, d.date_departed, t.cost_of_treatment FROM Dogs d JOIN Treatments t ON d.dog_id = t.dog_id GROUP BY d.date_arrived, d.date_departed HAVING COUNT(t.dog_id) > 1;
SELECT D.date_arrived, D.date_departed FROM Dogs D JOIN Treatments T ON D.dog_id = T.dog_id WHERE T.treatment_type_code IN ('Health Check', 'Drugs') AND T.cost_of_treatment > (SELECT MIN(cost_of_treatment) FROM Treatments) ORDER BY D.date_arrived DESC, D.date_departed ASC;
SELECT T2.last_name FROM Dogs AS T1 JOIN Owners AS T2 ON T1.owner_id = T2.owner_id ORDER BY T1.age LIMIT 1;
SELECT first_name , last_name FROM Owners WHERE owner_id = ( SELECT owner_id FROM Dogs WHERE age = ( SELECT MIN(age) FROM Dogs ) )
SELECT email_address FROM Owners WHERE state IN ('Hawaii', 'Wisconsin')
SELECT `email_address` FROM Professionals WHERE `state` = 'Hawaii' OR `state` = 'Wisconsin'
SELECT Dogs.`date_arrived`, Dogs.`date_departed` FROM Dogs
SELECT T1.date_arrived, T1.date_departed FROM Dogs AS T1
SELECT COUNT(dog_id) FROM Treatments;
SELECT COUNT(dog_id) FROM Dogs WHERE date_departed IS NOT NULL AND dog_id IN ( SELECT dog_id FROM Treatments );
SELECT COUNT(DISTINCT `Professional_ID`) FROM Treatments;
SELECT COUNT(DISTINCT `professional_id`) FROM Treatments;
SELECT `Professional_id`, T.`treatment_type_code` , date_of_treatment, cost_of_treatment FROM Treatments T WHERE T.`date_of_treatment` >= ('2018-03-17')
SELECT p.role_code, p.first_name, o.owner_id, d.breed_name, s.size_code, a.street, c.city, st.state, z.zip_code, t.treatment_type_code FROM Professionals p JOIN Owners o ON p.professional_id = o.owner_id JOIN Dogs d ON o.owner_id = d.owner_id JOIN Sizes s ON d.size_code = s.size_code JOIN Addresses a ON o.owner_id = a.owner_id JOIN Cities c ON a.city_id = c.city_id JOIN States st ON c.state_id = st.state_id JOIN ZipCodes z ON a.zip_code = z.zip_code JOIN Treatments t ON p.professional_id = t.professional_id;
SELECT `first_name`, `last_name`, `email_address` FROM Owners WHERE state LIKE '%North%'
SELECT first_name, last_name, email_address FROM Owners WHERE state LIKE '%North%'
SELECT COUNT(*) AS Count FROM Dogs WHERE age < ( SELECT AVG(age) FROM Dogs );
EXPLAIN WITH AverageAge AS ( SELECT AVG(CAST(age as real)) AS total_average_age FROM Dogs ) SELECT COUNT(dog_id) FROM Dogs WHERE age < (SELECT ROUND(total_average_age - 0.5, 0) FROM AverageAge);
SELECT MAX(T1.cost_of_treatment) FROM Treatments AS T1 JOIN Treatment_Types ON T1.treatment_type_code = Treatment_Types.treatment_type_code WHERE T1.date_of_treatment IS NOT NULL AND STRFTIME('%Y-%m-%d', T1.date_of_treatment) = (SELECT MAX(STRFTIME('%Y-%m-%d', T2.date_of_treatment)) FROM Treatments AS T2)
SELECT CAST(SUM(cost_of_treatment) AS DECIMAL(10, 2)) AS most_recent_total_treatment_cost FROM ( SELECT cost_of_treatment FROM Treatments ORDER BY date_of_treatment DESC LIMIT 1 ) sub_query;
SELECT COUNT(`name`) FROM Dogs WHERE dog_id NOT IN (SELECT dog_id FROM Treatments)
SELECT COUNT(dog_id) FROM Dogs WHERE dog_id NOT IN (SELECT dog_id FROM Treatments)
SELECT COUNT(*) FROM Owners WHERE owner_id NOT IN (SELECT owner_id FROM Dogs);
SELECT COUNT(DISTINCT `owner_id`) FROM Owners WHERE `owner_id` NOT IN ( SELECT `dog_id` FROM Dogs )
SELECT COUNT(professionals.role_code) AS `number_of_professionals` FROM Professionals WHERE professional_id NOT IN ( SELECT professional_id FROM Treatments )
SELECT COUNT(DISTINCT professional_id) FROM Professionals WHERE professional_id NOT IN (SELECT DISTINCT professional_id FROM Treatments)
SELECT DISTINCT d.name, d.age, d.weight FROM Dogs d JOIN ( SELECT dog_id, MAX(date_departed) as max_date FROM Dates_Departed GROUP BY dog_id ) l ON d.dog_id = l.dog_id;
SELECT d.name, d.age, d.weight FROM Dogs AS d JOIN Owners AS o ON d.owner_id = o.owner_id WHERE d.abandoned_yn = '1'
SELECT AVG(age) FROM Dogs;
SELECT AVG(`age`) FROM Dogs
SELECT Age FROM dogs WHERE `dog_id` = (SELECT MAX(`dog_id`) FROM dogs)
SELECT `age` FROM Dogs WHERE dog_id = (SELECT MAX(dog_id) FROM dogs)
SELECT TYPE AS treatment_type, SUM(COST_OF_TREATMENT) AS TotalCost FROM ( SELECT id AS type, COST_OF_TREATMENT FROM Treatments JOIN Treatment_Types TT ON T.treatment_type_code = TT.id ) t GROUP BY TYPE;
SELECT charge_type, SUM(charge_amount) as Total_Cost FROM Charges GROUP BY charge_type ORDER BY charge_type ASC;
SELECT T2.charge_amount FROM Charges T2 WHERE T2.charge_amount = ( SELECT MAX(charge_amount) FROM Charges );
SELECT MAX(charge_amount) FROM Charges;
SELECT email_address, cell_number AS CellPhone, home_phone AS HomePhone FROM Professionals
SELECT first_name, last_name, email_address AS Email, cell_number AS Cell_Number, home_phone AS Home_Number FROM Professionals;
error: No SQL found in the input string
SELECT DISTINCT B.breed_name AS "Breed Type", S.size_description AS "Size Type" FROM Breeds B JOIN Dogs D ON B.breed_code = D.breed_code JOIN Sizes S ON D.size_code = S.size_code;
SELECT p.first_name, tt.treatment_type_description FROM Professionals p INNER JOIN Treatments t ON p.professional_id = t.professional_id INNER JOIN Treatment_Types tt ON t.treatment_type_code = tt.treatment_type_code;
SELECT p.first_name, tt.description, -- changed from ttt to tt t.date_of_treatment, t.cost_of_treatment FROM Professionals p INNER JOIN Treatments t ON p.professional_id = t.professional_id INNER JOIN Treatment_Types tt ON t.treatment_type_code = tt.treatment_type_code;
SELECT COUNT(DISTINCT Singer_ID) AS number_of_singers FROM song;
SELECT COUNT(`Name`) FROM singer;
SELECT Name, Net_Worth_Millions FROM singer ORDER BY Net_Worth_Millions DESC;
SELECT s.Name as Singer FROM ( SELECT ss.singer_id, MAX(ss.Sales) AS max_sales FROM singer ss JOIN song ssong ON ssong.Singer_ID = ss.Singer_ID GROUP BY ss.song_Singer_ID -- corrected column name ) son JOIN singer s ON son.singer_id = s.Singer_ID GROUP BY s.Name ORDER BY s.Net_Worth_Millions ASC;
SELECT singer.Birth_Year, singer.Citizenship FROM singer WHERE Singer_ID IN ( SELECT T2.`Singer_ID` FROM song AS T1 INNER JOIN singer AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY Title ORDER BY T1.Highest_Position DESC LIMIT 5) GROUP BY `Birth_Year` , Citizenship
-- SQLite, song and singer table management. CREATE TABLE IF NOT EXISTS singer ( Singer_ID INTEGER PRIMARY KEY, Name TEXT NOT NULL, Birth_Year REAL NOT NULL UNIQUE, Net_Worth_Millions REAL NOT NULL, Citizenship TEXT NOT NULL); INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Susanne Klatten', 1962.0, 30.0, 'United States'), (2, 'Liliane Bettencourt', 1961.0, 28.8, 'Germany'), (3, 'Jacqueline Mars', 1953.0, 26.3, 'France'), (4, 'Iris Fontbona', 1949.0, 17.8, 'Chile'), (5, 'Gina Rinehart', 1948.0, 17.4, 'Australia'), (6, 'Christy Walton', 1944.0, 17.0, 'United States'); SELECT S1.`Birth_Year` AS Singer_Birth_Year, S1.`Citizenship` AS CitizenShipOfSinger FROM singer S1;
SELECT Name FROM singer WHERE Citizenship <>'France'
SELECT DISTINCT `Name` FROM singer WHERE `Citizenship` != 'France'
SELECT Name FROM singer WHERE Birth_Year IN ( SELECT Birth_Year FROM singer GROUP BY Birth_Year HAVING COUNT(Birth_Year) > 1 )
SELECT DISTINCT Name FROM singer WHERE Birth_Year IN (1948, 1949)
SELECT `Name` FROM singer WHERE `Net_Worth_Millions` = (SELECT MAX(`Net_Worth_Millions`) FROM singer);
SELECT s.`Name`, sum(st.`Sales`) as total_sales, st.`Singer_ID` FROM singer s INNER JOIN song st ON s.`Singer_ID` = st.`Singer_ID` GROUP BY s.`Singer_ID` ORDER BY total_sales DESC;
SELECT `Citizenship`, COUNT(T2.`Singer_ID`) AS total_singer FROM `singer` T1 LEFT JOIN `song` T2 ON T1.`Singer_ID` = T2.`Singer_ID` GROUP BY `Citizenship`
SELECT `Citizenship`, COUNT(*) FROM singer GROUP BY `Citizenship`;
SELECT `Citizenship` FROM ( SELECT `Citizenship`, COUNT(*) AS count FROM singer GROUP BY `Citizenship` ) subquery ORDER BY count DESC LIMIT 1;
SELECT `Citizenship` FROM singer GROUP BY `Citizenship` HAVING COUNT(`Singer_ID`) = ( SELECT MAX(count) FROM ( SELECT `Singer_ID`, COUNT(*) as count FROM song GROUP BY `Singer_ID` ) AS foo )
SELECT t2.citizenship, max_worth FROM (SELECT Citizenship, MAX(Net_Worth_Millions) AS max_worth FROM singer GROUP BY Citizenship) AS t1 INNER JOIN singer AS t2 ON t1.Citizenship = t2.Citizenship GROUP BY t2.citizenship
SELECT T1.`Citizenship`, MAX(T1.`Net_Worth_Millions`) AS `Max_Net_worth` FROM singer AS T1 GROUP BY T1.`Citizenship`
SELECT DISTINCT title as titles , Name FROM song AS S JOIN singer AS T ON S.Singer_ID = T.Singer_ID ORDER BY Sales DESC;
SELECT S.Name, T.Title AS `Song_Title` FROM singer AS S JOIN song AS T ON T.Singer_ID = S.Singer_ID;
SELECT DISTINCT singer.`Name` FROM singer, song WHERE singer.Singer_ID = song.Singer_ID AND song.Sales > 30000000;
SELECT Distinct `Name` FROM singer AS s JOIN song AS ss ON s.`Singer_ID` = ss.`Singer_ID` GROUP BY Name HAVING Sum(Sales) > 30000000
SELECT Name FROM ( SELECT singer.Name, COUNT(song.Singer_ID) as counts FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Name ) WHERE Counts > 1;
SELECT Name FROM singer AS s WHERE Singer_ID IN (SELECT Singer_ID FROM song GROUP BY Singer_ID HAVING COUNT(*) > 1);
SELECT S.`Name`, SUM(G.Sales) FROM singer S JOIN song G ON S.`Singer_ID` = G.`Singer_ID` GROUP BY S.`Singer_ID`, S.`Name`
SELECT T1.`Name`, SUM(T2.`Sales`) AS `Total_Sales` FROM singer AS T1 JOIN song AS T2 ON T1.`Singer_ID` = T2.`Singer_ID` GROUP BY T1.`Name`
SELECT s.`Name`, COUNT(ss.`Singer_ID`) as No_Song FROM singer s LEFT JOIN song ss ON s.`Singer_ID` = ss.`Singer_ID` WHERE ss.`Singer_ID` IS NULL GROUP BY s.`Name`
SELECT `Name` FROM singer WHERE Singer_ID NOT IN (SELECT Singer_ID FROM (SELECT DISTINCT Singer_ID AS Singer_ID FROM song) AS foo)
SELECT DISTINCT `Citizenship` FROM singer WHERE Birth_Year < 1945 AND Birth_Year > 1955
SELECT `Citizenship` FROM singer WHERE Birth_Year BETWEEN (SELECT MIN(`Birth_Year`) FROM singer) AND (SELECT MAX(`Birth_Year`) FROM singer) AND ((Birth_Year < 1945 OR Birth_Year > 1955) AND (Birth_Year IS NOT NULL));
SELECT COUNT(*) AS Total_available_features FROM Other_Available_Features
SELECT T2.feature_type_name FROM Other_Available_Features AS T1 JOIN Ref_Feature_Types AS T2 ON T1.feature_type_code = T2.feature_type_code WHERE T1.feature_name = 'AirCon';
SELECT T2.`property_type_description` FROM Properties AS T1 JOIN Ref_Property_Types AS T2 ON (T1.property_type_code = T2.property_type_code)
SELECT p.property_name FROM Properties p JOIN Ref_Property_Types r ON p.property_type_code = r.property_type_code WHERE r.property_type_description IN ('House, Bungalow, etc.', 'Apartment, Flat, Condo, etc.') AND p.room_count > 1;
