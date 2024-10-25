SELECT COUNT(*) FROM singer;
SELECT COUNT(*) FROM singer;
SELECT `Name`, `Country`, `Age` FROM singer ORDER BY `Age` DESC
SELECT Name, Country, Age FROM singer ORDER BY Age DESC;
SELECT AVG(Age), MIN(Age), MAX(Age) FROM singer WHERE Country = 'France'
SELECT AVG(Age) AS avg_age, MIN(Age) AS min_age, MAX(Age) AS max_age FROM singer WHERE Country = 'France';
SELECT T1.`Song_Name`, T1.`Song_release_year` FROM singer AS T1 JOIN ( SELECT Singer_ID, MIN(Age) AS Age FROM singer GROUP BY Singer_ID ) AS T2 ON T1.Singer_ID = T2.Singer_ID AND T1.Age = T2.Age;
SELECT T1.`Song_Name`, T1.`Song_release_year` FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.`Singer_ID` = T2.`Singer_ID` WHERE T1.`Age` = (SELECT MIN(Age) FROM singer)
SELECT DISTINCT Country FROM singer WHERE Age > 20
error: No SQL found in the input string
SELECT Singer.Country, COUNT(singer.Singer_ID) FROM singer GROUP BY Singer.Country
SELECT `Country`, COUNT(*) FROM singer GROUP BY `Country`
SELECT T1.`Song_Name` FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.Singer_ID = T2.Singer_ID WHERE T1.`Age` > (SELECT AVG(`Age`) FROM singer) ORDER BY T1.Name;
SELECT DISTINCT S.`Song_Name`, (S.Age - A.Average) as 'olderBy' FROM singer AS S JOIN stadium AS A ON 1=1 WHERE S.Age > A.Average; /* Output: Song_Name | olderBy | -------------------|---------| Love | 2 | Hey Oh | 14 | Gentleman | 18 | Dangerous | 28 | You | 30 | Sun | 32 | */
-- Show location and name for all stadiums with a capacity between 5000 and 10000. SELECT T1.Name, T1.Location FROM stadium AS T1 WHERE Capacity BETWEEN 5000 AND 10000;
SELECT `Location`, `Name` FROM stadium WHERE `Capacity` BETWEEN 5000 AND 10000;
SELECT Max(Capacity) as Max_Capacity ,AVG(Average) as Average_Capacity FROM stadium;
SELECT AVG(`Capacity`) AS `Average capacity`, MAX(`Capacity`) AS `Maximum capacity` FROM stadium;
error: No SQL found in the input string
SELECT T1.`Name`, T1.`Capacity` FROM stadium AS T1 WHERE (T1.`Average`) = ( SELECT MAX(T2.`Average`) FROM stadium AS T2 )
SELECT COUNT(*) FROM concert WHERE Year IN ('2014', '2015')
SELECT COUNT(*) FROM concert WHERE `Year` IN ('2014', '2015')
error: No SQL found in the input string
SELECT s.Name AS Stadium_Name, COUNT(c.concert_ID) FROM concert c JOIN stadium s ON c.Stadium_ID = s.Stadium_ID GROUP BY c.Stadium_ID;
error: No SQL found in the input string
SELECT T1.`Name`, T1.`Capacity` FROM (STADIUM AS T2 JOIN (CONCERT AS C JOIN SINGER_IN_CONCERT AS sic ON C.concert_ID= sic.concert_ID ) AS SS ON C.`Stadium_ID` =T2.`Stadium_ID`) WHERE SS.`Year` > '2013' GROUP BY T1.`Name`,T1.`Capacity` ORDER BY MAX(SS.concert_ID) DESC LIMIT 1;
SELECT YEAR AS year_with_most_concerts FROM concert GROUP BY YEAR ORDER BY COUNT(*) DESC LIMIT 1;
SELECT T2.Year, COUNT(T1.`Stadium_ID`) FROM stadium AS T1 JOIN concert AS T2 ON T1.`Stadium_ID`=T2.`Stadium_ID` GROUP BY T2.Year ORDER BY COUNT(T1.`Stadium_ID`) DESC LIMIT 1;
SELECT `Name` FROM stadium WHERE Stadium_ID NOT IN (SELECT Stadium_ID FROM concert)
SELECT DISTINCT T1.`Name` AS `Stadium Name` FROM `stadium` AS T1 LEFT JOIN `concert` AS T2 ON T1.`Stadium_ID` = T2.`Stadium_ID` WHERE T2.`Year` IS NULL
SELECT T1.Country FROM singer AS T1 JOIN singer_in_concert AS T2 ON T2.Singer_ID = T1.Singer_ID JOIN concert AS T3 ON T3.concert_ID = T2.concert_ID WHERE (T1.Age > 40 OR T1.Age < 30)
SELECT Name FROM stadium WHERE Stadium_ID NOT IN ( SELECT Stadium_ID FROM concert WHERE Year = '2014' )
SELECT T1.`Location` FROM stadium AS T1 JOIN concert AS T2 ON T1.`Stadium_ID` = T2.`Stadium_ID` WHERE T2.`Year` != '2014' GROUP BY T1.`Name` INTERSECT SELECT `Location` FROM ( SELECT `Location` FROM stadium GROUP BY `Name`)
SELECT C.`concert_Name`, C.`Theme`, COUNT(SI.`Singer_ID`) FROM concert AS C JOIN singer_in_concert AS SI ON C.concert_ID = SI.concert_ID GROUP BY C.concert_ID;
SELECT T1.`concert_Name` AS `concert_name`, T2.`Theme` AS `theme`, COUNT(DISTINCT T3.`Name`) AS `number_of_singers` FROM concert AS T1 JOIN singer_in_concert AS T2 ON T2.concert_ID = T1.concert_ID JOIN singer AS T3 ON T2.Singer_ID = T3.Singer_ID GROUP BY T1.`concert_Name`, T2.`Theme`;
SELECT T1.Name, COUNT(*) FROM singer AS T1 JOIN singer_in_concert AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Name;
SELECT T1.`Name`, COUNT(*) FROM stadium AS T1 JOIN concert AS T2 ON T1.`Stadium_ID` = T2.`Stadium_ID` GROUP BY T1.`Stadium_ID`
SELECT T2.`Name` FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.`Singer_ID` = T2.`Singer_ID` JOIN concert AS T3 ON T1.`concert_ID` = T3.`concert_ID` WHERE T3.`Year` = '2014'
SELECT `Name` FROM `singer` WHERE `Singer_ID` IN ( SELECT `Singer_ID` FROM `singer_in_concert` JOIN `concert` ON `singer_in_concert`.`concert_ID` = `concert`.`concert_ID` WHERE `Year` = '2014' )
type:sqlite SELECT s2.Name , sn.Country FROM singer as s1 INNER JOIN singer_in_concert sc ON s1.Singer_ID = sc.Singer_ID INNER JOIN singer as sn ON sn.Singer_ID = s1.Singer_ID WHERE s1.Song_Name LIKE '%Hey%' GROUP BY sn.Country;
SELECT DISTINCT S.`Name`, S.`Country` FROM singer AS S JOIN singer_in_concert ON S.`Singer_ID` = singer_in_concert.`Singer_ID` WHERE singer_in_concert.concertID IN ( SELECT c.`concert_ID` FROM concert c WHERE c.`Theme` LIKE '%Hey%' )
SELECT S1.Name, S1.Location FROM stadium AS S1 INNER JOIN concert AS C ON S1.Stadium_ID = C.Stadium_ID GROUP BY S1.Stadium_ID HAVING COUNT(CASE WHEN YEAR = '2014' THEN 1 END) = 1 AND COUNT(DISTINCT CASE WHEN YEAR = '2015' THEN 1 END) > 0
SELECT S.`Name`, S.`Location` FROM stadium AS S JOIN concert AS C ON S.`Stadium_ID` = C.`Stadium_ID` WHERE YEAR IN (SELECT `Year` FROM concert GROUP BY `Year` HAVING COUNT(`concert_ID`) > 1)
SELECT COUNT(*) FROM stadium AS T1 JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T1.Capacity = ( SELECT MAX(Capacity) FROM stadium )
SELECT COUNT(concert_ID) FROM concert WHERE Stadium_ID = (SELECT Stadium_ID FROM stadium WHERE Capacity = (SELECT MAX(Capacity) FROM stadium));
SELECT COUNT(T3.PetID) FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.weight > 10
SELECT COUNT(*) FROM Has_Pet AS T1 JOIN Pets AS T2 ON T1.PetID = T2.PetID WHERE T2.weight > 10;
SELECT MAX(T4.weight) AS weight_of_youngest_dog FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID JOIN Pets AS T3 ON T2.PetID = T3.PetID AND T3.PetType='dog' JOIN Pets AS T4 ON T3.PetID = T4.PetID WHERE T4.pet_age = (SELECT MIN(T4.pet_age) FROM Pets T4 WHERE T4.PetType = 'dog')
SELECT weight FROM Pets WHERE PetType = 'dog' AND pet_age = (SELECT MIN(pet_age) FROM Pets WHERE PetType = 'dog')
SELECT PetType, MAX(weight) FROM Pets GROUP BY PetType;
-- create table Student CREATE TABLE Student ( StuID INT, LName TEXT, Fname TEXT, Age INT, Sex TEXT, Major INT, Advisor TEXT, city_code TEXT ); -- Create table Has_Pet CREATE TABLE Has_Pet ( StuID INT, PetID INT ); -- Insert student data into table Student INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'Eric', 20, 'M', 600, NULL, 'PIT'), (2, 'Woods', 'Sarah', 21, 'F', 400, "Alice", 'NYC'); -- Create table Pets CREATE TABLE Pets ( PetID INT, pet_type TEXT, pet_age INT, weight REAL ); -- Insert data into table Pets INSERT INTO Pets (PetID, pet_type, pet_age, weight) VALUES (1,"cat",3.0,10), (2,'dog',4,'12'); -- Create many rows and select first data: INSERT INTO Has_Pet (StuID, PetID) VALUES (1, 2), (2, 1) SELECT p.pet_type AS pet_type, MAX(p.weight) AS max_weight FROM Pets p GROUP BY p.pet_type;
SELECT COUNT(DISTINCT T3.PetType) FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.`StuID` = T2.StuID JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T1.Age > 20;
SELECT T2.`PetType`, COUNT(*) FROM Student AS T1 JOIN Has_Pet AS T3 ON T1.`StuID` = T3.`StuID` JOIN Pets AS T2 ON T3.`PetID` = T2.`PetID` WHERE T1.Age > 20 GROUP BY T2.`PetType`
SELECT COUNT(*) FROM Pets AS T1 INNER JOIN Has_Pet AS T2 ON T1.PetID = T2.PetID INNER JOIN Student AS T3 ON T2.StuID = T3.Stuid WHERE T2.Stuid IN (SELECT Stuid FROM Student WHERE Sex = 'F') AND T1.PetType = 'dog'
SELECT COUNT(*) FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.`StuID` = T2.`StuID` JOIN Pets AS T3 ON T2.`PetID` = T3.`PetID` WHERE T1.`Sex` = 'F' AND T3.`PetType` = 'dog'
SELECT COUNT(DISTINCT `PetType`) FROM Pets;
SELECT COUNT(DISTINCT `PetType`) FROM Pets;
SELECT DISTINCT T1.`Fname` FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.`StuID` = T2.`StuID` JOIN Pets AS T3 ON T2.`PetID` = T3.`PetID` WHERE T3.`PetType` IN ('cat', 'dog')
-- Get the first names of every student who has a cat or dog as a pet SELECT DISTINCT S.Fname FROM Has_Pet HP JOIN Pets P ON HP.PetID = P.PetID JOIN Student S ON HP.StuID = S.StuID WHERE P.PetType IN ('dog', 'cat')
SELECT T2.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T2.StuID = T1.StuID WHERE T2.PetID IN ( SELECT PetID FROM Pets WHERE PetType = "cat" INTERSECT SELECT PetID FROM Have_pet WHERE PetType="dog" )
<!-- Type: SQL --> SELECT DISTINCT T1.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.`StuID` INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType IN ('cat', 'dog');
SELECT Major, Age FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet WHERE PetID IN (SELECT PetID FROM Pets WHERE PetType = 'cat'))
SELECT Student.LName, Student.Fname, Student.Age, Student.Major FROM Student WHERE Student.StuID NOT IN (SELECT StuID FROM Has_Pet WHERE PetID IN (SELECT PetID FROM Pets WHERE PetType='cat'))
SELECT StuID FROM Student WHERE StuID NOT IN (SELECT HP.StuID FROM Has_Pet HP JOIN Pets P ON HP.PetID = P.PetID WHERE P.PetType = 'cat')
-- What are the ids of the students who do not own cats as pets? SELECT Student.StuID FROM Student LEFT JOIN Has_Pet ON Student.StuID = Has_Pet.StuID LEFT JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType IS NULL OR Pets.PetType <> 'cat' ORDER BY Student.LName
-- Corrected SQL: Find the first name and age of students who have a dog but do not have a cat as a pet. SELECT Student.Fname, Student.Age FROM Student WHERE Student.StuID IN ( SELECT StuID FROM Has_Pet WHERE PetID IN ( SELECT PetID FROM Pets WHERE PetType = 'dog' ) ) AND Student.StuID NOT IN ( SELECT StuID FROM Has_Pet WHERE PetID IN ( SELECT PetID FROM Pets WHERE PetType != 'cat' ) )
SELECT Student.Fname FROM Student INNER JOIN Has_Pet ON Student.StuID = Has_Pet.StuID INNER JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'dog' AND HAS_PET.petid NOT IN (SELECT petid FROM pets WHERE pettype='cat')
SELECT DISTINCT P.`PetType`, P.`weight` FROM Student S JOIN Has_Pet HP ON S.StuID = HP.StuID JOIN Pets P ON HP.PetID = P.PetID WHERE S.Age = (SELECT MIN(Age) FROM Student) ORDER BY P.`weight` DESC
SELECT P.`PetType`, MAX(P.`weight`) AS Weight FROM Pets P WHERE P.`pet_age` = ( SELECT MIN(T1.`pet_age`) FROM Pets T1 ) GROUP BY P.`PetID`
SELECT PetID, weight FROM Pets WHERE pet_age > 1
SELECT T2.StuID, T3.weight FROM Has_Pet AS T4 JOIN Student AS T2 ON T4.StuID = T2.StuID JOIN Pets AS T3 ON T4.PetID = T3.PetID WHERE T3.pet_age > 1 AND T2.Age > 1 ORDER BY T3.weight ASC;
SELECT T1.PetType AS pet_type, AVG(T2.pet_age) AS average_age, MAX(T2.pet_age) AS max_age FROM Pets AS T1 JOIN Has_Pet AS T2 ON T1.PetID = T2.PetID GROUP BY T1.PetType;
SELECT PetType, AVG(pet_age) AS `Average_pet_age`, MAX(weight) AS `Max_weight` FROM Pets AS T1 JOIN Has_Pet AS T2 ON T1.`PetID` = T2.`PetID` GROUP BY PetType
SELECT PetType, AVG(weight) FROM Pets GROUP BY PetType
SELECT PetType, AVG(weight) FROM Pets GROUP BY PetType;
SELECT S.`Fname`, S.`Age` FROM Student AS S JOIN Has_Pet AS H ON S.`StuID` = H.`StuID`
SELECT DISTINCT S.`Fname`, S.`Age` FROM Student AS S INNER JOIN Has_Pet AS H ON S.StuID = H.StuID;
SELECT T3.`PetID` FROM Student AS T1 INNER JOIN `Has_Pet` AS T2 ON T1.`StuID` = T2.`StuID` INNER JOIN Pets AS T3 ON T2.`PetID` = T3.`PetID` WHERE T1.`LName` = 'Smith'
SELECT DISTINCT T3.PetID FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE LName = 'Smith'
SELECT S.StuID, COUNT(P.PetID) FROM Student AS S JOIN Has_Pet AS H ON S.StuID = H.StuID JOIN Pets AS P ON H.PetID = P.PetID GROUP BY S.StuID;
SELECT T1.StuID, COUNT(*) FROM Has_Pet AS T1 GROUP BY T1.StuID
SELECT Fname, Sex FROM Student WHERE StuID IN ( SELECT StuID FROM Has_Pet GROUP BY StuID HAVING COUNT(*) > 1 );
SELECT Fname AS First_Name ,Sex FROM Student WHERE StuID IN ( SELECT StuID FROM Has_Pet GROUP BY StuID HAVING COUNT(PetID) > 1 )
SELECT T1.`LName` FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.`StuID` = T2.`StuID` JOIN Pets AS T3 ON T2.`PetID` = T3.`PetID` WHERE T3.`pet_age` = 3 AND T3.`PetType` = 'cat'
SELECT S.`LName` FROM Student AS S JOIN Has_Pet AS HP ON S.`StuID` = HP.`StuID` JOIN Pets AS P ON HP.`PetID` = P.`PetID` WHERE P.`pet_age` = 3 AND P.`PetType` = 'cat'
SELECT AVG(Age) FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT AVG(Student.Age) FROM Student LEFT JOIN Has_Pet ON Student.StuID = Has_Pet.StuID WHERE Has_Pet.PetID IS NULL;
SELECT COUNT(*) FROM continents;
error: No SQL found in the input string
SELECT C.ContId, C.Continent, COUNT(DISTINCT T1.CountryName) AS NumOfCountries FROM continents C JOIN countries T1 ON C.ContId = T1.Continent GROUP BY C.ContId, C.Continent;
SELECT T1.`ContId`, T2.`Continent`, COUNT(*) FROM continents AS T1 JOIN countries AS T2 ON T1.`Continent` = T2.`Continent` GROUP BY T2.`Continent`
error: No SQL found in the input string
SELECT COUNT(*) FROM countries
error: No SQL found in the input string
SELECT T1.`FullName`, T1.`Id`, COUNT(T3.Model) AS 'Number_ofModels' FROM car_makers AS T1 JOIN model_list AS T2 ON T2.Maker = T1.Id JOIN car_names AS T3 ON T3.Model = T2.Model GROUP BY T1.Id, T1.FullName
SELECT DISTINCT m.Model, cn.MakeId FROM model_list m JOIN car_names cn ON m.Maker = cn.Model JOIN cars_data cd ON cn.Model = cd.Id WHERE cd.Horsepower = (SELECT MIN(Horsepower) FROM cars_data);
SELECT T1.Model FROM car_names AS T1 JOIN cars_data AS T2 ON T1.MakeId = T2.Id WHERE Horsepower = (SELECT MIN(Horsepower) FROM cars_data)
SELECT maker FROM model_list WHERE id NOT IN (SELECT Id FROM car_makers WHERE Country IN (SELECT CountryId FROM countries WHERE Continent != 'None'))
SELECT car_names.Model, model_list.Maker FROM car_names JOIN model_list ON model_list.Maker = car_names.MakeId JOIN cars_data ON cars_data.Id = car_names.MakeId WHERE cars_data.Weight < ( SELECT AVG(cars_data.Weight) FROM cars_data )
# NEW SQL does include: SELECT DISTINCT T2.`FullName` FROM car_makers AS T2 -- Corrected JOIN countries AS T1 ON T1.CountryID = T2.Country removed the wrong column instead of joining to the connected foreign key correctly JOIN car_makers AS T2 JOIN model_list AS T3 ON T3.Maker = T2.ID JOIN cars_data AS T4 ON T4.Year = '1970' AND T4.Id = (SELECT Id FROM car_names WHERE ModelId = T3.Model);
SELECT COUNT(DISTINCT T3.`Maker`) FROM car_names AS T1 INNER JOIN model_list AS T2 ON T1.`Model` = T2.`Model` INNER JOIN car_makers AS T3 ON T2.`Maker` = T3.`Id` WHERE T1.`Make` LIKE '%produced in 1970%'
SELECT distinct(T1.Make), T5.Year FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model... ...
SELECT T1.`Maker`, T6.`Year` FROM car_makers AS T1 JOIN model_list AS T3 ON T1.`Id` = T3.`Maker` JOIN car_names AS T4 ON T3.`Model` = T4.`Model` JOIN cars_data AS T6 ON T4.`MakeID` = T6.`Id` WHERE T6.`Year` = (SELECT MIN(`Year`) FROM cars_data)
SELECT DISTINCT T1.Model FROM car_names AS T1 INNER JOIN cars_data AS T2 ON T1.MakeId = T2.Id WHERE CAST(T2.Year AS int) > 1980;
SELECT DISTINCT t2.Model FROM cars_data AS t1 JOIN car_names AS t3 ON t1.Id = t3.MakeId JOIN model_list AS t2 ON t3.Model = t2.Model WHERE t1.Year > 1980
SELECT C.`Continent`, COUNT(DISTINCT M.`Maker`) as count FROM continents AS C JOIN countries AS CO ON C.`ContId` = CO.`Continent` JOIN car_makers AS M ON CO.`CountryId` = M.`Country` GROUP BY C.`Continent`
SELECT DISTINCT T1.`Continent`, COUNT(T3.`Id`) FROM continents AS T1 JOIN countries AS T2 ON T2.`Continent` = T1.`ContId` JOIN car_makers AS T3 ON T2.`CountryId` = T3.`CountryId` GROUP BY T1.`Continent`;
SELECT T1.`CountryName`, COUNT(T2.`Maker`) FROM countries AS T1 JOIN car_makers AS T2 ON T1.`Continent` = T2.`Country` GROUP BY T1.`CountryName` ORDER BY COUNT(*) DESC LIMIT 1;
SELECT c.`CountryName` FROM countries c JOIN car_makers cm ON c.CountryId = cm.Country GROUP BY c.CountryId ORDER BY COUNT(cm.Id) DESC LIMIT 1;
SELECT COUNT(model_list.ModelId), car_makers.FullName FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id GROUP BY car_makers.FullName;
-- What is the number of car models that are produced by each maker -- and what is the id and full name of each maker? SELECT T1.Id, T3.FullName, COUNT(T2.Model) AS ModelsCount FROM car_makers AS T1 JOIN model_list AS T2 ON T1.Id = T2.Maker JOIN car_makers AS T4 ON T2.Country = T4.Country GROUP BY T1.Id, T3.FullName ORDER BY ModelsCount DESC;
SELECT cds.Accelerate AS Accelerate_AMC_Hornet_Sportabout_SW FROM cars_data cds INNER JOIN car_names cn ON cds.MakeId = cn.MakeId INNER JOIN model_list ml ON cn.Model = ml.Model AND cn.Maker = ml.Maker AND cn.MakeId = ml.ModelId WHERE ml.Make = 'amc hornet sportabout (sw)' GROUP BY ml.Year ORDER BY ml.Year DESC;
SELECT CN.Make, CN.Model, CD.Accelerate FROM cars_data CD INNER JOIN car_names CN ON CD.Id = CN.MakeId WHERE CN.make = 'amc Hornet Sportabout (SW)'
SELECT COUNT(DISTINCT t2.Maker) FROM countries AS t1 JOIN car_makers AS t2 ON t1.CountryId = t2.Country WHERE t1.Continent = 'france';
SELECT COUNT(DISTINCT T1.Maker) FROM car_makers AS T1 JOIN countries AS T2 ON T1.Country = T2.CountryName WHERE T2.CountryName = 'france'
SELECT COUNT(*) FROM countries AS T1 JOIN car_makers AS T2 ON T1.CountryName = T2.Country JOIN model_list AS T3 ON T2.Id = T3.Maker WHERE T1.CountryName = 'usa'
SELECT COUNT(T5.Model) FROM continents AS T1 JOIN countries AS T2 ON T1.ContId = T2.Continent JOIN car_makers AS T3 ON T2.CountryId = T3.Country JOIN model_list AS T4 ON T3.Id = T4.Maker JOIN car_names AS T5 ON T4.Model = T5.Model WHERE T2.CountryName = 'usa'
SELECT AVG(MPG) FROM `cars_data` WHERE Cylinders = '4'
SELECT AVG(T1.`MPG`) FROM cars_data AS T1 JOIN car_names AS T2 ON T1.`Id` = T2.`MakeId` WHERE T1.`Cylinders` = 4
SELECT Min(T1.`Weight`) FROM cars_data AS T1 JOIN car_names AS T2 ON T1.Id = T2.MakeId WHERE T1.Cylinders = 8 AND T1.Year = 1974;
error: No SQL found in the input string
SELECT M.maker, ML.model FROM model_list AS ML JOIN car_makers AS M ON ML.Maker = M.Id;
SELECT C.Maker, M.Model FROM car_makers AS C LEFT JOIN model_list AS M ON C.Id = M.Maker LEFT JOIN car_names AS CN ON M.Model = CN.Model
SELECT countries.`CountryName`, countries.`CountryId` FROM countries INNER JOIN car_makers ON countries.`Continent` = (SELECT `ContId` FROM continents WHERE CONTINENT = countries.`Continent`) WHERE car_makers.`Country` IN (SELECT `Country` FROM car_makers GROUP BY `Country`)
SELECT CountryName, CountryId FROM countries WHERE CountryId IN (SELECT Country FROM car_makers)
SELECT COUNT(*) FROM cars_data WHERE Horsepower > 150
SELECT COUNT(*) FROM cars_data WHERE Horsepower > 150;
SELECT AVG(`Weight`) AS `Average Weight`, `Year` FROM cars_data GROUP BY `Year`
SELECT AVG(`Weight`) as avg_weight, `Year`, COUNT(*) as count FROM cars_data GROUP BY `Year`;
SELECT T2.`CountryName` FROM continents AS T1 JOIN countries AS T2 ON T1.`ContId` = T2.`Continent` JOIN car_makers AS T3 ON T2.`Continent` = T3.`Country` GROUP BY T2.`CountryName` HAVING COUNT(T3.`Maker`) >= 3
SELECT `CountryName` FROM countries WHERE `countryId` IN ( SELECT `countryid` FROM car_makers GROUP BY `country` HAVING COUNT(*) > 3 AND `continent` = 'europe' )
SELECT Max(Horsepower) AS Max_Horsepower, Make FROM car_names JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN cars_data ON car_names.MakeId = cars_data.Id WHERE Cylinders = 3 GROUP BY Make
error: No SQL found in the input string
SELECT MAX(Cylinders) FROM cars_data
-- Get the maximum value for mpg from cars_data table SELECT MAX(`MPG`) FROM cars_data;
SELECT AVG(Horsepower) FROM cars_data C1 JOIN car_names CN ON C1.Id = CN.MakeId WHERE Year < '1980'
SELECT AVG(Horsepower) FROM cars_data WHERE Year < '1980'
SELECT AVG(T4.Edispl) as AVG_EDISPL FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model JOIN car_makers AS T3 ON T2.Maker = T3.Id JOIN cars_data AS T4 ON T1.MakeId = T4.Id WHERE T3.FullName = 'Volvo';
select avg(edispl) as average_edispl from cars_data where year IN (select year from car_names join model_list on model_list.id = car_names.makeid where maker= 'volvo');
SELECT MAX(Edispl) as max_accelerate, Cylinders AS num_cylinders FROM cars_data GROUP BY Cylinders ORDER BY num_cylinders
SELECT MAX(`Accelerate`) FROM cars_data GROUP BY Cylinders;
SELECT T1.`Model`, COUNT(T2.`MakeId`) FROM model_list AS T1 JOIN car_names AS T2 ON T2.`Make` = T1.`Maker` GROUP BY T1.`Model` ORDER BY COUNT(*) DESC LIMIT 1;
SELECT T2.Maker, COUNT(*) FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model GROUP BY T2.Maker ORDER BY COUNT(*) DESC LIMIT 1;
SELECT COUNT(*) FROM cars_data WHERE Cylinders > 4
error: No SQL found in the input string
SELECT COUNT(T2.Model) AS CountOfCarsProduced FROM cars_data AS T1 JOIN car_names AS T2 ON T1.Id = T2.MakeId WHERE T1.Year = '1980'
SELECT COUNT(*) FROM cars_data AS T3 JOIN car_names AS T4 ON T3.`Id` = T4.`MakeId` JOIN model_list AS T5 ON T4.`Model` = T5.`Model` JOIN car_makers AS T6 ON T5.`Maker` = T6.`Id` WHERE CAST(T3.`Year` AS INTEGER) / 100 = 1980
SELECT COUNT(*) FROM car_makers AS T1 JOIN model_list AS T2 ON T2.Maker = T1.Id JOIN car_names AS T3 ON T3.MakeId = T2.ModelId WHERE T1.`FullName` = 'American Motor Company' AND T3.Model NOT IN ('AMC Matador','AMC Javelin')
SELECT COUNT(*) FROM car_makers AS T1 JOIN model_list AS T2 ON T1.`Id` = T2.Maker WHERE T1.Maker = 'american motor company'
SELECT T1.`FullName`, COUNT(*) AS `Count` FROM car_makers AS T1 JOIN model_list AS T2 ON T1.`Id` = T2.`Maker` WHERE T2.`Model` != 'None' GROUP BY T1.`Id` HAVING COUNT(*) > 3;
SELECT `Maker`, `Id` FROM car_makers GROUP BY `Maker`, `Id` HAVING COUNT(`Id`) > 3
SELECT DISTINCT T1.Model FROM car_names AS T1 INNER JOIN model_list AS T2 ON T1.MakeId = T2.ModelId INNER JOIN car_makers AS T3 ON T2.Maker = T3.Id WHERE T1.MakeId IN (SELECT MakeId FROM cars_data WHERE Weight > '3500') AND T3.Country IN (SELECT CountryId FROM countries WHERE Continent = 'America');
SELECT DISTINCT T4.Model FROM car_names AS T1 JOIN model_list AS T2 ON T2.Maker = T1.MakeId JOIN car_makers AS T3 ON T2.Id = T3.Id JOIN countries AS T4 ON T4.CountryId = T3.Country WHERE T3.FullName LIKE '%General Motors%' OR EXISTS ( SELECT 1 FROM cars_data ADS WHERE CAST(ADS.Weight AS REAL) > 3500 AND ADS.MakeId = T1.MakeId );
SELECT DISTINCT T6.`Year` FROM countries AS T1 JOIN car_makers AS T2 ON T1.`CountryId` = T2.`Country` JOIN model_list AS T3 ON T2.`Id` = T3.`Maker` JOIN car_names AS T4 ON T3.`Model` = T4.`Model` JOIN cars_data AS T5 ON T4.`MakeId` = T5.`Id` JOIN cars_data AS T6 -- Joining the `cars_data` table again for filtering conditions ON T5.`Id` = T6.`Id` WHERE CAST(CAST(T5.`Weight` AS REAL) AS TEXT) >= "3000" AND CAST(CAST(T5.`Weight` AS REAL) AS TEXT) <= "4000" ORDER BY T5.`Year`;
SELECT DISTINCT y FROM ( SELECT MAX(CASE WHEN Weight > 3000 THEN Year END) AS y, MIN(CASE WHEN Weight < 4000 THEN Year END) AS g FROM cars_data )
SELECT T3.Horsepower FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model JOIN cars_data AS T3 ON T1.MakeId = T3.Id ORDER BY T3.Accelerate DESC LIMIT 1;
SELECT MAX(Horsepower) FROM cars_data WHERE Accelerate IS NOT NULL
SELECT c.Cylinders FROM cars_data AS c JOIN car_names AS cn ON c.Id = cn.MakeId WHERE cn.Model LIKE '%volvo%' AND c.Accelerate = ( SELECT MIN( c2.Accelerate ) FROM cars_data AS c2 )
error: No SQL found in the input string
SELECT COUNT(*) FROM cars_data WHERE Accelerate > (SELECT MAX(Horsepower) FROM cars_data)
SELECT COUNT(*) FROM cars_data WHERE Accelerate > (SELECT MAX(Horsepower) FROM cars_data)
SELECT DISTINCT T1.`CountryName` FROM countries T1 JOIN car_makers T2 ON T1.`CountryId` = T2.`Country` JOIN (SELECT `Maker`, `Model` FROM `model_list`) AS M ON T2.`Id` = M.`Maker` GROUP BY T1.`CountryName` HAVING COUNT(DISTINCT M.`Maker`) > 2
SELECT COUNT(*) FROM ( SELECT DISTINCT C.`Continent` FROM countries AS C JOIN car_makers AS M ON C.CountryName = M.Country GROUP BY C.Continent ) AS T;
SELECT COUNT(*) FROM cars_data WHERE Cylinders > 6
SELECT COUNT(*) FROM cars_data WHERE CAST(CYLINDERS AS INTEGER) > 6;
SELECT T3.`Model`, T4.Horsepower FROM car_names AS T1 JOIN car_makers AS T2 ON T2.Id = T1.MakeId JOIN model_list AS T3 ON T2.Id = T3.Maker JOIN cars_data AS T4 ON T1.MakeId = T4.Id WHERE T4.Cylinders = 4 AND T4.Horsepower > 0 GROUP BY T3.Model;
SELECT model FROM ( SELECT cn.Model, MAX(c.Horsepower) AS max_horsepower FROM car_names AS cn JOIN cars_data AS c ON cn.MakeId = c.Id GROUP BY cn.Model ) WHERE max_horsepower = (SELECT MAX(horsepower) FROM cars_data WHERE cylinders = 4);
SELECT DISTINCT T1.`MakeId`, T4.`Make` FROM car_makers AS T1 JOIN model_list AS T2 ON T1.Id = T2.Maker JOIN ( -- Subquery to select models with more than 3 cylinders SELECT Model FROM model_list) as T5 ON T2.Model = T5.Model JOIN car_names AS T4 ON T5.Model = T4.Model -- Only needed columns are selected here JOIN cars_data AS T6 ON T1.Id = T4.MakeId -- To get horsepower from this table WHERE T5.Model NOT IN ( -- Model with less than or equal to 3 cylinders SELECT T7.Model FROM model_list AS T7) AND T6.Horsepower > (SELECT MIN(T8.Horsepower) FROM cars_data AS T8)
SELECT T1.Make, T3.MakerId FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model JOIN car_makers AS T3 ON T2.Maker = T3.Id JOIN cars_data AS T4 ON T1.MakeId = T4.Id WHERE T4.Horsepower != (SELECT MIN(T4.Horsepower) FROM car_names AS T1 JOIN model_list AS T2 ON T1.Model = T2.Model JOIN car_makers AS T3 ON T2.Maker = T3.Id JOIN cars_data AS T4 ON T3.Id = T4.Id) AND T4.Cylinders < 4;
SELECT MAX(MPG) FROM cars_data WHERE Cylinders = 8 OR Year < 1980;
SELECT MAX(C1.MPG) FROM cars_data AS C1 WHERE (C1.Year < '1980' OR C1.Cylinders <= 8)
SELECT DISTINCT c.Model FROM car_names AS cn JOIN model_list AS m ON cn.Model = m.Model JOIN model_list AS ml ON cn.MakeId = ml.ModelId -- use MakeId to link with ModelList JOIN car_makers AS cm ON ml.Maker = cm.Id -- use Maker column from ModelList to link with CarMakers JOIN countries ON cm.Country = countries.CountryId -- use Country column from CarMakers to join with Countries WHERE m.Edispl > 3500 AND countryName NOT IN (SELECT Fuller FROM car_makers WHERE LOWER(Fuller) LIKE 'ford motor company')
-- What are the different models wthat are lighter than 3500 but were not built by the Ford Motor Company? SELECT c.Maker, -- Correcting car maker info from Model list here instead of direct select on model_list directly because there is not necessary information like Weight, MPG available in this table, hence we use it for parent table join for other joins instead. ml.Model, cd.Weight FROM car_makers c -- Select Maker & full name details to perform country check from this table JOIN model_list ml ON c.Country = ml.Country # Joining the car_maker's country & correct model list id based on above maker info ON c.Id = ml.Id # Since in above select, we are using car_makers table maker information instead of model name JOIN cars_data cd ON m.ModelId = cd.Model # After having parent join, now perform child table joins for other needed data WHERE c.Country != 'Ford Motor Company' AND cd.Weight < 3500;
SELECT c.`Continent`, c1.`CountryName` FROM continents AS C JOIN countries AS c1 ON C.`ContId` = c1.`Continent` WHERE c1.`CountryId` NOT IN ( SELECT T2.`Country` FROM car_makers AS T2 WHERE T2.`Country` IS NOT NULL );
SELECT c.CountryName FROM countries c WHERE c.CountryId NOT IN ( SELECT cm.`Country` FROM car_makers cm )
-- Which are the car makers which produce at least 2 models -- and more than 3 car makers ? List the id and the maker . SELECT T1.Id, T1.Maker AS Maker FROM car_makers AS T1 JOIN ( SELECT ML.Maker, COUNT(*) Total FROM model_list AS ML JOIN car_makers AS C ON ML.Maker = C.Id GROUP BY ML.Maker ) AS T2 ON T1.Id = T2.Maker WHERE Total > 3 AND Total >= 2;
WITH table_cars_data_simplified AS ( SELECT T2.CountryId AS country_id , T1.Maker, M.Id, COUNT(T3.Model) As count FROM model_list AS M JOIN car_makers AS T1 ON M.Maker = T1.Id JOIN countries AS T2 ON T2.CountryId = T1.Country JOIN cars_data AS s On M.id = S.Makes_id GROUP BY T2.CountryId, T1.Maker , M.id HAVING COUNT(T3.Model) > 1 AND SUM(s MPG_sums) > 3 -- use SUM instead of Min. and replace NULL with is not ) SELECT id, maker FROM table_cars_data_simplified Where count > 2 ;
-- What are the id and names of the countries which have more than 3 car makers or produce the 'fiat' model? SELECT c.`CountryId`, c.`CountryName` FROM countries AS c JOIN continents cc ON c.`Continent` = cc.`ContId` JOIN car_makers cm ON c.`CountryId` = cm.`Country` WHERE (SELECT COUNT(*) FROM model_list m JOIN car_names cn ON m.`Maker` = cn.`MakeId` WHERE cn.`Model` = 'fiat') > 0 OR EXISTS ( SELECT * FROM car_makers cm2 JOIN countries c2 ON cm2.`Country` = c2.`CountryId` WHERE c2.`Continent` = c.`Continent`) GROUP BY c.`CountryName`, c.`CountryId`;
SELECT DISTINCT T1.CountryName FROM countries AS T1 JOIN (SELECT T2.CountryId FROM countries AS T2 JOIN car_makers AS T3 ON T2.CountryId = T3.Country JOIN model_list AS T4 ON T3.Id = T4.Maker JOIN car_names AS T5 ON T4.Model = T5.Model WHERE T5.Make LIKE '%Fiat%' OR (SELECT COUNT(T6.Maker) FROM car_makers AS T6 WHERE T2.CountryId = T6.Country) > 3) AS T3 ON T1.CountryId = T3.CountryId
SELECT Country FROM airlines WHERE Airline = 'JetBlue Airways'
SELECT Country FROM airlines WHERE Airline = 'JetBlue Airways'
SELECT `Abbreviation` FROM airlines WHERE `Airline` = 'JetBlue Airways'
SELECT `Abbreviation` FROM airlines WHERE `Airline` = 'JetBlue Airways'
SELECT `Airline`, `Abbreviation` FROM airlines WHERE `Country` = 'USA'
+---------------------+--------------+ | Airline | UniqueAirports | +---------------------+--------------+ | Virgin America | Albany Ardmore | | Southwest | Anchorage Athens | | JetBlue Airways | Anniston Anderson | | United Airlines | Alb USAir USArmy| +---------------------+--------------+
SELECT AirportCode, AirportName FROM airports WHERE City = 'Anthony'
SELECT AirportCode, AirportName FROM airports WHERE City = 'Anthony'
SELECT COUNT(uid) FROM airlines;
SELECT COUNT(*) FROM airlines;
SELECT COUNT(*) from airports;
SELECT COUNT(*) FROM airports
error: No SQL found in the input string
SELECT COUNT(*) FROM flights
error: No SQL found in the input string
SELECT Airline FROM airlines WHERE Abbreviation = 'UAL'
-- How many airlines are from USA? SELECT COUNT(*) FROM airlines WHERE Country = 'USA'
SELECT COUNT(*) FROM airlines WHERE Country = 'USA'
error: No SQL found in the input string
SELECT `City`, `Country` FROM airports WHERE `AirportName` = 'Alton'
-- Fix for finding airport name for airport 'AKO' SELECT airports.`AirportName` FROM airports WHERE airports.`AirportCode` = 'AKO'
SELECT `AirportName` FROM airports WHERE AirportCode = 'AKO'
SELECT T1.`AirportName` FROM airports AS T1 JOIN airlines AS T2 ON T1.`City` = T2.Airline WHERE T1.`City` = 'Aberdeen'
SELECT AirportName FROM airports WHERE City like '%Aberdeen%'
SELECT COUNT(*) FROM flights WHERE SourceAirport = 'APG'
SELECT COUNT(*) FROM flights WHERE SourceAirport = 'APG'
SELECT COUNT(*) FROM flights WHERE DestAirport = 'ATO'
SELECT COUNT(*) FROM flights JOIN airports ON destairport=airportcode WHERE airportname='Atlanta'
SELECT COUNT(DISTINCT DestAirport) FROM flights AS T1 INNER JOIN airports AS T2 ON T1.SourceAirport = T2.AirportCode WHERE T2.City = 'Aberdeen';
SELECT COUNT(*) FROM flights WHERE SourceAirport IN ( SELECT AirportCode FROM airports WHERE City = 'Aberdeen' )
SELECT COUNT(*) FROM flights AS T1 JOIN airports AS T2 ON T1.DestAirport = T2.AirportCode WHERE T2.City = 'Aberdeen'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.City = 'Aberdeen'
SELECT COUNT(*) FROM flights JOIN airports AS src ON flights.SourceAirport = src.AirportCode JOIN airports AS dest ON flights.DestAirport = dest.AirportCode WHERE src.City = 'Aberdeen' AND dest.City = 'Ashley';
SELECT COUNT(*) FROM flights WHERE SourceAirport = 'ABE' AND DestAirport = (SELECT AirportCode FROM airports WHERE City = 'Ashley');
-- How many flights does airline 'JetBlue Airways' have? SELECT COUNT(T2.SourceAirport) FROM airlines AS T1 JOIN flights AS T2 ON T1.`Airline` = T2.`Airline` WHERE T1.`Airline` = 'JetBlue Airways'
SELECT COUNT(*) FROM flights WHERE Airline IN (SELECT `Airline` FROM airlines WHERE Abbreviation = 'JetBlue')
SELECT COUNT(*) FROM flights AS T1 JOIN airlines AS T2 ON T1.`Airline` = T2.uid WHERE T2.`Airline` = 'United Airlines' AND T1.DestAirport = 'ASY'
SELECT COUNT(*) FROM flights WHERE Airline = 'United Airlines' AND DestAirport = 'ASY'
SELECT COUNT(*) FROM flights AS T1 JOIN airlines AS T2 ON T2.uid = T1.Airline WHERE T1.Airline = 'United Airlines' AND (T1.SourceAirport = 'AHD' OR T1.DestAirport = 'AHD')
SELECT COUNT(*) FROM flights AS T1 JOIN airports AS T2 ON T1.`DestAirport` = T2.`AirportCode` WHERE Airline = 'United Airlines' AND T1.SourceAirport IS NULL;
SELECT COUNT(*) FROM flights AS T1 JOIN airlines AS T2 ON T1.`Airline` = T2.uid JOIN airports AS T3 ON T3.`AirportCode` = T1.`DestAirport` WHERE T2.`Airline` = 'United Airlines' AND T3.`City` = 'Aberdeen'
SELECT COUNT(*) FROM flights AS T1 JOIN airlines AS T2 ON T1.`Airline` = T2.`Abbreviation` WHERE T1.`DestAirport`='ABZ' AND T2.`Airline`='United'
SELECT City, COUNT(Airline) FROM airports AS T1 JOIN flights AS T2 ON T1.AirportCode = T2.DestAirport GROUP BY City ORDER BY COUNT(Airline) DESC LIMIT 1;
SELECT City, COUNT(DISTINCT DestAirport) AS freq FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport OR airports.AirportCode = flights.DestAirport GROUP BY City ORDER BY freq DESC LIMIT 1;
SELECT A.`City`, COUNT(*) as 'total_flight_departing' FROM airports AS A JOIN flights AS F ON F.SourceAirport = A.AirportCode GROUP BY A.`City` HAVING COUNT(*) > 1
SELECT SourceAirport, COUNT(*) AS Frequency FROM flights GROUP BY SourceAirport ORDER BY Frequency DESC LIMIT 1;
SELECT A.`AirportCode` FROM airports AS A join flights AS F ON (A.`AirportCode` = F.`SourceAirport`) OR (A.`AirportCode` = F.`DestAirport`) GROUP BY A.`AirportCode` ORDER BY COUNT(A.`AirportCode`) DESC LIMIT 1;
SELECT T2.`AirportCode`, COUNT(T1.`FlightNo`) FROM flights AS T1 JOIN airports AS T2 ON T2.`AirportCode` = T1.`SourceAirport` GROUP BY T2.`AirportCode` ORDER BY COUNT(T2.`AirportCode`) DESC LIMIT 1
SELECT DestAirport FROM flights GROUP BY DestAirport ORDER BY COUNT(*) ASC LIMIT 1;
SELECT AirportCode, COUNT(*) AS FlightCount FROM airports JOIN flights ON airports.AirportCode = flights.SourceAirport OR airports.AirportCode = flights.DestAirport GROUP BY AirportCode ORDER BY FlightCount LIMIT 1
SELECT T1.Airline, COUNT(*) AS NumFlights FROM airlines AS T1 INNER JOIN flights AS T2 ON T2.Airline = T1.uid GROUP BY T1.Airline ORDER BY NumFlights DESC LIMIT 1;
SELECT `Airline`, COUNT(*) FROM flights GROUP BY `Airline` ORDER BY COUNT(`Airline`) DESC LIMIT 1
SELECT T1.Abbreviation, T1.Country FROM airlines AS T1 JOIN flights AS T2 ON T1.uid = T2.Airline GROUP BY T1.uid ORDER BY COUNT(T2.FlightNo) ASC LIMIT 1;
SELECT-type: sql SELECT A.`Abbreviation`, A.`Country` FROM airlines AS A WHERE ( SELECT COUNT(*) AS FlightCount FROM flights WHERE flights.SourceAirport = airports.AirportCode AND airports.CountryAbbrev = 'US' GROUP BY flights.Airline ) = ( SELECT MIN(FlightCount) FROM (SELECT Airline, COUNT(*) AS FlightCount FROM flights WHERE SourceAirport = AirportCode AND CountryAbbrev = 'US' GROUP BY Airline) )
SELECT DISTINCT T2.`Airline` FROM airports AS T1 JOIN flights AS T2 ON T1.`AirportCode` = T2.`SourceAirport` WHERE T1.`City`='Anchorage'
SELECT DISTINCT Airline FROM flights WHERE SourceAirport IN (SELECT AirportCode FROM airports WHERE City = 'Anchorage')
SELECT distinct Airline FROM flights WHERE DestAirport = (SELECT AirportCode FROM airports WHERE City = 'Anchorage')
SELECT T2.`Airline` FROM airports AS T1 JOIN flights AS T2 ON T1.`AirportCode` = T2.`DestAirport` WHERE T2.`DestAirport` = 'AHD'
SELECT airline FROM ( SELECT DISTINCT Airline FROM flights f1 WHERE f1.SourceAirport IN ('APG', 'CVO') OR f1.DestAirport IN ('APG', 'CVO') ) AS T1 WHERE ( SELECT COUNT(*) FROM flights f2 WHERE f2.Airline = T1.airline AND f2.sourceairport IN('APG','CVO') ) = (SELECT COUNT(*) FROM flights f3 WHERE f3.Airline = T1.airline And f3.destairport in('APG','CVO'))
SELECT T1.Airline FROM airlines AS T1 JOIN flights AS T2 ON T1.uid = T2.Airline GROUP BY T2.SourceAirport, T2.DestAirport HAVING T2.SourceAirport IN (SELECT AirportCode FROM airports WHERE AirportName = 'Will Rogers Fld APG') AND T2.DestAirport IN (SELECT AirportCode FROM airports WHERE AirportName = 'Mc Cleary/Carlson SP CVO')
SELECT DISTINCT Airline, COUNT(DestAirport) AS NumFlights FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode WHERE flights.DestAirport = 'CVO' AND airports.City != 'APG' GROUP BY Airline;
-- Exclude APG carriers. SELECT DISTINCT Airline FROM flights WHERE SourceAirport= 'CVO' EXCEPT SELECT DISTINCT Airline FROM flights WHERE DestAirport='APG';
SELECT T1.Airline -- fix ambiguous columns by prefixing table aliases with their alias FROM airlines AS T1 JOIN flights AS T2 ON T1.Abbreviation = T2.Airline GROUP BY T1.Abbreviation HAVING COUNT(T1.Abbreviation) >= 10
SELECT Airline FROM flights GROUP BY Airline HAVING COUNT(*) >= 10
SELECT T2.Airline, T2.FlightNo FROM airlines AS T1 JOIN flights AS T2 ON T1.uid = ( SELECT DISTINCT SourceAirport FROM flights WHERE flights.SourceAirport IN ( SELECT AirportCode FROM airports ) ) WHERE T2.Airline IN ( SELECT Airline FROM airlines GROUP BY Airline HAVING COUNT( * ) < 200 )
SELECT Airline FROM ( SELECT Airline, COUNT(*) as num_flights FROM flights GROUP BY Airline ) WHERE num_flights < 200;
SELECT FlightNo FROM flights WHERE Airline = 'United Airlines'
SELECT `FlightNo` FROM flights WHERE Airline = 'United'
SELECT FlightNo FROM flights AS T1 WHERE SourceAirport = ( SELECT AirportCode FROM airports WHERE City = 'Albany') ;
SELECT `FlightNo`, `Airline` FROM flights WHERE `DestAirport` = (SELECT `AirportCode` FROM airports WHERE `City` = 'Anniston')
SELECT DISTINCT FlightNo FROM flights WHERE DestAirport = 'APG'
SELECT DISTINCT Airline, FlightNo FROM flights WHERE DestAirport = 'APG'
SELECT FlightNo FROM flights WHERE DestAirport = (SELECT AirportCode FROM airports WHERE City = 'Aberdeen' AND CountryAbbrev = 'US')
SELECT FlightNo FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE City = 'Aberdeen'
SELECT FlightNo FROM flights WHERE DestAirport IN (SELECT AirportCode FROM airports WHERE City = 'Aberdeen')
SELECT DISTINCT T2.`FlightNo` FROM airports AS T1 JOIN flights AS T2 ON T1.`CountryAbbrev` = 'US' AND T2.`DestAirport` = 'ABZ'
SELECT COUNT(*) FROM flights AS T1 JOIN airports AS T2 ON T1.DestAirport = T2.AirportCode WHERE T2.City IN ('Aberdeen', 'Abilene')
SELECT COUNT(*) FROM flights AS T1 JOIN airports AS T2 ON T1.DestAirport = T2.AirportCode WHERE T2.City IN('Aberdeen', 'Abilene')
-- Script type: SQLite SELECT T1.`AirportName` FROM airports AS T1 WHERE T1.`AirportCode` NOT IN ( SELECT SourceAirport FROM flights UNION SELECT DestAirport FROM flights );
-- Which airports do not have departing or arriving flights? SELECT DISTINCT a1.`AirportName` FROM airports a1 WHERE ( SELECT COUNT(*) FROM flights f1 WHERE f1.`DestAirport` = a1.`AirportCode` ) = 0 AND ( SELECT COUNT(*) FROM flights f2 WHERE f2.`SourceAirport` = a1.`AirportCode` ) = 0;
SELECT COUNT(*) FROM employee
SELECT COUNT(employee_id) AS total_employees from employee;
SELECT Name FROM employee ORDER BY Age ASC;
SELECT Name FROM employee ORDER BY Age ASC;
SELECT `City`, COUNT(*) AS Number_of_Employees FROM employee GROUP BY `City` ORDER BY Number_of_Employees DESC;
SELECT City, COUNT(*) FROM employee GROUP BY City;
SELECT City AS `City` FROM employee WHERE Age <= 30 GROUP BY City HAVING COUNT(DISTINCT Employee_ID) > 1
SELECT City FROM employee AS T1 WHERE Age < 30 GROUP BY City HAVING COUNT(DISTINCT Employee_ID) > 1;
SELECT T1.`Location`, COUNT(*) FROM shop AS T1 LEFT JOIN employee AS T2 ON T1.Name = T2.City GROUP BY T1.Location
SELECT Location, COUNT(*) as count FROM shop GROUP BY Location ORDER BY count DESC;
SELECT S.Manager_name FROM ( SELECT shop_id , Number_products, max(Number_products) as max_prod FROM shop GROUP BY district ) T2 JOIN employee t AS t3 ON t.Employee_ID=T2.Shop_id AND t.Age=32
SELECT e.Name, s.District as District FROM employee AS e JOIN hiring AS h ON e.Employee_ID = h.Employee_ID WHERE h.Shop_ID = (SELECT Shop_ID FROM shop ORDER BY Number_products DESC LIMIT 1) GROUP BY e.Name ORDER BY COUNT(*) DESC LIMIT 1;
SELECT MIN(`Number_products`) AS Min_number, MAX(`Number_products`) AS Max_number FROM shop
SELECT MIN(Number_products), MAX(Number_products) FROM shop;
SELECT sh.`Name`, sh.`Location`, sh.`District`, emp.`Name` AS Employee_Name FROM shop AS sh JOIN hiring AS hi ON sh.Shop_ID = hi.Shop_ID JOIN employee AS emp ON emp.Employee_ID = hi.Employee_ID ORDER BY sh.Number_products DESC;
SELECT S.`Name`, S.Location, S.District FROM shop AS S ORDER BY Number_products DESC;
SELECT `Name` FROM shop WHERE `Number_products` > (SELECT AVG(`Number_products`) FROM shop)
WITH AverageProducts AS ( SELECT AVG(Number_products) AS Average FROM shop ) SELECT Name FROM shop WHERE Number_products > (SELECT Average FROM AverageProducts);
SELECT T1.`Name` FROM employee AS T1 JOIN evaluation AS T2 ON T2.`Employee_ID` = T1.`Employee_ID` GROUP BY T1.`Employee_ID` ORDER BY COUNT(T1.`Employee_ID`) DESC LIMIT 1
SELECT Name FROM employee WHERE Employee_ID IN ( SELECT Employee_ID FROM evaluation GROUP BY Employee_ID HAVING COUNT(*) = ( SELECT MAX(count) FROM ( SELECT COUNT(*) as count FROM evaluation GROUP BY Employee_ID ) AS T1 ) )
SELECT Name FROM ( SELECT e.`Name`, eb_bonus.Bonus FROM evaluation eb_bonuses JOIN employee e ON eb_bonuses.Employee_ID = e.Employee_ID);
SELECT T1.Name FROM employee AS T1 JOIN evaluation AS T2 ON T1.Employee_ID = T2.Employee_ID WHERE T2.Bonus = ( SELECT MAX(Bonus) FROM evaluation )
SELECT `Name` FROM employee WHERE Employee_ID NOT IN (SELECT Employee_ID FROM evaluation)
SELECT `Name` FROM employee WHERE Employee_ID NOT IN (SELECT Employee_ID FROM evaluation)
SELECT T2.`Name` FROM shop AS T2 JOIN hiring AS T1 ON T2.Shop_ID = T1.Shop_ID GROUP BY T2.Shop_ID ORDER BY COUNT(T2.Shop_ID) DESC LIMIT 1;
SELECT s.name AS name FROM ( SELECT S.Name, H.Shop_ID, COUNT(H.Employee_ID) AS num_of_employees, DENSE_RANK() OVER(PARTITION BY h.Shop_ID ORDER BY COUNT(h.Employee_ID) DESC) ranknum FROM shop AS S JOIN hiring AS H ON S.Shop_ID = H.Shop_ID GROUP BY S.Name, H.Shop_ID ) t WHERE ranknum = 1;
error: No SQL found in the input string
SELECT S.`Name` FROM shop AS S FULL OUTER JOIN hiring AS H ON S.`Shop_ID` = H.`Shop_ID` WHERE S.`Shop_ID` IS NULL OR H.`Employee_ID` IS NULL;
SELECT T1.Name, COUNT(T3.Employee_ID) FROM shop AS T1 JOIN hiring AS T2 ON T1.Shop_ID = T2.Shop_ID JOIN employee AS T3 ON T2.Employee_ID = T3.Employee_ID GROUP BY T1.Name;
SELECT S.Name ,MAX(H.Employee_ID) FROM shop AS S LEFT JOIN hiring AS H ON S.Shop_ID = H.Shop_ID GROUP BY S.Shop_ID;
SELECT SUM(`Bonus`) FROM `evaluation`
SELECT CAST(SUM(T1.`Bonus`) AS REAL) FROM evaluation AS T1
SELECT * FROM hiring;
SELECT `Shop_ID`, `Employee_ID`, `Start_from`, `Is_full_time` FROM hiring;
WITH Subquery AS ( SELECT DISTINCT Shop_ID FROM shop WHERE Number_products < 3000 INTERSECT SELECT DISTINCT Shop_ID FROM shop WHERE Number_products > 10000 ) SELECT d.District FROM Subquery si JOIN shop s ON si.Shop_ID = s.Shop_ID JOIN shop d ON d.Shop_ID IN (SELECT Shop_ID FROM Subquery) -- Removed the GROUP BY since we're only looking for distinct districts
SELECT T1.`District` FROM shop AS T1 JOIN shop AS T2 ON T1.Shop_ID = T2.Shop_ID WHERE (T1.Number_products < 3000 AND T2.Number_products > 10000)
SELECT COUNT(DISTINCT Location) FROM shop
SELECT COUNT(DISTINCT Location) FROM shop
SELECT COUNT(*) FROM Documents;
SELECT COUNT(*) FROM Documents;
SELECT Document_ID, Document_Name, Document_Description FROM Documents;
SELECT Document_ID, Document_Name, Document_Description FROM Documents
SELECT `Document_Name`, `Template_ID` FROM Documents WHERE `Document_Description` LIKE '%w%'
SELECT `Document_Name`, `Template_ID` FROM Documents WHERE `Document_Description` LIKE '%w%'
SELECT Documents.Document_ID, Templates.Template_ID, Template_Type_Description FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code WHERE Document_Name = 'Robbin CV'
SELECT DISTINCT Documents.`Document_ID`, Templates.`Template_ID`, Ref_Template_Types.`Template_Type_Description` FROM Documents JOIN Templates ON Documents.`Template_ID` = Templates.`Template_ID` JOIN Ref_Template_Types ON Templates.`Template_Type_Code` = Ref_Template_Types.`Template_Type_Code` WHERE Documents.`Document_Name` = 'Robbin CV' ORDER BY Documents.`Document_ID`;
SELECT COUNT(DISTINCT a.`Template_Type_Code`) FROM ( SELECT DISTINCT T2.`Template-Type_Code`, MAX(T5.Date_Effective_To) as max_date FROM Templates AS T2 LEFT JOIN Documents AS T3 ON T3.Template_ID = T2._ID -- Removed dot from Template_ID LEFT JOIN ( SELECT MAX(T5.Date_Effective_To) as max_date FROM Templates AS T4 LEFT JOIN Documents AS T6 ON T4.`Template.ID`=T6._ID -- Removed dot for Template_ID GROUP BY `Template_ID` ) AS T4 ON T2.Template_ID = ('.T4._ID) WHERE ( SELECT ISNULL(T5.Date_Effective_To, DATEFROMPARTS(YEAR(GETDATE()), 1, 1)) MAX_DATE > MIN(T6.date_effective_to) GROUP BY Template_ID GROUP BY t4._ID , GROUP BY Date_Effective_To LEFT JOIN Ref_Template_Types AS T1 ON a.`Template-type-Code`=T1.`Template_type_code` FROM Templates AS T2 GROUP BY `Template_TYPE_CODE`
SELECT COUNT(DISTINCT `Template_ID`) FROM Documents;
SELECT COUNT(*) FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code = 'PPT'
SELECT COUNT(*) FROM Templates AS T1 JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T2.`Template_Type_Description` = 'Presentation'
SELECT T1.`Template_ID`, COUNT(T2.`Document_ID`) FROM Templates AS T1 JOIN Documents AS T2 ON T1.`Template_ID` = T2.`Template_ID` GROUP BY T1.`Template_ID`
SELECT T1.`Template_ID`, COUNT(*) as Count, T2.`Template_Type_Description` FROM Templates AS T1 JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` JOIN Documents AS T3 ON T1.`Template_ID` = T3.`Template_ID` GROUP BY T1.`Template_ID`, T2.`Template_Type_Description` ORDER BY T1.`Template_ID`;
SELECT T1.`Template_Type_Code`, COUNT(T3.`Document_ID`) FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` JOIN Documents AS T3 ON T2.`Template_ID` = T3.`Template_ID` GROUP BY T1.`Template_Type_Code` ORDER BY COUNT(T3.`Document_ID`) DESC
SELECT t.`Template_ID`, rtt.`Template_Type_Description` FROM Templates t INNER JOIN Ref_Template_Types rtt ON t.`Template_Type_Code` = rtt.`Template_Type_Code` GROUP BY t.`Template_ID`, rtt.`Template_Type_Description` ORDER BY (SELECT COUNT(DISTINCT d.`Document_ID`) FROM Documents d WHERE d.`Template_ID` = t.`Template_ID`) DESC;
SELECT DISTINCT T2.Template_ID FROM Templates AS T1 JOIN Documents AS T2 ON T1.Template_ID = T2.Template_ID GROUP BY T2.Template_ID HAVING COUNT(T2.Document_ID) > 1
SELECT DISTINCT T1.`Template_ID` FROM Templates AS T1 JOIN Documents AS T2 ON T1.`Template_ID` = T2.`Template_ID` WHERE T1.`Template_ID` IN ( SELECT T1.`Template_ID` FROM (SELECT T1.* FROM Templates AS T1) AS T GROUP BY T.`Template_ID` HAVING COUNT(*) > 1 )
SELECT `Template_ID` FROM Templates WHERE `Template_ID` NOT IN ( SELECT `Template_ID` FROM Documents)
SELECT T1.Template_ID FROM Templates AS T1 WHERE T1.Template_ID NOT IN (SELECT Template_ID FROM Documents) -- fixed incorrect join condition and provided correct solution
SELECT COUNT(*) FROM Templates
SELECT COUNT(*) FROM Templates;
SELECT T1.Template_ID, T1.Version_Number, T2.Template_Type_Description FROM Templates AS T1 JOIN Ref_Template_Types AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code
SELECT Templates.`Template_ID`, Templates.`Version_Number`, Ref_Template_Types.`Template_Type_Description` FROM Templates JOIN Ref_Template_Types ON Templates.`Template_Type_Code` = Ref_Template_Types.`Template_Type_Code`
-- Show all distinct template type codes for all templates. SELECT DISTINCT TT.`Template_Type_Code`, TT.`Template_Type_Description` FROM Ref_Template_Types AS TT;
SELECT DISTINCT `Template_Type_Code` FROM Ref_Template_Types;
SELECT `Template_ID` FROM Templates WHERE Template_Type_Code IN ('PP', 'PPT')
SELECT Template_ID FROM Templates WHERE Template_Type_Code IN ('PP', 'PPT')
SELECT COUNT(*) FROM Templates AS T1 JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T2.template_type_description LIKE '%CV%'
SELECT COUNT(T2.`Template_Type_Code`) FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T1.`Template_Type_Description` = 'CV'
SELECT `Version_Number`, `Template_Type_Description` FROM Templates AS T1 JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T1.`Version_Number` > 5;
SELECT Templates.`Version_Number`, Ref_Template_Types.`Template_Type_Description` FROM Templates JOIN Ref_Template_Types ON Templates.`Template_Type_Code` = Ref_Template_Types.`Template_Type_Code` WHERE Templates.`Version_Number` > 5;
SELECT Ref_Template_Types.Template_Type_Code, COUNT(Templates.Template_ID) AS num_templates FROM Templates JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code;
SELECT Ref_Template_Types.Template_Type_Code AS Template_Type, COUNT(Templates.Template_ID) AS Num_Templates FROM Ref_Template_Types JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code
SELECT T1.Template_Type_Description FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T2.`Template_Type_Code` = T1.`Template_Type_Code` GROUP BY T1.Template_Type_Description HAVING MAX(T2.TEMPLATE_ID) = ( SELECT MAX(template_id) FROM templates t3 WHERE template_id IS NOT NULL GROUP BY t3.`Template_Type_Code` )
-- Return the type code of the template type that the most templates belong to. SELECT T1.Template_Type_Code FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code GROUP BY T1.Template_Type_Code ORDER BY COUNT(T2.Template_ID) DESC LIMIT 1;
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Code IN ( SELECT T1.`Template_Type_Code` FROM Templates AS T1 INNER JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` GROUP BY T1.`Template_Type_Code` HAVING COUNT(T1.Template_ID) < 3 )
SELECT RT.`Template_Type_Code` FROM Ref_Template_Types AS RT JOIN ( SELECT DISTINCT TTM.Template_type_code FROM Templates AS TTM GROUP BY TTM.Template_type_code HAVING COUNT(TTM.Template_ID) < 3 ) AS T ON RT.`Template_Type_Code` = T.`Template_type_code`
SELECT T1.`Version_Number`, T2.`Template_Type_Description` FROM `Templates` AS T1 JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` GROUP BY T1.`Template_ID` ORDER BY T1.`Version_Number` LIMIT 1;
SELECT T1.`Version_Number`, T2.`Template_Type_Description` FROM Templates AS T1 JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` ORDER BY T1.`Version_Number` ASC LIMIT 1
SELECT T3.`Template_Type_Code` FROM Templates AS T2 JOIN Ref_Template_Types AS T3 ON T2.`Template_Type_Code` = T3.`Template_Type_Code` -- select document id which contain 'Data' and has more documents associated with it JOIN ( SELECT `Document_ID`, COUNT(*) as doc_count FROM Documents GROUP BY `Document_ID`) AS D ON T2.`Template_ID` = (SELECT `Template_ID` FROM Documents WHERE `Document_Name` LIKE '%data%' AND `Document_ID` IN (SELECT `Document_ID` FROM Documents GROUP BY `Document_ID`) AND `Date_Effective_From` <= '2015-09-06 01:08:44' AND `Date_Effective_To` >= '2012-04-05 07:11:42') AND D.doc_count > 0 WHERE T3.`Template_Type_Description` = 'Data base'
-- Return the template type code of the template that is used by a document named Data base. SELECT T3.Template_Type_Code FROM Documents AS T1 JOIN Templates AS T2 ON T1.Template_ID = T2.Template_ID JOIN Ref_Template_Types AS T3 ON T2.Template_Type_Code= T3.Template_Type_Code WHERE T1.Document_Name = 'Data base'
SELECT `Document_Name` FROM Documents WHERE `Template_ID` IN (SELECT `Template_ID` FROM Templates WHERE `Template_Type_Code` = 'BK')
-- CORRECTED SQL (FINAL) SELECT d.Document_Name FROM Documents AS d JOIN Templates AS t ON d.Template_ID = t.Template_ID JOIN Ref_Template_Types AS tt ON t.Template_Type_Code = tt.Template_Type_Code WHERE tt.`Template_Type_Description` = 'Book'
SELECT T1.`Template_Type_Code`, COUNT(T3.`Document_Name`) FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` JOIN Documents AS T3 ON T2.`Template_ID` = T3.`Template_ID` GROUP BY T1.`Template_Type_Code`
SELECT RTT.`Template_Type_Code`, COUNT(DISTINCT D.`Document_ID`) FROM Ref_Template_Types AS RTT JOIN Templates AS T ON RTT.`Template_Type_Code` = T.`Template_Type_Code` JOIN Documents AS D ON T.`Template_ID` = D.`Template_ID` GROUP BY RTT.`Template_Type_Code`
SELECT T.`Template_Type_Code` FROM Ref_Template_Types AS T JOIN ( SELECT Template_Type_Code, COUNT(DISTINCT Documents.Document_ID) as Document_cnt FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID GROUP BY Template_Type_Code ) AS TT ON T.`Template_Type_Code` = TT.`Template_Type_Code` -- WHERE <column> is NOT NULL better? WHERE TT.Document_cnt = ( SELECT MAX(Document_cnt) FROM ( SELECT COUNT(DISTINCT Document_ID) as `Document_cnt` FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID GROUP BY Template_Type_Code )T ) ORDER BY T.`Template_Type_Code` LIMIT 1;
-- STEP 1: Analyze template type code usage SELECT RTT.Template_Type_Description, COUNT(TM.Template_ID) AS template_usage_count FROM Ref_Template_Types RTT JOIN Templates TM ON RTT.Template_Type_Code = TM.Template_Type_Code GROUP BY RTT.Template_Type_Description ORDER BY template_usage_count DESC LIMIT 1;
SELECT * FROM Ref_Template_Types AS T1 WHERE Template_Type_Code NOT IN ( SELECT `Template_ID` FROM Documents )
SELECT `Template_Type_Description` FROM Ref_Template_Types WHERE Template_Type_Code NOT IN ( SELECT DISTINCT T3.Template_Type_Code FROM Templates AS T3 JOIN Documents AS T4 ON T3.Template_ID=T4.Template_ID )
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types;
-- Run the script on our database SELECT T1.`Template_Type_Description` FROM Ref_Template_Types AS T1 WHERE T1.`Template_Type_Code` = 'AD';
SELECT T1.`Template_Type_Description` FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T1.`Template_Type_Code` = 'AD'
SELECT `Template_Type_Code` FROM Ref_Template_Types WHERE `Template_Type_Description` = 'Book'
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Book'
SELECT DISTINCT T1.`Template_Type_Description` FROM Ref_Template_Types AS T1 JOIN Templates AS T2 ON T2.`Template_Type_Code` = T1.`Template_Type_Code` JOIN Documents AS T3 ON T2.`Template_ID` = T3.`Template_ID`
SELECT DISTINCT T2.`Template_Type_Description` FROM Templates AS T1 INNER JOIN Ref_Template_Types AS T2 ON T1.`Template_Type_Code` = T2.`Template_Type_Code` WHERE T1.`Template_ID` IN ( SELECT `Template_ID` FROM Documents INNER JOIN Paragraphs ON Documents.`Document_ID` = Paragraphs.`Document_ID`)
SELECT `Template_ID` FROM Templates JOIN Ref_Template_Types ON Templates.`Template_Type_Code` = Ref_Template_Types.`Template_Type_Code` WHERE Ref_Template_Types.`Template_Type_Description` = 'Presentation'
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Presentation'
SELECT COUNT(*) AS Total_Paragraphs FROM Paragraphs JOIN Documents ON Paragraphs.Document_ID = Documents.Document_ID JOIN Templates ON Documents.Template_ID = Templates.Template_ID
error: No SQL found in the input string
SELECT COUNT(*) FROM Paragraphs WHERE Document_ID = ( SELECT Document_ID FROM Documents WHERE Document_Name = 'Summer Show' )
SELECT COUNT(*) FROM Paragraphs WHERE Document_ID = (SELECT Document_ID FROM Documents WHERE Document_Name = 'Summer Show')
SELECT T1.`Paragraph_Text`, T2.`Other_Details` FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.`Document_ID` = T2.`Document_ID` WHERE T1.`Paragraph_Text` LIKE '%Korea %'
SELECT T1.`Template_Details` FROM Paragraphs AS T3 JOIN Documents AS T2 ON T3.`Document_ID` = T2.`Document_ID` JOIN Templates AS T1 ON T2.`Template_ID` = T1.`Template_ID` WHERE `Paragraph_Text` = 'Korea'
SELECT Paragraph_ID, `Paragraph_Text` FROM Paragraphs WHERE Document_ID = (SELECT Document_ID FROM Documents WHERE Document_Name = "Welcome to NY")
SELECT P.`Paragraph_ID`, P.`Paragraph_Text` FROM Paragraphs AS P JOIN Documents AS D ON P.`Document_ID` = D.`Document_ID` WHERE `Document_Name` = 'Welcome to NY'
SELECT `Paragraph_Text` FROM Paragraphs JOIN Documents ON Paragraphs.`Document_ID` = Documents.`Document_ID` WHERE Documents.Document_Name='Customer reviews';
error: No SQL found in the input string
SELECT D.`Document_ID`, COUNT(P.`Paragraph_ID`) FROM Documents AS D INNER JOIN Templates AS T ON D.`Template_ID` = T.`Template_ID` INNER JOIN Paragraphs AS P ON D.`Document_ID` = P.`Document_ID` GROUP BY D.`Document_ID` ORDER BY D.`Document_ID`
SELECT Documents.`Document_ID`, COUNT(Paragraphs.Paragraph_ID) AS Paragraph_count FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.`Document_ID` ORDER BY Documents.`Document_ID`;
SELECT Documents.`Document_ID`, Documents.`Document_Name`, COUNT(*) AS `Paragraph_Counts` FROM Documents JOIN Paragraphs ON Documents.`Document_ID` = Paragraphs.`Document_ID` GROUP BY Documents.`Document_ID`, Documents.`Document_Name`
SELECT D.`Document_ID`, D.`Document_Name`, COUNT(P.`Paragraph_ID`) AS Number_of_Paragraphs FROM Documents AS D JOIN Templates AS T ON D.`Template_ID` = T.`Template_ID` JOIN Paragraphs AS P ON D.`Document_ID` = P.`Document_ID` GROUP BY D.`Document_ID`, D.`Document_Name`
SELECT `Document_ID` FROM Paragraphs GROUP BY `Document_ID` HAVING COUNT(*) >= 2
SELECT d.`Document_ID`, COUNT(p.`Paragraph_ID`) FROM Documents AS d JOIN Paragraphs AS p ON d.`Document_ID` = p.`Document_ID` GROUP BY d.`Document_ID` HAVING COUNT(p.`Paragraph_ID`) >= 2
SELECT Documents.Document_ID, Documents.Document_Name, COUNT(*) AS Paragraph_Count FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID, Documents.Document_Name ORDER BY Paragraph_Count DESC LIMIT 1;
SELECT D.`Document_ID`, D.`Document_Name` FROM Documents AS D JOIN Paragraphs AS P ON D.`Document_ID` = P.`Document_ID` GROUP BY D.`Document_ID` ORDER BY COUNT(P.`Paragraph_ID`) DESC LIMIT 1;
SELECT Document_ID FROM Documents GROUP BY Document_ID HAVING COUNT(*) = (SELECT MIN(total) FROM ( SELECT Document_ID, COUNT(*) AS total FROM Paragraphs GROUP BY Document_ID ) t)
SELECT DISTINCT D.Document_ID FROM Documents D JOIN Paragraphs P ON D.Document_ID = P.Document_ID GROUP BY D.Document_ID ORDER BY COUNT(P.Paragraph_id) ASC LIMIT 1;
SELECT D.Document_ID FROM Documents AS D JOIN Templates AS T ON D.Template_ID = T.Template_ID WHERE T.Template_ID IN ( SELECT T2.Template_ID FROM Templates AS T2 JOIN Ref_Template_Types AS R ON T2.Template_Type_Code = R.Template_Type_Code WHERE R.Template_Type_Description LIKE 'Presentation' OR R.Template_Type_Description LIKE 'Paper' AND ( (SELECT COUNT(Paragraph_ID) FROM Paragraphs WHERE Document_ID = D.Document_ID) BETWEEN 1 AND 2) );
SELECT `Document_ID` FROM Paragraphs GROUP BY `Document_ID` HAVING COUNT(*) BETWEEN 1 AND 2;
SELECT D.`Document_ID` FROM Documents AS D JOIN Paragraphs AS P ON D.`Document_ID` = P.`Document_ID` WHERE P.Paragraph_Text IN ('Brazil', 'Ireland')
# Create the necessary tables CREATE TABLE Ref_Template_Types ( Template_Type_Code TEXT, template_type_description TEXT ); CREATE TABLE Templates ( Template_ID INTEGER PRIMARY KEY, Version_Number INTEGER, Template_Type_Code TEXT, Date_Effective_From TEXT, Date_Effective_To TEXT, Template_Details TEXT ); CREATE TABLE Documents ( Document_ID INTEGER PRIMARY KEY, Template_ID INTEGER, Document_Name TEXT, Document_Description TEXT, Other_Details TEXT ); CREATE TABLE Paragraphs ( Paragraph_ID INTEGER PRIMARY KEY, Document_ID INTEGER, Paragraph_Text TEXT, Other_Details TEXT ); # Insert some dummy data INSERT INTO Ref_Template_Types (Template_Type_Code, template_type_description) VALUES (' Presentation', 'Presentation' ); INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (1, 1, "Welcome to NY", "y", NULL); INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES(1, 1, 'Korea', 'x'); # Execute the corrected SQL SELECT DISTINCT D.Document_ID FROM Documents AS D JOIN Paragraphs AS P ON D.Document_ID = P.Document_ID WHERE P.Paragraph_Text IN ('Brazil', 'Ireland');
SELECT COUNT(*) FROM teacher;
SELECT COUNT(*) FROM teacher;
SELECT `Name` FROM teacher ORDER BY Age ASC
SELECT Name FROM teacher ORDER BY Age ASC;
SELECT T1.`Age`, T1.`Hometown` FROM teacher AS T1
SELECT `Age`, `Hometown` FROM teacher
SELECT Name FROM teacher WHERE Hometown != 'Little Lever Urban District'
SELECT `Name` FROM teacher WHERE `Hometown` != 'Little Lever Urban District'
SELECT Name FROM teacher WHERE Age IN (32, 33)
SELECT T1.`Name` FROM teacher AS T1 WHERE T1.Age IN (32, 33) GROUP BY T1.`Name`
SELECT T1.`Hometown` FROM teacher AS T1 JOIN ( SELECT MIN(Age) AS minAge FROM teacher ) AS T2 ON T1.Age = T2.minAge;
SELECT `Hometown` FROM teacher WHERE Age = (SELECT MIN(Age) FROM teacher)
SELECT `Hometown`, COUNT(*) FROM teacher GROUP BY `Hometown`
SELECT `Hometown`, COUNT(*) FROM teacher GROUP BY `Hometown`
SELECT Hometown, COUNT(*) as Count FROM teacher GROUP BY Hometown ORDER BY Count DESC LIMIT 1;
SELECT Hometown, COUNT(*) as frequency FROM teacher GROUP BY Hometown ORDER BY frequency DESC -- sort by frequency in descending order to get most common LIMIT 1 -- limit the result to first occurrence (there can be only one most common hometown)
SELECT Hometown FROM teacher AS T2 JOIN course_arrange AS T1 ON T2.Teacher_ID = T1.Teacher_ID GROUP BY T2.Hometown HAVING COUNT(*) > 1
SELECT Hometown FROM teacher GROUP BY Hometown HAVING COUNT(*) >= 2
SELECT T3.Name, T1.Course FROM course_arrange AS T2 JOIN course AS T1 ON T1.Course_ID = T2.Course_ID JOIN teacher AS T3 ON T2.Teacher_ID = T3.Teacher_ID
-- Find the name of each teacher and what course they teach?
SELECT `Course` FROM course ORDER BY 1
SELECT T1.Name, T2.Course FROM teacher AS T1 JOIN course_arrange AS T3 ON T1.Teacher_ID = T3.Teacher_ID JOIN course AS T2 ON T2.Course_ID = T3.Course_ID ORDER BY T1.Name ASC;
SELECT T2.`Name` FROM course AS T1 JOIN course_arrange AS T3 ON T1.`Course_ID` = T3.`Course_ID` JOIN teacher AS T2 ON T3.`Teacher_ID` = T2.`Teacher_ID` WHERE T1.`Course` = 'Math'
SELECT T1.`Name` FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.`Teacher_ID` = T2.`Teacher_ID` JOIN course AS T3 ON T2.`Course_ID` = T3.`Course_ID` WHERE T3.Course = 'Math'
SELECT T1.`Name`, COUNT(*) FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.`Teacher_ID` = T2.`Teacher_ID` GROUP BY T2.`Teacher_ID`
SELECT T1.`Name`, COUNT(*) FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.`Teacher_ID` = T2.`Teacher_ID` GROUP BY T1.`Teacher_ID`
SELECT T2.Name FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.Teacher_ID = T2.Teacher_ID GROUP BY T1.Teacher_ID HAVING COUNT(T1.Course_ID) >= 2;
SELECT T1.`Name`, COUNT(*) FROM teacher AS T1 JOIN course_arrange AS T2 ON T1.Teacher_ID = T2.Teacher_ID GROUP BY T1.Name HAVING COUNT(T2.Course_ID) > 1;
SELECT Name FROM teacher WHERE Teacher_ID NOT IN (SELECT DISTINCT Teacher_ID FROM course_arrange)
SELECT T1.`Name` FROM teacher AS T1 WHERE T1.`Teacher_ID` NOT IN ( SELECT DISTINCT T3.`Teacher_ID` FROM course_arrange AS T3 )
SELECT COUNT(*) FROM visitor WHERE Age < 30;
SELECT Name FROM visitor WHERE Level_of_membership > 4 ORDER BY Level_of_membership DESC
SELECT AVG(Age) FROM visitor WHERE Level_of_membership <= 4
SELECT Name, Level_of_membership FROM visitor WHERE Level_of_membership > 4 ORDER BY Age DESC;
SELECT Museum_ID, `Name` FROM museum ORDER BY Num_of_Staff DESC LIMIT 1;
SELECT AVG(Num_of_Staff) FROM museum WHERE Open_Year < 2009;
SELECT Open_Year, Num_of_Staff FROM museum WHERE Name = "plaza museum"
SELECT m.`Name` FROM museum AS m JOIN visit AS v ON m.`Museum_ID` = v.`Museum_ID` GROUP BY m.`Name` -- added GROUP BY to select distinct museum names HAVING COUNT(m.`Num_of_Staff`) > ( SELECT MIN(m.Num_of_Staff) FROM museum AS m WHERE m.Open_Year > '2010' ) AND v.visitor_ID IN ( SELECT ID FROM visitor WHERE Level_of_membership > ( SELECT MAX(Level_of_membership) FROM visitor ) )
SELECT `ID`, `Name`, `Age` FROM visitor WHERE `ID` IN ( SELECT `visitor_ID` FROM visit GROUP BY `Museum_ID` HAVING COUNT(*) > 1 )
SELECT V.`ID`, V.`Name`, V.`Level_of_membership` FROM visit AS T1 JOIN visitor AS V ON T1.`visitor_ID` = V.`ID` GROUP BY V.`ID`, V.`Name`, V.`Level_of_membership` HAVING MAX(T1.`Total_spent`)
-- What are the id and name of the museum visited most times? SELECT subquery.Museum_ID, museum.Name FROM ( SELECT visit.Museum_ID, COUNT(visit.num_of_ticket) AS visit_count FROM visit JOIN museum ON visit.museum_id = museum.museum_id GROUP BY visit.museum_id ) AS subquery JOIN museum ON subquery.museum_id = museum.museum_id ORDER BY subquery.visit_count DESC LIMIT 1;
SELECT Name FROM museum WHERE Museum_ID NOT IN (SELECT Museum_ID FROM visit)
SELECT T1.Name, T1.Age FROM visitor AS T1 JOIN visit AS T2 ON T1.ID = T2.visitor_ID -- Fix: Use a subquery to get the max number of tickets instead of ALL keyword WHERE T2.Num_of_Ticket = (SELECT MAX(Num_of_Ticket) FROM visit)
SELECT MAX(`Num_of_Ticket`) FROM visit
SELECT V.Level_of_membership, SUM(VT.Total_spent) AS Total FROM visit AS VT JOIN visitor AS V ON VT.visitor_ID = V.ID WHERE Level_of_membership = 1 GROUP BY V.Level_of_membership;
SELECT `Name` FROM visitor WHERE ID IN (SELECT T3.`visitor_ID` FROM visit AS T1 JOIN museum AS T2 ON T1.`Museum_ID` = T2.`Museum_ID` JOIN visit AS T3 ON T3.`Museum_ID`<>T1.`Museum_ID` AND T3.`visitor_ID`=T1.`visitor_ID` GROUP BY T1.`Visitor_ID` HAVING SUM(CASE WHEN CAST(T1.`Total_spent`AS REAL) < 50 THEN 1 ELSE 0 END)=2)
SELECT COUNT(DISTINCT T2.`ID`) FROM visit AS T1 JOIN visitor AS T2 ON T1.`visitor_ID` = T2.`ID` JOIN museum AS T3 ON T1.`Museum_ID` = T3.`Museum_ID` WHERE T3.`Open_Year` < '2010'
SELECT COUNT(*) FROM museum WHERE NOT (Open_Year > '2013') AND (Open_Year < '2008')
SELECT COUNT(*) FROM players;
SELECT COUNT(*) FROM players;
SELECT COUNT(*) FROM matches
SELECT COUNT(*) FROM matches
SELECT `first_name`, `birth_date` FROM players WHERE `country_code` = 'USA'
SELECT first_name, birth_date FROM players WHERE country_code = 'USA'
error: No SQL found in the input string
SELECT AVG(T1.`winner_age`) AS avg_winner_age, AVG(T2.`loser_age`) AS avg_loser_age FROM matches AS T1 INNER JOIN matches AS T2 ON T1.`match_num` = T2.`match_num`
error: No SQL found in the input string
SELECT AVG(T3.ranking) FROM matches AS T1 JOIN players AS T2 ON T2.player_id = T1.winner_id JOIN rankings AS T3 ON T3.player_id = T2.player_id
SELECT MAX(r.max_winner_rank_in_tournament) AS max_winner_rank_in_all_matches FROM ( SELECT p.player_id, r.ranking_date, r.ranking AS win_loss_rank, m.loser_rank, MAX(m.winner_rank) OVER (PARTITION BY m.loser_id ORDER BY m.tourney_date DESC) AS max_winner_rank_in_tournament FROM players p JOIN matches m ON (p.player_id = m.loser_id) JOIN rankings r ON (r.player_id = p.player_id AND r.ranking_date <= m.tourney_date) ) AS subquery;
SELECT MIN(ranking) AS min_rank FROM rankings;
SELECT COUNT(DISTINCT `country_code`) FROM players;
SELECT COUNT(DISTINCT country_code) FROM players;
SELECT COUNT(DISTINCT `loser_name`) FROM matches;
SELECT COUNT(DISTINCT `loser_name`) FROM matches;
SELECT m.tourney_id AS tourney_id, COUNT(*) as num_matches FROM matches AS m GROUP BY m.tourney_id HAVING COUNT(*) > 10;
SELECT T1.tourney_name, COUNT(*) AS num_matches FROM matches AS T1 JOIN (SELECT tourney_id FROM matches) AS T2 ON T1.`tourney_id` = T2.tourney_id GROUP BY T1.tourney_name HAVING COUNT(*) > 10;
SELECT distinct T2.first_name, T2.last_name FROM matches AS T1 JOIN players AS T2 ON `T1`.`winner_id` = `T2`.`player_id` JOIN rankings AS T3 ON T2.`player_id`=T3. `player_id` WHERE T3.ranking_date >= 20130101 AND T3.ranking_date < 20131231 INTERSECT SELECT distinct T2.first_name, T2.last_name FROM matches AS T1 JOIN players AS T2 ON `T1`.`winner_id` = `T2`.`player_id` JOIN rankings AS T3 ON T2.`player_id`=T3. `player_id` WHERE T3.ranking_date >= 20160101 AND T3.ranking_date < 20161231
SELECT first_name, last_name FROM players AS P JOIN ( SELECT winner_id, year, COUNT(*) as num_wins FROM matches GROUP BY winner_id, Year ) AS M ON P.player_id = M.winner_id WHERE M.year IN (2013, 2016) GROUP BY first_name, last_name HAVING COUNT(DISTINCT M.year) = 2;
/*SQL*/-- SELECT <columns>, match is who played in 2013 or 2016, -- and player id of player which we need to count SELECT COUNT(*) FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.loser_id WHERE T2.year IN ('2013','2016') ;
SELECT COUNT(*) FROM matches WHERE year IN (2013, 2016)
SELECT T1.country_code, T1.first_name FROM players AS T1 JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T2.tourney_name IN ('WTA Championships', 'Australian Open');
SELECT T1.first_name, T1.country_code FROM players AS T1 JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T2.tourney_name IN ('WTA Championships', 'Australian Open') GROUP BY T1.first_name, T1.country_code HAVING COUNT(*) > 1;
SELECT first_name, country_code FROM players ORDER BY birth_date DESC LIMIT 1;
SELECT first_name, country_code FROM players ORDER BY birth_date ASC -- Changed to simple order by column name LIMIT 1;
SELECT first_name, last_name FROM players ORDER BY birth_date ASC;
error: No SQL found in the input string
SELECT first_name, last_name FROM players WHERE hand = 'L' ORDER BY birth_date;
SELECT first_name, last_name FROM players WHERE hand = 'L' ORDER BY birth_date ASC;
SELECT first_name, country_code FROM players AS P JOIN ( SELECT player_id, COUNT(tours) as count_tours FROM rankings R JOIN matches M ON R.player_id = M.loser_id OR R.player_id = M.winner_id WHERE COALESCE(R.tours, M.tours) IS NOT NULL GROUP BY R.player_id, COALESCE(R.tours, M.tours) ) AS T ON P.player_id = T.player_id WHERE count_tours = ( SELECT MAX(count_tours) as max_count_tours FROM ( SELECT COUNT(tours) as count_tours FROM rankings R JOIN matches M ON R.player_id = M.loser_id OR R.player_id = M.winner_id WHERE COALESCE(R.tours, M.tours) IS NOT NULL GROUP BY R.player_id, COALESCE(R.tours, M.tours) ) );
WITH ranked_players AS ( SELECT r.player_id, (SELECT ranking from rankings AS t2 WHERE t2.ranking_date = r.RANKING_DATE ORDER BY t2.ranking_points DESC LIMIT 1) as players_tour_ranking, MAX(r.ranking_points) - MIN(r.ranking_points) + 1 AS tour_count FROM rankings r GROUP BY r.player_id ORDER BY tour_count DESC, player_id ASC ) SELECT p.first_name, p.country_code FROM ranked_players rp JOIN players p ON rp.player_id = p.player_id WHERE rp.tour_count = ( SELECT MAX(tour_count) FROM ranked_players )
SELECT year FROM ( SELECT year, COUNT(match_num) as num_matches FROM matches GROUP BY year ) AS T WHERE num_matches = (SELECT MAX(num_matches) FROM (SELECT year, COUNT(match_num) as num_matches FROM matches GROUP BY year) AS s)
error: No SQL found in the input string
SELECT p.first_name, p.last_name, r.ranking_points FROM players AS p JOIN matches AS m ON p.player_id = m.winner_id JOIN rankings AS r ON p.player_id = r.player_id GROUP BY p.first_name, p.last_name ORDER BY COUNT(*) DESC LIMIT 1;
SELECT winner_name, winner_rank_points FROM ( SELECT T2.first_name AS winner_name, (CASE WHEN T1.loser_id = T2.player_id THEN 1 ELSE 0 END) AS win_count, player_id, winner_rank_points FROM players as T2 JOIN matches as T1 ON T1.winner_id = T2.player_id OR T1.loser_id = T2.player_id GROUP BY player_id ) AS subquery ORDER BY win_count DESC LIMIT 1;
SELECT P.first_name, P.last_name FROM players AS P JOIN matches AS M ON P.player_id = M.winner_id WHERE M.tourney_name = 'Australian Open' AND M.year = 2013 AND M.winner_rank_points = (SELECT MAX(R.ranking_points) FROM rankings AS R WHERE R.`ranking_date` BETWEEN DATE(M.tourney_date, '-' || -6) AND DATE(M.tourney_date))
error: No SQL found in the input string
error: No SQL found in the input string
SELECT T1.first_name, T1.last_name, T2.loser_name FROM players AS T1 JOIN matches AS T2 ON T1.player_id = T2.loser_id OR T1.player_id = T2.winner_id ORDER BY minutes DESC LIMIT 1;
SELECT T1.`first_name`, AVG(T2.`ranking`) as avg_ranking FROM players AS T1 JOIN rankings AS T2 ON T1.`player_id` = T2.`player_id` GROUP BY T1.`player_id`, T1.`first_name`
SELECT first_name, AVG(ranking) FROM players JOIN rankings ON players.player_id = rankings.player_id GROUP BY first_name;
SELECT T1.first_name, SUM(T2.ranking_points) FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name
SELECT T1.first_name, SUM(T2.ranking_points) AS total_ranking_points FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.player_id;
SELECT `country_code`, COUNT(*) AS num_players FROM `players` GROUP BY `country_code`
SELECT COUNT(*) AS num_players, `country_code` FROM players GROUP BY `country_code`
SELECT players.country_code FROM players GROUP BY players.country_code ORDER BY COUNT(players.country_code) DESC LIMIT 1;
SELECT `country_code`, COUNT(*) as count FROM players AS T1 JOIN matches AS T2 ON T1.player_id = T2.loser_id GROUP BY country_code ORDER BY count DESC LIMIT 1;
SELECT country_code, COUNT(player_id) AS num_players FROM players GROUP BY country_code HAVING COUNT(player_id) > 50;
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50
SELECT `ranking_date`, COUNT(`tours`) FROM rankings GROUP BY `ranking_date`
SELECT r.`ranking_date`, SUM(r.`tours`) AS total_tours FROM rankings r JOIN ( SELECT `player_id` FROM rankings WHERE `ranking_points` = (SELECT MAX(`ranking_points`) FROM rankings) ) p ON r.`player_id` = p.`player_id` GROUP BY r.`ranking_date`;
SELECT YEAR, COUNT(*) FROM matches GROUP BY YEAR
SELECT T1.year, COUNT(*) as num_matches FROM matches AS T1 GROUP BY T1.year ORDER BY T1.year ASC;
-- SQLite does not support DATEDIFF function, so we use the ABS and - operators to get the difference in years SELECT p.first_name, p.last_name, r.ranking AS youngest_rank, ABS(TIMESTAMPDIFF(YEAR, m.winner_id.birth_date, '2033-03-13')) AS age FROM players p JOIN ( SELECT m.winner_id FROM matches m WHERE score NOT LIKE '6-% 6-%' AND match_num IS NOT NULL ) AS latest_winner ON p.player_id = latest_winner.winner_id LEFT JOIN rankings r ON p.player_id = r.player_id WHERE p.player_id = latest_winner.winner_id;
SELECT p.first_name, p.last_name, r.ranking FROM players AS p JOIN rankings as r ON r.player_id = p.player_id WHERE p.player_id IN ( SELECT m.winner_id FROM matches AS m GROUP BY m.winner_id HAVING AVG(EXTRACT(YEAR FROM m.tourney_date)) < (SELECT MAX(YEAR(t.tourney_date)) FROM (SELECT tourney_date FROM matches) t) ) ORDER BY r.ranking DESC LIMIT 3;
SELECT COUNT(DISTINCT winner_id) FROM matches WHERE tourney_name = 'WTA CHAMPIONS' AND year IN (16, 17) AND winner_hand = 'R'
SELECT COUNT(*) FROM players AS p JOIN matches m ON p.player_id = m.winner_id WHERE p.hand = 'L' AND m.tourney_name LIKE '%WTA Championships'
SELECT first_name, country_code, birth_date FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id WHERE T2.ranking_points = ( SELECT MAX(ranking_points) FROM rankings ) AND T1.player_id IN ( SELECT winner_id FROM matches );
SELECT P.first_name, P.country_code as c_code, RP.birth_date FROM players AS P JOIN ( SELECT player_id, MAX(winner_rank_points) as max_winner_rank_points FROM matches GROUP BY player_id ) M ON P.player_id = M.player_id JOIN rankings AS R ON P.player_id = R.player_id WHERE M.max_winner_rank_points = (SELECT MAX(ranking_points) FROM rankings);
SELECT T1.`hand` AS Hand_Type, COUNT(*) AS Number_of_Players FROM players AS T1 GROUP BY T1.`hand`
SELECT COUNT(*) AS count, hand FROM players GROUP BY hand;
SELECT COUNT(*) FROM `ship` WHERE disposition_of_ship = 'Captured';
SELECT T1.`name`, T1.tonnage FROM ship AS T1 ORDER BY T1.`name` DESC
SELECT id, name, date, bulgarian_commander, latin_commander, result FROM battle
-- What is maximum and minimum death toll caused each time? SELECT DISTINCT B.id AS battle_id, MAX(D.killed) AS max_death_toll, MIN(D.killed) AS min_death_toll FROM death D JOIN ship S ON D.caused_by_ship_id = S.id JOIN battle B ON S.lost_in_battle = B.id GROUP BY B.id;
SELECT AVG(d.injured) FROM ship s JOIN death d ON s.lost_in_battle = d.caused_by_ship_id;
SELECT `Note`, `killed`, `injured` FROM death WHERE `caused_by_ship_id` = (SELECT `id` FROM ship WHERE `tonnage` = 't')
SELECT name, result FROM battle WHERE bulgarian_commander != 'Boril'
SELECT DISTINCT id, name FROM battle WHERE id IN ( SELECT T1.`lost_in_battle` FROM ship AS T1 WHERE `ship_type` = 'Brig')
BEGIN TRANSACTION; SELECT b.id, b.name FROM battle AS b JOIN ( SELECT id FROM death GROUP BY id HAVING SUM(killed) > 10 ) d ON b.id = d.id; COMMIT;
SELECT T1.`name`, COUNT(T3.`injured`) FROM ship AS T1 JOIN battle AS T2 ON T1.`lost_in_battle` = T2.`id` JOIN death AS T3 ON T3.`caused_by_ship_id` = T1.`id` GROUP BY T1.`name` ORDER BY COUNT(T3.`injured`) DESC LIMIT 1;
-- What are the distinct battle names which are between bulgarian commander 'Kaloyan' and latin commander 'Baldwin I'? SELECT DISTINCT T2.`name` FROM `battle` AS T1 JOIN `battle` AS T2 ON 1=1 WHERE T1.`bulgarian_commander` = 'Kaloyan' AND T2.`latin_commander` = 'Baldwin I';
SELECT COUNT(DISTINCT result) FROM battle;
SELECT COUNT(*) FROM battle AS T1 LEFT JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE T2.tonnage != '225' AND T1.result = 'latin victory'
SELECT T1.`name`, T1.`date` FROM battle AS T1 INNER JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE (T2.name IN ('Three Brothers', 'HMS Atalanta') OR T2.name IN ('Three Brothers', 'HMS Atalanta')) AND T2.name IN('Three Brothers', 'HMS Atalanta')
SELECT T1.name, T1.result, T1.bulgarian_commander FROM battle AS T1 JOIN ship AS T2 ON T2.lost_in_battle = T1.id WHERE T2.location = 'English Channel' AND T2.disposition_of_ship IS NULL ORDER BY T1.date ASC;
SELECT note FROM death WHERE note LIKE '%East%';
-- Retrieve address details from the Addresses table, including street_number_line1, -- street_number_line2, branch_name, city_state_zip_code, type (permanent or current) along with a description of what they are. SELECT * FROM Addresses;
SELECT line_1 AS first_line, line_2 AS second_line FROM Addresses;
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT section_name, section_description FROM Sections;
error: No SQL found in the input string
error: No SQL found in the input string
SELECT C.course_id, C.course_name FROM Courses AS C JOIN Sections AS S ON C.course_id = S.course_id GROUP BY C.course_id, C.course_name HAVING COUNT(S.section_id) < 2;
error: No SQL found in the input string
SELECT section_name FROM Sections ORDER BY section_name DESC;
SELECT Semesters.semester_name, Semesters.semester_id FROM Students JOIN Student_Enrolment ON Students.student_id = Student_Enrolment.student_id JOIN Semesters ON Student_Enrolment.semester_id = Semesters.semester_id GROUP BY Semesters.semester_id ORDER BY COUNT(Semesters.semester_id) DESC LIMIT 1;
SELECT semesters.semester_name, semesters.semester_id FROM semesters INNER JOIN student_enrolment ON student_enrolment.semester_id = semesters.semester_id GROUP BY semesters.semester_name, semesters.semester_id ORDER BY COUNT(student_enrolment.student_id) DESC LIMIT 1;
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT S.first_name, S.middle_name, S.last_name FROM Students AS S JOIN Student_Enrolment AS SE ON S.student_id = SE.student_id JOIN Degree_Programs AS DP ON SE.degree_program_id = DP.degree_program_id WHERE DP.degree_summary_name = 'Bachelor';
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT S.student_id, S.first_name, S.middle_name, S.last_name, COUNT(SE.degree_program_id) AS num_enrollments FROM Students S JOIN Student_Enrolment SE ON S.student_id = SE.student_id GROUP BY S.student_id, S.first_name, S.middle_name, S.last_name ORDER BY COUNT(SE.degree_program_id) DESC LIMIT 1;
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT DISTINCT C.course_name AS course_names FROM Courses AS C JOIN Student_Enrolment_Courses SEC ON C.course_id = SEC.course_id WHERE SEC.student_enrolment_id IN ( SELECT student_enrolment_id FROM Student_Enrolment ) ORDER BY C.course_name;
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT tc.transcript_id, tr.transcript_date FROM Transcript_Contents tc JOIN Transcripts tr ON tc.transcript_id = tr.transcript_id GROUP BY tr.transcript_id HAVING COUNT(tc.student_course_id) >= 2;
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT COUNT(*) AS num_transcripts, TSC.student_enrolment_id FROM Transcript_Contents TC JOIN Student_Enrolment_Courses TSC ON TC.student_course_id = TSC.student_course_id GROUP BY TSC.student_enrolment_id;
error: No SQL found in the input string
/* Type: SQLite Query */ SELECT t.transcript_date AS transcript_date, t.enroll_count AS min_enroll_count FROM ( SELECT tc.tranasctr_id as transcript_id, COUNT(DISTINCT student_course_id) as enroll_count FROM Transcript_Contents tc JOIN Student_Enrolment_Courses sec on tc.student_course_id = sec.student_course_id GROUP BY tc.transcript_id ) AS t WHERE enroll_count = (SELECT MIN(enroll_count) FROM anon) ORDER BY transcript_date ASC LIMIT 1;
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT last_name, first_name FROM Students ORDER BY first_name DESC;
error: No SQL found in the input string
error: No SQL found in the input string
SELECT * FROM Students WHERE cell_mobile_number = '09700166582'
error: No SQL found in the input string
SELECT `Title` FROM Cartoon ORDER BY `Title` ASC;
SELECT DISTINCT T2.`Title` FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T2.Channel = T1.id GROUP BY T2.Title -- add GROUP BY before ORDER BY -- To get actual order (the 'sorted alphabetically') ORDER BY T2.Title ASC;
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones'
error: No SQL found in the input string
SELECT COUNT(*) FROM Cartoon AS T1 JOIN TV_Channel AS T2 ON T1.`Channel` = T2.id WHERE T2.`series_name` IS NULL AND Written_by = 'Joseph Kuhr'
SELECT COUNT(*) FROM Cartoon WHERE Written_by = 'Joseph Kuhr'
-- list all cartoon titles and their directors ordered by their air date SELECT c.Title, ca.Directed_by FROM Cartoon AS c JOIN TV_Channel AS t ON c.Channel = t.id JOIN Cartoon as ca on t.id = ca.Channel ORDER BY c.`Original_air_date`;
SELECT DISTINCT C.`Title`, A.`Directed_by` AS Director, S.`Original_air_date` FROM Cartoon C -- Note: Changed order of joining tables JOIN TV_Channel A ON C.Channel = A.id JOIN TV_Series S ON A.id = S.Channel ORDER BY S.Air_Date ASC;
SELECT `Title` FROM Cartoon WHERE (`Written_by` LIKE '%Ben Jones%' OR `Written_by` LIKE '%Brandon Vietti%')
SELECT DISTINCT Title FROM Cartoon WHERE Directed_by IN ('Ben Jones', 'Brandon Vietti');
SELECT Country, COUNT(*) as numChannels FROM TV_Channel GROUP BY Country HAVING COUNT(*) = ( SELECT COUNT(*) FROM TV_Channel GROUP BY Country ORDER BY COUNT(*) DESC LIMIT 1 );
SELECT Country, COUNT(`id`) as Count FROM TV_Channel GROUP BY Country ORDER BY Count DESC LIMIT 1;
error: No SQL found in the input string
SELECT COUNT(DISTINCT ser.Series_name), COUNT(DISTINCT Channel.Content) FROM TV_Channel as ser JOIN TV_Channel AS Channel ON ser.id = Channel.id;
SELECT Content FROM TV_Channel WHERE series_name = 'myDeejay'
SELECT Content FROM TV_Channel WHERE id IN (SELECT Channel FROM Cartoon WHERE Title = 'The Rise of the Blue Beetle!')
SELECT Package_Option FROM TV_Channel WHERE series_name = 'Sky Radio';
SELECT package_option FROM TV_Channel WHERE id IN ( SELECT Channel FROM TV_series WHERE series_name = 'Sky Radio' )
SELECT COUNT(*) FROM TV_Channel WHERE Language = 'English'
SELECT COUNT(*) FROM TV_Channel WHERE Language = 'English';
SELECT T1.Language, COUNT(T2.id) AS Number_of_TV_Channel FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T2.Channel = T1.id GROUP BY T1.Language;
SELECT Language, Count FROM ( SELECT Language, COUNT(*) as Count FROM TV_Channel GROUP BY Language ) t1 WHERE Count = ( SELECT MIN(Count) FROM ( SELECT LANGUAGE, COUNT(*) as Count FROM TV_Channel GROUP BY LANGUAGE ) AS t2 );
SELECT `Language`, COUNT(*) FROM TV_Channel GROUP BY `Language`
SELECT `Language`, COUNT(*) FROM TV_channel GROUP BY `Language`
WITH cartoon_channels AS ( SELECT C.id, T.Series_name FROM Cartoon AS C JOIN TV_Channel AS T ON C.channel = T.ID WHERE Title LIKE 'The Rise of the Blue Beetle!' ) SELECT * FROM cartoon_channels;
SELECT T1.`series_name` FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE `Title` = 'The Rise of the Blue Beetle!'
SELECT DISTINCT C.`Title` FROM Cartoon AS C JOIN TV_Channel AS T ON C.Channel = T.id WHERE T.series_name = 'Sky Radio';
SELECT Title FROM Cartoon WHERE Channel IN (SELECT id FROM TV_Channel WHERE series_name = 'Sky Radio')
SELECT `Episode`, Rating FROM `TV_series` ORDER BY Rating DESC;
SELECT `Episode`, Rating FROM TV_series ORDER BY Rating DESC;
SELECT T1.`Episode`, T1.`Rating` FROM TV_series AS T1 JOIN ( SELECT `Channel` as Channel, MAX(`Rating`) as max_Rating FROM TV_series GROUP BY `Channel` ) AS T2 ON T1.`Channel` = T2.`Channel` ORDER BY T2.max_Rating DESC LIMIT 3
SELECT tv_series.Episode, MAX(tv_series.Rating) AS MaxRating FROM TV_series JOIN TV_Channel ON tv_series.Channel = TV_Channel.id WHERE tv_series.Rating IS NOT NULL AND TV_Channel.Content = 'music' GROUP BY tv_series.Episode ORDER BY tv_series.Rating DESC LIMIT 3;
SELECT MIN(Share) AS Min_Share, MAX(Share) AS Max_Share FROM TV_series;
SELECT MAX(Rating) AS max_rating, MIN(Rating) AS min_rating FROM TV_series;
SELECT T2.`Air_Date`, T1.`series_name` FROM TV_series AS T1 JOIN TV_Channel AS T2 ON T1.Channel = T2.id WHERE T1.`Episode` = 'A Love of a Lifetime'
SELECT Air_Date FROM TV_series WHERE Episode = 'A Love of a Lifetime'
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'a love of a lifetime'
SELECT `Weekly_Rank` FROM TV_series WHERE Channel IN ( SELECT id FROM TV_Channel WHERE series_name IN ( 'Cartoon channel' ) ) AND `Episode` = "A Love of a Lifetime"
SELECT T1.`series_name` FROM TV_Channel AS T1 JOIN TV_Series AS T2 ON T1.id = T2.Channel WHERE T2.Episode = "A Love of a Lifetime";
-- What is the name of the series that has the episode "A Love of a Lifetime"? SELECT T1.`series_name` FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T2.Episode = 'A Love of a Lifetime';
SELECT T2.`Episode` FROM TV_Channel AS T1 JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T1.series_name = 'Sky Radio' ORDER BY T2.Episode;
SELECT `Episode` FROM TV_series WHERE `Channel` = ( SELECT id FROM TV_Channel WHERE `series_name` = 'Sky Radio' )
SELECT `Directed_by`, COUNT(`Title`) FROM Cartoon GROUP BY `Directed_by`
SELECT C.Title, D.Directed_by AS Director, COUNT(C.id) FROM Cartoon C JOIN Cartoon T2 ON T1.id = T2.id WHERE Content = 'music' AND t2.directed_by IS NOT NULL GROUP BY D.Directed_by;
SELECT Title, Channel, Production_code FROM Cartoon WHERE id = ( SELECT id FROM Cartoon ORDER BY Original_air_date DESC LIMIT 1 );
SELECT `Production_code`, `Channel` FROM Cartoon WHERE Original_air_date = (SELECT MAX(Original_air_date) FROM Cartoon)
-- Find the package choice and series name of the TV channel that has high definition TV. SELECT -- Select only needed columns for the query. TC.`Package_Option`, TS.`series_name` FROM -- Directly join required tables (here: `TV_Channel` and `TV_series`) without any intermediate table. TV_Channel AS TC INNER JOIN TV_series AS TS ON TC.id = TS.Channel WHERE -- Apply condition to select only high definition TV channels, filtering out 'no' instances. TC.`Hight_definition_TV` = 'yes'
SELECT `Package_Option`, `series_name` FROM TV_Channel WHERE Hight_definition_TV = 'yes'
-- SQL SELECT Statement with join
error: No SQL found in the input string
SELECT Country FROM TV_Channel WHERE id NOT IN (SELECT Channel FROM Cartoon WHERE Written_by = 'Todd Casey')
SELECT id, Country FROM TV_Channel WHERE id IN (SELECT Channel FROM Cartoon WHERE Written_by != 'Todd Casey')
-- type: # sql SELECT T1.`series_name`, T1.`Country` FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Directed_by IN ('Ben Jones', 'Michael Chang')
SELECT TV_Channel.Series_Name, TV_Channel.Country FROM TV_Channel WHERE TV_Channel.id IN ( SELECT cartoon.Channel FROM Cartoon WHERE cartoon.Directed_by = 'Ben Jones' UNION SELECT cartoon.Channel FROM Cartoon WHERE cartoon.Directed_by = 'Michael Chang' )
SELECT `Pixel_aspect_ratio_PAR`, `Country` FROM TV_Channel WHERE `Language` != 'English'
SELECT `Pixel_aspect_ratio_PAR`, `Country` FROM TV_Channel WHERE `Language` <> 'English'
SELECT T1.id FROM TV_Channel AS T1 JOIN ( SELECT Country, COUNT(*) as count FROM TV_Channel GROUP BY Country HAVING count > 2 ) AS T3 ON T1.Country = T3.Country;
-- Correct SQL SELECT T1.Id FROM TV_Channel AS T1 JOIN TV_series AS T2 ON (T1.id = T2.Channel) AND T2.Channel IS NOT NULL GROUP BY Channel HAVING COUNT(T2.Channel) > 2;
-- Find the channel ids that correspond to channels without ben jones shows SELECT DISTINCT T1.id FROM TV_Channel AS T1 LEFT JOIN Cartoon AS T2 ON T1.id = T2.Channel OR T1.id = (SELECT Channel FROM cartoon WHERE Directed_by = 'Ben Jones') WHERE T2.id IS NULL;
SELECT id FROM TV_Channel WHERE id NOT IN (SELECT Channel FROM CARTOON WHERE Directed_by='Ben Jones')
SELECT * FROM ( SELECT T1.`Package_Option`, 'no_cartoon_directed_by_ben_jones' AS tag FROM TV_Channel AS T1 JOIN Cartoon AS T2 ON T1.`id` = T2.`Channel` WHERE T2.directed_by NOT LIKE '%Ben Jones%' ) AS A;
SELECT DISTINCT T1.Package_Option FROM TV_Channel AS T1 WHERE T1.id NOT IN ( SELECT T2.id AS channel FROM Cartoon AS T2 WHERE T2.Directed_by = 'Ben Jones' );
SELECT COUNT(*) FROM poker_player;
SELECT COUNT(*) FROM poker_player;
SELECT Earnings FROM poker_player ORDER BY Earnings DESC;
SELECT Earnings FROM poker_player ORDER BY Earnings DESC
SELECT Final_Table_Made, Best_Finish FROM poker_player WHERE Final_Table_Made != 0
SELECT P1.`Final_Table_Made`, P1.`Best_Finish` FROM poker_player AS P1 JOIN people AS P2 ON P1.`People_ID` = P2.`People_ID`
SELECT AVG(`Earnings`) FROM poker_player;
SELECT AVG(`Earnings`) FROM poker_player
SELECT Money_Rank FROM poker_player WHERE Earnings = ( SELECT MAX(Earnings) FROM poker_player )
SELECT T1.`Money_Rank` FROM poker_player AS T1 JOIN people AS T2 ON T1.`People_ID` = T2.`People_ID` ORDER BY T1.`Earnings` DESC LIMIT 1;
SELECT MAX(Final_Table_Made) FROM poker_player WHERE Earnings < 200000;
SELECT MAX(Final_Table_Made) AS maxFTMade FROM poker_player WHERE Earnings < 200000.0
SELECT DISTINCT T1.`Name` FROM people AS T1 JOIN poker_player AS T2 ON T1.`People_ID` = T2.`People_ID`
SELECT p.`Name` FROM poker_player AS pp INNER JOIN people AS p ON pp.People_ID = p.People_ID;
SELECT `Name` FROM poker_player AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Earnings > 300000;
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T2.Earnings > 300000
SELECT p.`Name` FROM poker_player AS T1 JOIN people AS p ON T1.People_ID = p.People_ID ORDER BY T1.Final_Table_Made ASC;
SELECT `Name` FROM people AS T1 JOIN poker_player AS T2 ON T1.`People_ID` = T2.`People_ID` ORDER BY T2.Final_Table_Made ASC;
SELECT Birth_Date FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY Earnings ASC LIMIT 1
SELECT P.`Birth_Date` FROM people AS P INNER JOIN poker_player AS PP ON P.`People_ID` = PP.`People_ID` WHERE PP.`Earnings` = (SELECT MIN(`Earnings`) FROM poker_player)
SELECT T2.`Money_Rank` FROM people AS T1 JOIN poker_player AS T2 ON T1.`People_ID` = T2.`People_ID` ORDER BY T1.`Height` DESC LIMIT 1;
-- Return the money rank of the poker player with the greatest earnings. SELECT T1.`Money_Rank` FROM poker_player AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T1.Earnings DESC LIMIT 1 -- Get just one row (The top earner)
SELECT AVG(T2.Earnings) FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T1.Height > 200;
-- Type: SELECT-query; DBMS: SQLite SELECT AVG(poker_player.Earnings) FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE people.Height > 200;
SELECT Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings DESC
SELECT T1.Name FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings DESC
SELECT T1.`Nationality`, COUNT(*) FROM people AS T1 GROUP BY T1.`Nationality`
SELECT `Nationality`, COUNT(*) AS count FROM people GROUP BY `Nationality`
SELECT Nationality, COUNT(*) FROM people GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Nationality, COUNT(*) as Count FROM people GROUP BY Nationality ORDER BY Count DESC LIMIT 1;
SELECT Nationality, COUNT(*) as Count FROM people GROUP BY Nationality HAVING COUNT(*) >= 2;
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(People_ID) > 2
SELECT T1.`Name`, T1.`Birth_Date` FROM people AS T1 ORDER BY `Name`
SELECT Name, Birth_Date FROM people ORDER BY Name ASC
SELECT `Name` FROM people WHERE `Nationality` != 'Russia'
SELECT Name FROM people WHERE Nationality != 'Russia'
SELECT T1.Name FROM people AS T1 LEFT JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T2.People_ID IS NULL
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM poker_player)
SELECT COUNT(DISTINCT `Nationality`) FROM people
SELECT COUNT(DISTINCT Nationality) FROM people
SELECT COUNT(*) FROM AREA_CODE_STATE
SELECT `contestant_number`, `contestant_name` FROM CONTESTANTS ORDER BY `contestant_name` DESC
SELECT VOTEs.vote_id, VOTES.phone_number, AREA_CODE_STATE.state FROM VOTES JOIN AREA_CODE_STATE ON VOTES.state = AREA_CODE_STATE.state;
SELECT MAX(area_code) as max_area_code, MIN(area_code) as min_area_code FROM AREA_CODE_STATE;
SELECT MAX(created) AS last_date_created FROM VOTES WHERE state = 'CA';
SELECT T2.`contestant_name` FROM VOTES AS T1 JOIN CONTESTANTS AS T2 ON T1.`contestant_number` = T2.`contestant_number` WHERE T2.`contestant_name` != 'Jessie Alloway'
SELECT distinct V.`state`, V.`created` FROM VOTES AS V
SELECT C.`contestant_name`, V.`contestant_number` FROM CONTESTANTS AS C JOIN VOTES AS V ON C.`contestant_number` = V.`contestant_number` WHERE V.`state` = (SELECT state FROM AREA_CODE_STATE) -- join area_code_state table to get the correct state value GROUP BY C.`contestant_number` HAVING COUNT(V.`vote_id`) >= 2;
> SELECT C.contestant_number, MIN(V.created) AS created, C.contestant_name FROM CONTESTANTS C JOIN VOTES V ON C.contestant_number = V.contestant_number GROUP BY C.contestant_number, C.contestant_name ORDER BY COUNT(V.vote_id) DESC LIMIT 1;
SELECT COUNT(*) FROM VOTES WHERE (state IN ('NY', 'CA'))
SELECT COUNT(*) FROM CONTESTANTS LEFT JOIN VOTES ON CONTESTANTS.contestant_number = VOTES.contestant_number WHERE STATE IS NULL;
SELECT area_code FROM AREA_CODE_STATE WHERE state="<your_state>";
SELECT V.created, V.state, V.phone_number FROM VOTES V JOIN CONTESTANTS C ON V.contestant_number = C.contestant_number WHERE C.`contestant_name` = 'Tabatha Gehling';
-- New query based on constraints SELECT DISTINCT V.state, AC.area_code FROM VOTES AS V JOIN AREA_CODE_STATE AS AC ON V.state = AC.state -- join V and AC first, since we need state info WHERE (V.contestant_number IN ( SELECT T2.contestant_number FROM CONTESTANTS AS T2 WHERE (T2.contestant_name = 'Tabatha Gehling' OR T2.contestant_name = 'Kelly Clauss') -- move where condition in subquery for better performance and clear meaning of what was queried )) AND V.state IS NOT NULL; -- remove NONE votes by applying 'IS NOT NULL'
SELECT `contestant_name` FROM CONTESTANTS WHERE `contestant_name` LIKE '%Al%'
SELECT Name FROM country WHERE IndepYear > '1950'
SELECT `Name` FROM country WHERE IndepYear > 1950;
error: No SQL found in the input string
SELECT COUNT(DISTINCT Code) FROM country WHERE GovernmentForm = 'Republic'
error: No SQL found in the input string
SELECT SUM(T1.SurfaceArea) AS total_surface_area FROM country AS T1 WHERE T1.Region = 'Caribbean'
SELECT `Continent` FROM country WHERE Name = 'Zimbabwe'
SELECT T1.`Continent` FROM country AS T1 JOIN city AS T2 ON T1.`Code` = T2.`CountryCode` WHERE T2.`Name` = 'Anguilla'
SELECT T2.`District` FROM (`city`) AS T1 INNER JOIN country AS T4 ON T4.Name = 'Afghanistan' INNER JOIN `country` AS T3 ON T3.Code = T4.Code INNER JOIN city AS T2 ON T2.`CountryCode` = T4.Code WHERE T2.`Name` = 'Kabul';
SELECT c.Name FROM city AS c INNER JOIN country AS cp ON c.CountryCode = cp.Code WHERE c.Name LIKE 'Kabul' LIMIT 1;
SELECT Language FROM countrylanguage WHERE IsOfficial = 'T' AND Percentage = (SELECT MAX(Percentage) FROM countrylanguage)
SELECT Language FROM countrylanguage WHERE CountryCode = 'AW';
SELECT c.Population, co.LifeExpectancy FROM country AS c JOIN countrylanguage as cl ON c.Code = cl.CountryCode JOIN country AS co ON c.Name LIKE '%Brazil%' AND c.Code = co.Code;
error: No SQL found in the input string
SELECT T1.`Region`, T2.`Population` FROM country AS T1 JOIN city AS T2 ON T2.`CountryCode` = T1.`Code` WHERE T1.`Code` = 'AO'
SELECT Region, Population FROM country WHERE Name = 'Angola'
SELECT AVG(lifeexpectancy) AS average_life_expectancy FROM country WHERE CODE IN ('GW', 'GA', 'GV') AND Continent = 'Africa' AND Region = 'Central Africa'
-- Corrected SQL query SELECT AVG(T1.`LifeExpectancy`) FROM country AS T1 JOIN city ON T1.Code = city.`CountryCode` AND (`Region` LIKE "%Central%" OR `Continent` LIKE "%Africa")
SELECT T1.Name FROM country T1 JOIN city T2 ON T1.Code = T2.CountryCode WHERE CONTINENT IN ('Asia') AND LifeExpectancy IN (SELECT MIN(LifeExpectancy) FROM country WHERE CONTINENT = 'Asia') ORDER BY LifeExpectancy DESC;
SELECT T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.Continent = 'Asia' AND T2.IsOfficial = 'T' AND T1.LifeExpectancy IS NOT NULL ORDER BY T1.LifeExpectancy ASC LIMIT 1;
SELECT CL.`Language`, SUM(C.Population) AS Total_Population, MAX(C.GNP) AS Max_GNP FROM country C JOIN countrylanguage CL ON C.Code = CL.CountryCode WHERE C.Continent = 'Asia' GROUP BY CL.`Language`
SELECT SUM(c.Population), MAX(co.GNP) FROM city c JOIN country co ON c.CountryCode = co.Code AND co.Continent = 'Asia';
error: No SQL found in the input string
SELECT AVG(T1.`LifeExpectancy`) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.`Code` = T2.`CountryCode` WHERE T1.`Continent` = 'Africa' AND T1.`GovernmentForm` LIKE '%Republic%'
SELECT COALESCE(T1.SurfaceArea, 0) + COALESCE(T2.SurfaceArea, 0) FROM ( SELECT * FROM country WHERE Continent IN ('Asia', 'Europe') ) AS T1 LEFT JOIN ( SELECT * FROM country WHERE Continent = 'World' -- or any other category to exclude duplicate continents. ) AS T2 ON T1.Code = T2.Code
SELECT SUM(T1.SurfaceArea) AS total_surface_area FROM country AS T1 WHERE T1.Continent IN ('Asia', 'Europe');
SELECT COUNT(T1.`Population`) AS cnt FROM city AS T1 WHERE T1.`District` = 'Gelderland'
SELECT SUM(`Population`) FROM city WHERE District = 'Gelderland'
SELECT AVG(T1.`GNPOld`), SUM(T1.`Population`) FROM country AS T1 WHERE T1.`GovernmentForm` = 'Territory of the USA'
-- Type: SQL SELECT AVG(T1.GNP) AS mean_GNP, SUM(CASE WHEN T2.District = 'North America' THEN T2.Population END) OVER (PARTITION BY NULL) AS total_Population FROM country T1 JOIN city T2 ON T2.CountryCode = T1.Code;
SELECT COUNT(DISTINCT `Language`) FROM countrylanguage
SELECT COUNT(DISTINCT Language) FROM countrylanguage;
SELECT COUNT(DISTINCT GovernmentForm) FROM country WHERE Continent = 'Africa'
SELECT COUNT(DISTINCT T1.`GovernmentForm`) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.`Code` = T2.`CountryCode` WHERE T1.`Continent` = 'Africa';
SELECT COUNT(DISTINCT Language) FROM countrylanguage WHERE CountryCode = 'AW'
SELECT COUNT(*) FROM countrylanguage WHERE CountryCode = 'AW'
SELECT COUNT(*) as "Number of official languages" FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code WHERE name='Afghanistan' AND IsOfficial='T';
SELECT COUNT(*) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.`Code` = T2.`CountryCode` WHERE T1.Name LIKE 'Afghanistan' AND T2.IsOfficial LIKE 'F';
SELECT c.Name AS CountryName, cl.Language AS Language FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code GROUP BY cl.CountryCode ORDER BY COUNT(*) DESC LIMIT 1;
SELECT T3.`Name`, COUNT(T1.`CountryCode`) FROM countrylanguage AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code LEFT JOIN city AS T3 ON T2.`Capital` = T3.Name GROUP BY T3.Name ORDER BY COUNT(*) DESC LIMIT 7
SELECT T1.Continent FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Continent ORDER BY COUNT(DISTINCT T2.Language) DESC, T1.Continent ASC LIMIT 1;
SELECT c.`Continent` AS `Continent`, SUM(cl.`Percentage`) AS `Total Percentage` FROM country AS c JOIN countrylanguage AS cl ON c.`Code` = cl.`CountryCode` GROUP BY c.`Continent` ORDER BY SUM(cl.`Percentage`) DESC LIMIT 1;
SELECT COUNT(DISTINCT cl.CountryCode) FROM countrylanguage cl INNER JOIN country cc ON cl.CountryCode = cc.Code WHERE cl.Language IN ('English', 'Dutch');
SELECT COUNT(DISTINCT CountryCode) FROM countrylanguage WHERE (Language = 'English' OR Language = 'Dutch') AND IsOfficial = 'T'
error: No SQL found in the input string
SELECT T1.`Name`, T3.`Language` FROM country AS T1 JOIN countrylanguage AS T2 ON T1.`Code` = T2.`CountryCode` JOIN countrylanguage AS T3 ON T1.`Code` = T3.`CountryCode` AND T2.Language='English' AND T3.Language='French'
SELECT DISTINCT name FROM country WHERE code IN ( SELECT countrycode FROM countrylanguage WHERE language = 'english' AND isofficial = 'F' ) or code IN ( SELECT countrycode FROM countrylanguage WHERE language = 'french' AND isofficial = 'F' )
SELECT DISTINCT T1.Name FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language IN ('English', 'French') AND T2.IsOfficial = 'T'
SELECT COUNT(DISTINCT T1.Continent) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language != 'Chinese' AND T2.IsOfficial = 'F'
SELECT COUNT(DISTINCT Continent) FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE Language = 'Chinese'
SELECT country.`Region`, countrylanguage.`Language` FROM country JOIN countrylanguage ON country.`Code` = countrylanguage.`CountryCode` WHERE countrylanguage.`Language` IN ('English', 'Dutch');
SELECT Region FROM country WHERE Code IN ( SELECT `Language` FROM countrylanguage WHERE `IsOfficial`='T' AND `Language`='Dutch' UNION SELECT `Language` FROM countrylanguage WHERE `IsOfficial`='T')
SELECT T2.Name FROM countrylanguage AS T1 JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE (Language = "English") OR (Language = "Dutch") AND IsOfficial = "T"
SELECT DISTINCT c.Name FROM country AS c INNER JOIN countrylanguage AS cl ON c.Code = cl.CountryCode WHERE cl.Language IN ('English', 'Dutch')
error: No SQL found in the input string
SELECT Language FROM countrylanguage l JOIN country c ON l.CountryCode = c.Code WHERE c.Continent = 'Asia' GROUP BY l.Language ORDER BY COUNT(c.Code) DESC, l.Language ASC LIMIT 1;
SELECT `Language` FROM countrylanguage WHERE (`Percentage`>0 AND `CountryCode` NOT IN ( SELECT `Code` FROM country WHERE `GovernmentForm`= 'Republic' EXCEPT SELECT `CountryCode` FROM countrylanguage))
SELECT Language FROM countrylanguage AS T1 JOIN country AS T2 ON T1.CountryCode = T2.Code GROUP BY Language HAVING COUNT(T2.Code) = 1 AND T2.`GovernmentForm` = 'Republic'
SELECT `Name`, c1.'Population' FROM city AS c1 INNER JOIN countrylanguage AS c2 ON c1.`CountryCode` = c2.`CountryCode` WHERE c2.language = 'English' ORDER BY c1.Population DESC LIMIT 1;
SELECT Name FROM ( SELECT city.Name, city.Population, ROW_NUMBER() OVER(PARTITION BY MAX(countrylanguage.Percentage)) AS group_num FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode JOIN city ON city.CountryCode = country.Code AND Language = 'English' ) t1 WHERE group_num = 1;
SELECT c.`Name`, c.`Population`, c.`LifeExpectancy` FROM country AS c WHERE c.`Continent` = 'Asia' AND c.`SurfaceArea` = (SELECT MAX(`SurfaceArea`) FROM country)
SELECT C.Name, C Population, C.LifeExpectancy FROM country AS C WHERE C.Continent = 'Asia' ORDER BY C.SurfaceArea DESC;
SELECT AVG(T3.LifeExpectancy) AS 'Average Life Expectancy' FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode JOIN country AS T3 WHERE T2.IsOfficial='F' AND T3.LifeExpectancy IS NOT NULL;
SELECT AVG(T1.`LifeExpectancy`) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.`Code` = T2.`CountryCode` WHERE T2.`IsOfficial` != 'F' AND T2.`Language` = 'English'
SELECT COALESCE(SUM(T2.Percentage), 0) FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language <> 'English'
error: No SQL found in the input string
-- Step 1: Correct the view creation query to fetch all columns needed for further execution CREATE VIEW head_of_states AS SELECT country.Code, country.HeadOfState FROM country; -- Step 2: Use the correct join, selecting required columns and ordering results by HeadOfState before filtering Beatrix's head of state SELECT language, IsOfficial FROM ( SELECT T1.`Language`, T1.IsOfficial FROM country AS T1 INNER JOIN `countrylanguage` AS T2 ON T1.Code = T2.CountryCode /* Join table country with country language and pick needed columns */ ORDER BY T1.HeadOfState ) AS language WHERE HeadOfState LIKE '%Beatrix%' /* If found in head of states view, use this logic instead*/ LIMIT 1; -- Step 3: Create a view from the filtered results CREATE VIEW beatrix_official_languages AS SELECT language, IsOfficial FROM ( SELECT T1.`Language`, T1.IsOfficial FROM country AS T1 INNER JOIN `countrylanguage` AS T2 ON T1.Code = T2.CountryCode /* Join table country with country language and pick needed columns */ ORDER BY T1.HeadOfState ) AS language WHERE HeadOfState LIKE '%Beatrix%' /* If found in head of states view, use this logic instead*/ LIMIT 1; -- Step 4: Finally, execute the view created above using beatrix_official_languages view to fetch official languages SELECT code FROM head_of_states AS T1 INNER JOIN beatrix_official_languages AS T2 ON T1.Code = T1.Code WHERE T1.HeadOfState LIKE '%Beatrix%' /* If found in head of states view, use this logic instead*/ LIMIT 1; -- Step 5: Drop the views created above. DROP VIEW head_of_states; DROP VIEW beatrix_official_languages;
SELECT cl.`Language`, cl.`Percentage` FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE c.`HeadOfState` = 'Beatrix' AND cl.`IsOfficial` = 'T';
error: No SQL found in the input string
SELECT COUNT(*) FROM ( SELECT Code, GROUP_CONCAT(DISTINCT Language) as languages FROM ( SELECT C1.Code, CL.Language FROM country C1 JOIN countrylanguage CL ON C1.Code = CL.CountryCode WHERE C1.IndepYear < 1930 AND CL.IsOfficial = 'T' ) AS temp GROUP BY Code ) t;
error: No SQL found in the input string
SELECT Name, SurfaceArea FROM country WHERE SurfaceArea > (SELECT MAX(SurfaceArea) FROM country WHERE Continent = 'Europe')
SELECT COUNT(*) FROM ( SELECT Name FROM country WHERE Continent = 'Africa' AND Population < ( SELECT MIN(Population) FROM country WHERE Continent = 'Asia' ) ) as t
SELECT c.Name FROM country AS c JOIN countrylanguage AS cl ON c.Code = cl.CountryCode WHERE c.Continent = 'Africa' AND c.Population < ( SELECT MIN(c2.Population) FROM country c2 WHERE c2.Continent = 'Asia' )
SELECT Name FROM country WHERE Continent = 'Asia' AND Population > (SELECT MAX(Population) FROM country WHERE Continent = 'Africa')
SELECT DISTINCT T1.Name FROM country AS T1 JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T1.Continent = 'Asia' AND T1.Population > (SELECT MIN(T3.Population) FROM country AS T3 WHERE T3.Continent = 'Africa')
SELECT CountryCode FROM countrylanguage WHERE Language != 'English' AND NOT IsOfficial = 'T'
SELECT `Code` FROM country WHERE `Code` NOT IN ( SELECT `CountryCode` FROM countrylanguage WHERE `Language` = 'English' )
-- Select the country codes of countries where people use languages other than English. SELECT DISTINCT C.`Code` FROM country AS `C` JOIN countrylanguage AS `CL` ON C.`Code` = CL.`CountryCode` WHERE `Language` != 'English';
SELECT DISTINCT T1."Code" FROM country AS T1 JOIN countrylanguage AS T2 ON T1."Code" = T2."CountryCode" WHERE T2."Language" != "English"
SELECT code2 FROM country WHERE GovernmentForm != 'Republic' AND code NOT IN ( SELECT CountryCode FROM countrylanguage WHERE Language = 'English' )
SELECT `Code` FROM country WHERE NOT EXISTS ( SELECT 1 FROM countrylanguage WHERE LANGUAGE = 'English' AND CountryCode = Code ) AND GovernmentForm <> 'Republic'
SELECT Name FROM city WHERE CountryCode IN (SELECT Code FROM country WHERE Continent = 'asia' OR Continent = 'africa') AND ID NOT IN (SELECT ID FROM countrylanguage WHERE IsOfficial = 'f')
error: No SQL found in the input string
SELECT T1.`Name`, COUNT(T3.`Language`) FROM city AS T1 INNER JOIN country AS T2 ON T1.`CountryCode` = T2.`Code` INNER JOIN countrylanguage AS T3 ON T2.`Code` = T3.`CountryCode` WHERE T2.`Continent` = 'Asia' AND T3.`IsOfficial`= 'F' AND T3.Language = 'Chinese'
SELECT DISTINCT T1.Name FROM city AS T1 JOIN country AS T2 ON T1.CountryCode = T2.Code JOIN countrylanguage AS T3 ON T2.Code = T3.CountryCode WHERE T3.Language = 'Chinese' AND T2.Region = 'Asia'
-- Corrected SQL SELECT T2.Name, T1.IndependYear, T1.SurfaceArea FROM country AS T1 JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T2.Population IS NOT NULL ORDER BY T2.Population ASC LIMIT 1;
-- Give the name, year of independence, and surface area of the country that has the lowest population. SELECT c.Name, c.SurfaceArea, c.IndepYear FROM (SELECT Code, Name, `IndepYear`, SurfaceArea FROM country ORDER BY Population ASC LIMIT 1) c;
error: No SQL found in the input string
SELECT c.Name, c.Population, c.HeadOfState FROM country AS c WHERE c.SurfaceArea = ( SELECT MAX(a.SurfaceArea) FROM country AS a )
SELECT c.Name, COUNT(cl.Language) as Number_of_languages FROM country AS c JOIN countrylanguage AS cl ON c.Code = cl.CountryCode GROUP BY c.Name HAVING COUNT(cl.Language) >= 3
SELECT C.`Name`, COUNT(DISTINCT CL1.Language) FROM country AS C JOIN ( SELECT `CountryCode`, MAX(SUM(`percentage`)/COUNT(*)) as max_percentage FROM countrylanguage GROUP BY `CountryCode` ) AS MAX_PER_COUNTRY ON C.Code = MAX_PER_COUNTRY.CountryCode INNER JOIN countrylanguage AS CL1 ON CL1.`CountryCode` = C.`Code` GROUP BY C.Name, MAX_PER_COUNTRY.CountryCode HAVING SUM(CL1.Percentage) > 2 * MAX_PER_COUNTRY.max_percentage
SELECT District, COUNT(*) FROM city AS T1 JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T1.Population > ( SELECT AVG(Population) FROM city ) GROUP BY District;
SELECT T1.District, COUNT(*) as numCities FROM city AS T1 GROUP BY T1.District HAVING SUM(Population) > (SELECT AVG(Population) FROM city)
SELECT T1.`GovernmentForm` AS `Government Form Name`, SUM(T2.`Population`) AS `Total Population` FROM country AS T1 JOIN city AS T2 ON T2.`CountryCode` = T1.`Code` JOIN ( SELECT c.`GovernmentForm`, AVG(COALESCE(c.`LifeExpectancy`, 0)) -- Use COALESCE to replace NULLs with a safe default value (in this case, zero) FROM country c GROUP BY c.`GovernmentForm` ) AS GovernmentAVG ON T1.`GovernmentForm` = GovernmentAVG.`GovernmentForm` WHERE GovernmentAVG.`LifeExpectancy` > 72 GROUP BY T2.`District`, T1.`GovernmentForm` ORDER BY SUM(T2.`Population`) DESC;
error: No SQL found in the input string
SELECT T3.`Continent`, AVG(T3.`LifeExpectancy`) AS avg_life_expectancy, SUM(T1.Population) AS total_population FROM country AS T1 JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode JOIN country AS T3 ON T1.Code = T3.Code WHERE T2.IsOfficial = 'F' AND T3.LifeExpectancy < 72 GROUP BY T3.`Continent` ORDER BY avg_life_expectancy ASC;
SELECT `Continent`, SUM(`Population`) AS total_population, AVG(`LifeExpectancy`) AS average_life_expectancy FROM country WHERE `LifeExpectancy` < '72' GROUP BY `Continent`
SELECT Name, SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 5;
-- Return the names and surface areas of the 5 largest countries. SELECT c.Name, c.SurfaceArea AS surfacearea FROM country c JOIN ( SELECT Code, SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 1 OFFSET 4 ) t2 ON c.Code = t2.Code;
SELECT c.Name, countrylanguage.Language FROM city AS c JOIN country ON c.CountryCode = country.Code JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE country.Population >= ( SELECT MAX(Population) FROM city );
SELECT Name FROM country ORDER BY Population DESC LIMIT 3;
SELECT * FROM ( SELECT Name, Population, DENSE_RANK() OVER (ORDER BY Population) AS PopRank FROM country ) T WHERE PopRank = 3
SELECT `Name`, Population FROM country ORDER BY Population LIMIT 3;
SELECT SUM(CASE WHEN Continent = 'Asia' THEN 1 ELSE 0 END) FROM country;
SELECT COUNT(*) FROM country WHERE Continent = 'Asia'
SELECT c.Name FROM country c JOIN city ci ON c.Code = ci.CountryCode WHERE c.Continent = 'Europe' GROUP BY c.Name HAVING SUM(ci.Population) == 80000;
SELECT Name FROM country WHERE Continent = 'Europe' AND Population = 80000;
error: No SQL found in the input string
SELECT SUM(`Population`) AS `Total Population`, AVG(`SurfaceArea`) AS `Average Surface Area` FROM country WHERE `Region` = 'North America' AND `SurfaceArea` > 3000;
SELECT `Name` FROM city WHERE Population BETWEEN 160000 AND 900000
SELECT `Name` FROM city WHERE Population BETWEEN 160000 AND 900000
SELECT Language, COUNT(DISTINCT CountryCode) num_of_countries FROM countrylanguage WHERE Percentage IN ( SELECT MAX(Percentage) FROM countrylanguage ) GROUP BY LANGUAGE;
SELECT Language FROM countrylanguage GROUP BY Language ORDER BY COUNT(Language) DESC LIMIT 1
SELECT c.*, cl.`Language`, ( SELECT cl2.`Language` FROM countrylanguage cl2 WHERE cl2.`CountryCode` = c.`Code` AND cl2.Percentage = ( SELECT MAX(cl3.Percentage) FROM countrylanguage cl3 WHERE cl3.`CountryCode` = c.`Code`) ) AS dominant_language FROM country c LEFT JOIN countrylanguage cl ON c.Code = cl.CountryCode
SELECT c.Code, cl.Language FROM country c JOIN ( SELECT CountryCode, Language, Percentage, ROW_NUMBER() OVER(PARTITION BY CountryCode ORDER BY Percentage DESC) AS pck FROM countrylanguage WHERE NOT IsOfficial AND Percentage IS NOT NULL ) cl ON c.Code = cl.CountryCode WHERE cl.pck = 1;
SELECT COUNT(*) AS Total_Spanish_Talking_Countries FROM countrylanguage WHERE Language = 'Spanish' AND Percentage = ( SELECT MAX(Percentage) FROM countrylanguage WHERE Language = 'Spanish' ) ;
SELECT COUNT(DISTINCT `CountryCode`) FROM countrylanguage WHERE `IsOfficial` = 'T' AND `Language` = 'Spanish'
SELECT country.`Code` FROM countrylanguage JOIN country ON countrylanguage.`CountryCode` = country.`Code` WHERE Language = 'Spanish' ORDER BY Percentage DESC LIMIT 1;
SELECT DISTINCT CountryCode FROM countrylanguage WHERE Percentage = ( SELECT MAX(Percentage) FROM countrylanguage )
error: No SQL found in the input string
SELECT COUNT(*) FROM conductor;
SELECT Name FROM conductor ORDER BY Age ASC;
SELECT Name FROM conductor ORDER BY Age ASC
SELECT Name FROM conductor WHERE Nationality != 'USA'
SELECT `Name` FROM conductor WHERE Nationality != 'USA'
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC;
SELECT o.`Record_Company`, c.`Year_of_Founded` FROM `orchestra` o JOIN `conductor` c ON o.`Conductor_ID` = c.`Conductor_ID` ORDER BY c.`Year_of_Founded` DESC;
SELECT AVG(Attendance) FROM show;
SELECT AVG(T3.Attendance) AS average_attendance FROM performance AS T1 JOIN orchestra AS T2 ON T1.Orchestra_ID = T2.Orchestra_ID JOIN show AS T3 ON T1.Performance_ID = T3.Performance_ID;
SELECT MAX(`Official_ratings_(millions)`) - MIN(`Official_ratings_(millions)`) FROM performance WHERE `Type` != 'Live final';
SELECT MAX(Share) AS Max_Share, MIN(Share) AS Min_Share FROM performance WHERE Type != 'Live final'
error: No SQL found in the input string
SELECT COUNT(DISTINCT Nationality) FROM conductor
SELECT Name FROM conductor ORDER BY Year_of_Work DESC;
SELECT `Name`, `Year_of_Work` FROM conductor GROUP BY `Conductor_ID` ORDER BY SUM(`Year_of_Work`) DESC;
SELECT `Name` FROM conductor WHERE `Year_of_Work` = (SELECT MAX(`Year_of_Work`) FROM conductor)
SELECT Name, SUM(Year_of_Work) AS Total_Years FROM ( SELECT c.Name,c.Year_of_Work FROM conductor AS c JOIN orchestra AS o ON c.`Conductor_ID` = o.`Conductor_ID` GROUP BY c.Name ) GROUP BY Name ORDER BY Total_Years DESC;
SELECT T1.Name, T2.Orchestra FROM conductor AS T1 JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID;
SELECT DISTINCT T1.Name, T2.Orchestra FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.`Conductor_ID` = T2.`Conductor_ID` INNER JOIN performance AS T3 ON T2.`Orchestra_ID` = T3.`Orchestra_ID`;
SELECT `Name`, COUNT(*) FROM conductor AS T1 JOIN orchestra AS T2 ON T1.`Conductor_ID` = T2.`Conductor_ID` GROUP BY T1.`Conductor_ID`, T1.`Name` HAVING COUNT(*) > 1
error: No SQL found in the input string
SELECT C.Name FROM conductor AS C JOIN orchestra AS O ON C.Conductor_ID = O.Conductor_ID GROUP BY C.Conductor_ID ORDER BY COUNT(C.Conductor_ID) DESC LIMIT 1
SELECT Name FROM conductor JOIN (SELECT Conductor_ID FROM orchestra GROUP BY Conductor_ID ORDER BY COUNT(*) DESC LIMIT 1) T ON conductor.`Conductor_ID` = T.`Conductor_ID`
error: No SQL found in the input string
SELECT `Name` FROM conductor WHERE Year_of_Work IN (SELECT Year_of_Founded FROM orchestra WHERE Year_of_Founded > 2008)
SELECT o.Record_Company AS Company, COUNT(o.Conductor_ID) FROM orchestra o GROUP BY o.Record_Company
SELECT T1.`Record_Company`, COUNT(T1.`Orchestra_ID`) as Orchestra_Count FROM orchestra AS T1 INNER JOIN performance AS T2 ON T1.`Orchestra_ID` = T2.`Orchestra_ID` GROUP BY T1.`Record_Company`
SELECT Major_Record_Format, COUNT(*) FROM orchestra GROUP BY Major_Record_Format ORDER BY COUNT(*) ASC;
SELECT `Major_Record_Format`, COUNT(*) as Count FROM orchestra GROUP BY `Major_Record_Format` ORDER BY Count DESC;
error: No SQL found in the input string
SELECT Record_Company, COUNT(Orchestra) FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC LIMIT 1;
SELECT `Orchestra` FROM orchestra WHERE Orchestra_ID NOT IN (SELECT `Orchestra_ID` FROM performance)
SELECT `Orchestra`, COUNT(*) FROM orchestra JOIN performance ON orchestra.`Conductor_ID` = performance.`Orchestra_ID` GROUP BY `Orchestra` HAVING COUNT(*) = 0;
-- Show the record companies shared by orchestras founded before 2003 and after 2003. SELECT DISTINCT a.Record_Company FROM orchestra a JOIN ( SELECT Record_Company FROM orchestra WHERE YEAR_of_Founded < 2003 UNION ALL SELECT Record_Company FROM orchestra WHERE YEAR_of_Founded > 2003 ) b ON a.Record_Company = b.Record_Company;
SELECT DISTINCT T1.`Record_Company` FROM orchestra AS T1 JOIN conductor AS T2 ON T1.`Conductor_ID` = T2.`Conductor_ID` WHERE (T1.`Year_of_Founded` < 2003 OR T1.`Year_of_Founded` > 2003) AND EXISTS ( SELECT T4.`Show_ID` FROM performance AS T3 JOIN show AS T4 ON T3.`Performance_ID` = T4.`Performance_ID` WHERE T3.`Orchestra_ID` = T1.`Orchestra_ID` AND T2.`Year_of_Work` = (SELECT MAX(`Year_of_Work`) FROM conductor) );
SELECT COUNT(Orchestra_ID) FROM orchestra WHERE Major_Record_Format IN ('CD', 'DVD')
SELECT COUNT(*) FROM orchestra WHERE Major_Record_Format LIKE '%CD%' OR Major_Record_Format LIKE '%DVD%'
SELECT O.`Year_of_Founded` FROM orchestra AS O INNER JOIN performance AS P ON P.`Orchestra_ID` = O.`Orchestra_ID` GROUP BY O.`Year_of_Founded` HAVING COUNT(P.`Performance_ID`) > 1
SELECT `Year_of_Founded` FROM orchestra WHERE Orchestra_ID IN ( SELECT Orchestra_ID FROM performance GROUP BY Orchestra_ID HAVING COUNT(Performance_ID) > 1 )
SELECT COUNT(*) FROM Highschooler
SELECT COUNT(*) FROM Highschooler;
SELECT name, grade FROM `Highschooler`
SELECT name, grade FROM Highschooler;
SELECT DISTINCT grade FROM Highschooler;
-- What is the grade of each high schooler? SELECT grade FROM Highschooler;
error: No SQL found in the input string
SELECT grade FROM Highschooler WHERE name = 'Kyle'
SELECT name FROM Highschooler WHERE grade = 10;
SELECT name FROM Highschooler WHERE grade = 10;
SELECT `ID` FROM Highschooler WHERE name = 'Kyle'
SELECT `ID` FROM highschooler WHERE `name` = 'Kyle'
SELECT COUNT(*) FROM Highschooler WHERE grade = 9 OR grade = 10
SELECT COUNT(*) FROM Highschooler WHERE grade IN (9, 10)
SELECT COUNT(*) FROM Highschooler GROUP BY grade
error: No SQL found in the input string
SELECT grade, COUNT(*) FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC LIMIT 1;
SELECT T2.grade, COUNT(*) AS num_highschoolers FROM Highschooler AS T1 INNER JOIN ( SELECT grade, ROW_NUMBER() OVER (ORDER BY COUNT(DISTINCT ID) DESC) AS row FROM Highschooler GROUP BY grade ) AS T2 ON T1.id = T2.grade GROUP BY T2.grade
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(grade) >= 4
SELECT `grade` FROM Highschooler GROUP BY `grade` HAVING COUNT(`ID`) >= 4
-- Show the student IDs and numbers of friends corresponding to each. SELECT h.ID, COUNT(f.student_id) AS num_friends FROM Highschooler h JOIN Friend f ON h.ID = f.student_id OR h.ID = f.friend_id GROUP BY h.ID;
SELECT T1.name, COUNT(*) FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.name UNION ALL SELECT name, 0 FROM Highschooler WHERE ID NOT IN (SELECT friend_id FROM Friend UNION SELECT student_id FROM Friend)
SELECT T1.name, COUNT(T2.friend_id) as num_friends FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.name;
SELECT T1.name, COUNT(T3.friend_id) FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id JOIN Friend AS T3 ON T1.ID = T3.friend_id GROUP BY T1.name
SELECT H1.`name` FROM Highschooler AS H1 JOIN Friend AS F ON H1.ID = F.student_id GROUP BY H1.name HAVING COUNT(DISTINCT F.friend_id) = (SELECT MAX(friend_count) FROM ( SELECT student_id, COUNT(DISTINCT friend_id) as friend_count FROM Friend GROUP BY student_id ) AS subquery) LIMIT 1;
-- Return the name of the high school student with the most friends. SELECT T3.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T3.name ORDER BY COUNT(T2.student_id) DESC LIMIT 1;
SELECT H.name, COUNT(F.student_id) AS number_of_friends FROM Highschooler H JOIN Friend F ON H.ID = F.student_id GROUP BY H.name HAVING COUNT(F.student_id) >= 3;
SELECT name FROM Highschooler WHERE ID IN ( SELECT student_id FROM Friend GROUP BY student_id HAVING COUNT(*) >= 3 )
SELECT DISTINCT F2.`name` FROM Friend AS F JOIN Highschooler AS H ON F.`student_id` = H.`ID` JOIN Highschooler AS F2 ON F.`friend_id` = F2.`ID` AND F2.`name` IS NOT NULL WHERE H.`name` = 'Kyle' -- Show the names of all of the high schooler Kyle's friends.
SELECT T3.`name` FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.`student_id` = T2.`ID` JOIN Highschooler AS T3 ON T1.`friend_id` = T3.`ID` WHERE `student_id`= (SELECT `ID` FROM `Highschooler` WHERE name = 'Kyle')
SELECT COUNT(*) FROM Friend WHERE student_id IN ( SELECT ID FROM Highschooler WHERE name = 'Kyle' )
SELECT COUNT(Friend.student_id) FROM Friend WHERE Friend.student_id = (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT ID FROM highschooler WHERE ID NOT IN ( SELECT student_id FROM Friend UNION ALL SELECT student_id FROM Likes )
SELECT ID FROM Highschooler WHERE ID NOT IN ( SELECT friend_id FROM Friend UNION SELECT student_id FROM Friend );
SELECT name FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Likes WHERE liked_id = ID OR student_id = ID)
SELECT name FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT student_id FROM Likes WHERE student_id IN (SELECT friend_id FROM Friend) AND student_id IN (SELECT liked_id FROM Likes);
SELECT DISTINCT ID FROM Highschooler WHERE ID IN ( SELECT student_id FROM Friend INTERSECT SELECT student_id FROM Likes )
SELECT T1.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id WHERE T1.ID IN (SELECT student_id FROM Likes) AND T2.friend_id != T2.student_id GROUP BY T1.name HAVING COUNT(DISTINCT T2.friend_id) > 0
SELECT name FROM Highschooler WHERE ID IN (SELECT student_id FROM Friend) AND ID IN (SELECT liked_id FROM Likes)
SELECT student_id, COUNT(*) FROM Likes GROUP BY student_id
SELECT T1.ID, COUNT(DISTINCT T3.student_id) AS like_count, COUNT(DISTINCT T2.friend_id) AS friend_count FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id JOIN Likes AS T3 ON T1.ID = T3.liked_id GROUP BY T1.ID
SELECT T1.name, COUNT(T2.liked_id) FROM Highschooler AS T1 JOIN Likes AS T2 ON T1.ID = T2.student_id GROUP BY T1.name
SELECT T1.name, COUNT(T2.student_id) FROM Highschooler AS T1 JOIN Likes AS T2 ON T1.ID = T2.liked_id GROUP BY T1.ID
SELECT `name`, COUNT(*) FROM Highschooler AS T1 JOIN Likes AS T2 ON T1.ID = T2.student_id GROUP BY T1.name ORDER BY COUNT(T2.liked_id) DESC LIMIT 1;
SELECT T1.name FROM Highschooler AS T1 JOIN Likes AS T2 ON T1.ID = T2.student_id JOIN Friend AS T3 ON T1.ID = T3.student_id GROUP BY T1.ID ORDER BY COUNT(T3.friend_id) DESC LIMIT 1
SELECT name FROM Highschooler WHERE ID IN (SELECT liked_id FROM Likes GROUP BY liked_id HAVING COUNT(*) >= 2)
SELECT name FROM Highschooler WHERE ID IN ( SELECT student_id FROM Likes GROUP BY student_id HAVING COUNT(*) >= 2 )
SELECT name FROM Highschooler WHERE grade > 5 AND ID IN ( SELECT student_id FROM Friend GROUP BY student_id HAVING COUNT(*) >= 2 )
SELECT H1.name, COUNT(*) as friend_count FROM Highschooler H1 JOIN Friend F ON H1.ID = F.student_id WHERE H1.ID IN (SELECT ID FROM Highschooler WHERE grade > 5) GROUP BY H1.name HAVING COUNT(*) >= 2
SELECT COUNT(T1.`liked_id`) FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.`liked_id` = T2.`ID` WHERE T2.`name` = 'Kyle'
SELECT COUNT(*) FROM Likes WHERE student_id IN ( SELECT ID FROM Highschooler WHERE name = 'Kyle' )
SELECT AVG(grade) FROM Highschooler WHERE ID IN (SELECT student_id FROM Friend)
SELECT H.grade FROM Highschooler AS H LEFT JOIN Friend AS F1 ON H.ID = F1.student_id LEFT JOIN Friend AS F2 ON H.ID = F2.friend_id GROUP BY H.id, F1.student_id, F2.friend_id HAVING COUNT(DISTINCT H.id) > 0
SELECT MIN(grade) FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT DISTINCT `grade` FROM Highschooler AS G1 WHERE NOT EXISTS (SELECT 1 FROM Friend AS F WHERE F.friend_id = G1.ID);
error: No SQL found in the input string
SELECT DISTINCT Owners.state FROM Owners WHERE EXISTS ( SELECT * FROM Professionals WHERE state = Owners.state );
error: No SQL found in the input string
error: No SQL found in the input string
SELECT p.professional_id, p.last_name, p.cell_number FROM Professionals p INNER JOIN Treatments t ON p.professional_id = t.professional_id GROUP BY p.professional_id, p.last_name, p.cell_number HAVING COUNT(t.treatment_id) > 2 UNION SELECT p.professional_id, p.last_name, p.cell_number FROM Professionals p WHERE p.state = 'Indiana';
import sqlite3 # Connect to SQLite database. The database will be created if it doesn't already exist. con = sqlite3.connect('example.db') # Create a cursor object cur = con.cursor() # Define the SQL statements in separate functions def create_tables(): cur.execute(''' CREATE TABLE IF NOT EXISTS Breeds ( breed_code INT PRIMARY KEY, breed VARCHAR(255) ) ''') cur.execute(''' CREATE TABLE IF NOT EXISTS Sizes ( size_code INT PRIMARY KEY, size VARCHAR(10) ) ''') cur.execute(''' CREATE TABLE IF NOT EXISTS Dogs ( dog_id INT PRIMARY KEY, breed_code INT references Breeds(breed_code), age INT, date_of_birth DATE, gender VARCHAR(10), weight DECIMAL(10,5) ) ''') cur.execute(''' CREATE TABLE IF NOT EXISTS Professionals ( professional_id INT PRIMARY KEY, role_code VARCHAR(10), first_name VARCHAR(50), street VARCHAR(255), city VARCHAR(100), state VARCHAR(100), zip_code INT, last_name VARCHAR(50), email_address VARCHAR(255), home_phone VARCHAR(15), cell_number VARCHAR(15) ) ''') cur.execute(''' CREATE TABLE IF NOT EXISTS Treatment_Types ( treatment_type_code VARCHAR(25) PRIMARY KEY, trademark VARCHAR(100) ) ''') cur.execute(''' CREATE TABLE IF NOT EXISTS Treatments ( treatment_id INT PRIMARY KEY, dog_id INT references Dogs(dog_id), professional_id INT references Professionals(professional_id), treatment_type_code VARCHAR(25) references Treatment_Types(treatment_type_code), date_of_treatment DATE, cost_of_treatment DECIMAL(10,0) ) ''') def insert_values(): cur.execute(''' INSERT INTO Breeds (breed_code, breed) SELECT TempTable.breed_code , 'Other' || TempTable.breed_code FROM ( VALUES (25, ''), (100, '') ) AS TempTable(breed_code , '') ''') cur.execute(''' INSERT INTO Sizes (size_code, size) SELECT TempSIZE.size_code , 'Puppy' FROM (SELECT 1 AS size_code) AS TempSIZE UNION SELECT TempSIZE.size_code , 'Doggy' FROM (SELECT 2 AS size_code) AS TempSIZE ''') cur.execute(''' INSERT INTO Dogs (dog_id, breed_code, age, date_of_birth, gender, weight) VALUES (18, 25, 9, '2018-03-17', '0', 5.23), (7, 100, 2, '2018-01-17', '1', 6.88) ''') cur.execute(''' INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (3, 'Employee', 'Winfield', '7284 Torphy Flats Apt. 610\nDiannaburgh, SC 78560', 'New Maryjane', 'North Carolina', '54312', 'Walter', 'marquardt@example.com', '3465943739'), (2, 'Veterenarian', 'Ruben', '7284 Torphy Flats Apt. 610\nDiannaburgh, SC 78560', 'New Maryjane', 'North Carolina', '54312', 'O''Reilly', 'marquardt@example.com', '3122163352') ''') cur.execute(''' INSERT INTO Treatment_Types (treatment_type_code, trademark) VALUES ('Vaccination'), ('Medical Check-up') ''') cur.execute(''' INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (4 ,18, 3,'Vaccination', '2018-03-24', 945), (2, 7, NULL,'Medical Check-up','1980-01-01',NULL ), (1, 5 ,3 ,'Vaccination', '2022-01-01', 100.00 ) ''') # Define the SQL query used for joining the tables def create_query(): query = ''' SELECT Sizes.size AS size, Dogs.gender, Breed.breed, Treatment_Types.trademark AS treatment_type FROM Breeds Breed JOIN Treatments ON Breed.breed_code = CAST(Treatments.treatment_id - 1 AS INT) JOIN Treatment_Types ON CAST(Treatments.treatment_id - 1 AS INT) = Treatment_Types.treatment_type_code JOIN Dogs DOGS ON CAST(Treatments.treatment_id - 1 AS INT) = Dog.breed_code JOIN Sizes SIZES ON CAST(Dogs.dog_id- 1 AS INT)=SIZES.size_code ''' return query # Define functions to create tables and insert_values create_tables() insert_values() # Fetch the joined table using a separate query query = create_query() cur.execute(query) rows = cur.fetchall() # Print fetched result for row in rows: print(row) # Close the SQLite connection con.close()
error: No SQL found in the input string
SELECT d.name FROM Dogs d JOIN Treatments t ON d.dog_id = t.dog_id WHERE t.cost_of_treatment <= 1000;
error: No SQL found in the input string
SELECT name FROM ( SELECT owner_first_name AS name FROM OWNERS WHERE owner_id IN (SELECT dog_owner_id FROM DOGS) ) AS owners_first_names;
SELECT P.professional_id, null as role_name, -- assuming you don't really care about name and can use a placeholder. P.email_address FROM Professionals AS P WHERE NOT EXISTS ( SELECT 1 FROM Treatments T WHERE T.professional_id = P.professional_id );
SELECT p.professional_id, p.role_code AS role, p.email_address FROM Professionals p LEFT JOIN Treatments t ON p.professional_id = t.professional_id WHERE t.treatment_id IS NULL;
SELECT o.owner_id, o.first_name, o.last_name FROM Owners AS o INNER JOIN Dogs AS d ON o.owner_id = d.owner_id GROUP BY o.owner_id, o.first_name, o.last_name ORDER BY COUNT(d.dog_id) DESC LIMIT 1;
SELECT o.owner_id, o.first_name, o.last_name FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id GROUP BY o.owner_id, o.first_name, o.last_name ORDER BY COUNT(d.owner_id) DESC LIMIT 1;
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT o.owner_id, o.last_name, SUM(tt.cost_of_treatment) AS total_cost FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id JOIN Treatments tt ON d.dog_id = tt.dog_id GROUP BY o.owner_id, o.last_name ORDER BY total_cost DESC LIMIT 1;
error: No SQL found in the input string
SELECT tt.description, t.cost_of_treatment FROM Treatment_Types AS tt JOIN Treatments t ON tt.treatment_type_code = t.treatment_type_code;
SELECT o.owner_id, o.zip_code, SUM(t.cost_of_treatment) AS total_spent FROM Treatments t JOIN Dogs d ON t.dog_id = d.dog_id JOIN Owners o ON d.owner_id = o.owner_id GROUP BY o.owner_id, o.zip_code ORDER BY total_spent DESC LIMIT 1;
SELECT DISTINCT o.owner_id, o.zip_code FROM Owners o WHERE o.owner_id = ( SELECT owner_id FROM Treatments GROUP BY owner_id HAVING SUM(cost_of_treatment) = (SELECT MAX(totalspent) FROM ( SELECT owner_id, SUM(cost_of_treatment) AS totalspent FROM Treatments GROUP BY owner_id ) as spending) );
SELECT P.professional_id, P.cell_number FROM Professionals P JOIN ( SELECT T.professional_id, COUNT(*) as treatment_count FROM Treatments T GROUP BY T.professional_id HAVING COUNT(*) >= 2 ) AS T ON P.professional_id = T.professional_id;
SELECT P.professional_id, P.cell_number FROM Professionals P JOIN Treatments T ON P.professional_id = T.professional_id GROUP BY P.professional_id HAVING COUNT(T.treatment_id) >= 2;
error: No SQL found in the input string
SELECT T1.first_name, T1.last_name FROM Professionals AS T1 INNER JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id WHERE T2.cost_of_treatment < (SELECT AVG(cost_of_treatment) FROM Treatments);
SELECT T.date_of_treatment, P.first_name FROM Treatments AS T JOIN Professionals AS P ON T.professional_id = P.professional_id;
SELECT DISTINCT T1.date_of_treatment, P.first_name FROM Treatments AS T1 JOIN Professionals AS P ON T1.professional_id = P.professional_id;
SELECT T1.cost_of_treatment, T2.treatment_type_description FROM Treatments AS T1 JOIN Treatment_Types AS T2 ON T1.treatment_type_code = T2.treatment_type_code;
SELECT t.treatment_id, t.cost_of_treatment, tt.description AS treatment_type_description, d.owner_name, p.name AS professional_name, d.date_of_birth FROM treats t -- Corrected Join to Join all Table Together. INNER JOIN dogs d ON t.dog_id = d.dog_id INNER JOIN breeds b ON d.breed_code = b.breed_code INNER JOIN sizes s ON d.size_code = s.size_code INNER JOIN professionals p ON t.professional_id = p.professional_id;
SELECT o.first_name AS Owner_First_Name, o.last_name AS Owner_Last_Name, CASE s.size_code WHEN 'Small' THEN 'Small' WHEN 'Medium' THEN 'Medium' WHEN 'Large' THEN 'Large' END AS dog_size FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id JOIN Sizes s ON d.size_code = s.size_code;
SELECT O.first_name AS Owner_First_Name, O.last_name AS Owner_Last_Name, Br.size As Breed_Description, Sz.breed As Size_Name FROM Owners AS O INNER JOIN Dogs AS D ON O.owner_id = D.owner_id INNER JOIN Breeds AS Br ON D.breed_code = Br.breed_code INNER JOIN Sizes AS Sz ON D.size_code = Sz.size_code
SELECT Owners.first_name, Dogs.name FROM Owners INNER JOIN Dogs ON Owners.owner_id = Dogs.owner_id;
error: No SQL found in the input string
-- Table 1: with rare_dogs as ( select distinct breed_name from dogs join Breeds on breeds.breed_code = dogs.breed_code group by breed_name having count(*) =1 ) -- Query to get names of the dogs with "rarest" breed and their treatment dates: SELECT d.name, t.date_of_treatment FROM Treatments AS t JOIN Dogs as d ON d.dog_id = t.dog_id WHERE d.breed_code IN (select breed_code FROM Breeds WHERE breed_name IN ( SELECT breed_name FROM rare_dogs ));
error: No SQL found in the input string
error: No SQL found in the input string
SELECT Ow.last_name AS owner_last_name , Ow.first_name AS owner_first_name, D.name, P.first_name AS professional_first_name FROM owners Ow JOIN Dogs D ON D.owner_id = Ow.owner_id; WHERE Ow.state='Virginia';
SELECT DISTINCT T1.date_arrived, T1.date_departed FROM Dogs AS T1 JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id;
SELECT d.date_arrived, d.date_departed FROM Treatments t JOIN Dogs d ON t.dog_id = d.dog_id;
error: No SQL found in the input string
error: No SQL found in the input string
SELECT DISTINCT professionals.first_name, professionals.last_name, professionals.street, professionals.city, professionals.zip_code, professionals.email_address FROM professionals ,treatments WHERE treatments.treatment_id IS NULL AND (professionals.state = 'Hawaii' OR professionals.state = 'Wisconsin') ;
error: No SQL found in the input string
SELECT D.date_arrived AS "Arriving Date", D.date_departed AS "Departing Date" FROM Dogs D;
SELECT arr.date_arrived, dep.date_departed FROM ( SELECT owner_id FROM Owners WHERE owner_id != 'Unknown' ) AS from_owners JOIN Dogs AS arr ON arr.owner_id = from_owners.owner_id LEFT JOIN Dogs AS dep ON dep.owner_id = from_owners.owner_id AND (dep.date_departed > arr.date_arrived OR (dep.date_departed >= arr.date_arrived AND RANDOM() < 0.0001)) ORDER BY arr.date_arrived;
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT P.role_code, P.street AS street_address, P.city, P.state FROM Professionals P WHERE city LIKE '%West%';
SELECT p.role_code, p.street, p.city, p.state FROM Professionals p JOIN ( SELECT DISTINCT city FROM Professionals WHERE city LIKE '%West%' ) AS filter ON p.city = filter.city;
error: No SQL found in the input string
SELECT o.first_name, o.last_name, o.email_address FROM Owners AS o WHERE LOWER(o.state) LIKE '%north%';
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
error: No SQL found in the input string
SELECT COUNT(dog_id) FROM Treatments;
SELECT COUNT(DISTINCT d.owner_id) FROM Dogs d LEFT JOIN Owners o ON d.owner_id = o.owner_id WHERE o.owner_id IS NULL;
error: No SQL found in the input string
error: No SQL found in the input string
SELECT COUNT(professional_id) as total_professionals FROM Professionals WHERE professional_id NOT IN ( SELECT T2.professional_id FROM Treatments AS T1 JOIN Professionals AS T2 ON T1.professional_id = T2.professional_id )
error: No SQL found in the input string
SELECT d.name, d.age, d.weight FROM Dogs d;
SELECT AVG(age) FROM Dogs;
SELECT AVG(age) FROM Dogs;
SELECT name, age FROM Dogs WHERE age = (SELECT MAX(age) FROM Dogs);
error: No SQL found in the input string
SELECT treatment_type_code AS charge_type, SUM(cost_of_treatment) AS total_cost FROM Treatments GROUP BY treatment_type_code;
SELECT treatment_type_code, cost_of_treatment FROM Treatments;
SELECT treatment_type_code AS "treatment type code", SUM(cost_as_treatment) As cost_of_treatment, MAX(treatment_id) FROM ( SELECT T2.`treatment type code` ,SUM(T1.cost_of_treatment) As cost_as_treatment FROM Treteaments AS T1 INNER JOIN Treatment_Types AS T2 ON T1.treatment_type_code = T2.`treatment type code` GROUP BY T2.`treatment type code` ) GROUP BY treatment_type_code ORDER BY SUM(SUM(cost_of_treatment)/COUNT(*)) DESC, NULLIF(treatment_type_code, '') ASC;
-- 1st query: Get distinct treatment costs for each type SELECT DISTINCT CAST(T2.cost_of_treatment AS REAL) AS max_cost_per_type FROM Treatments T1 JOIN Treatment_Types T2 ON T1.treatment_type_code = T2.treatment_type_code; -- 2nd query: Find the cost per breed and display the maximum cost per breed SELECT B.name AS breed_name, MAX(CAST(T.cost_of_treatment AS REAL)) as max_cost_per_breed FROM Dogs D JOIN Breeds B ON D.breed_code = B.breed_code JOIN Treatments T on D.dog_id = T.dog_id GROUP BY B.name;
SELECT email_address AS Email, cell_number AS CellPhoneNumber, home_phone AS HomePhone FROM Professionals;
SELECT first_name, last_name, email_address AS "email", cell_number AS "cell_phone", home_phone AS "home_phone" FROM Professionals;
SELECT t.treatment_name FROM Treatment_types l JOIN Treatments T ON T.relation = l.id;
SELECT DISTINCT B.breed_code, S.size_code FROM Dogs D JOIN Sizes S ON D.size_code = S.size_code JOIN Breeds B ON D.breed_code = B.breed_code;
SELECT P.first_name, T.cost_of_treatment FROM Professionals AS P JOIN Treatments AS T ON P.professional_id = T.professional_id;
SELECT p.first_name, t.treatment_type_code AS "Treatment Type" FROM Professionals p JOIN Treatments t ON p.professional_id = t.professional_id;
SELECT COUNT(*) FROM singer;
SELECT COUNT(*) FROM singer;
SELECT `Name`, Net_Worth_Millions FROM singer ORDER BY Net_Worth_Millions ASC
SELECT `Name` FROM singer ORDER BY Net_Worth_Millions ASC;
SELECT `Birth_Year`, `Citizenship` FROM singer;
SELECT `Birth_Year`, `Citizenship` FROM singer ORDER BY Net_Worth_Millions DESC LIMIT 3;
SELECT s.`Name`, s.Singer_ID FROM singer AS s LEFT JOIN song as t ON s.Singer_ID = t.Singer_ID WHERE s.`Citizenship` != 'France'
SELECT `Name` FROM singer WHERE `Citizenship` != 'France'
SELECT Name FROM singer WHERE Birth_Year IN (1948, 1949)
SELECT Name FROM singer WHERE Birth_Year IN (1948, 1949)
SELECT T1.`Name` FROM ( SELECT Singer_ID, `Net_Worth_Millions` FROM singer ) AS T2 JOIN song ON T2.Singer_ID = song.Singer_ID ORDER BY T2.`Net_Worth_Millions` DESC LIMIT 1;
SELECT Name FROM singer WHERE Net_Worth_Millions = ( SELECT MAX(Net_Worth_Millions) FROM singer )
SELECT `Citizenship`, COUNT(*) FROM singer GROUP BY `Citizenship`
SELECT `Citizenship`, COUNT(*) FROM singer GROUP BY `Citizenship`;
SELECT `Citizenship`, COUNT(*) AS 'count' FROM singer GROUP BY `Citizenship` ORDER BY count DESC LIMIT 1
SELECT Citizenship, COUNT(*) as count FROM singer GROUP BY Citizenship ORDER BY count DESC;
SELECT s.`Citizenship`, MAX(s.Net_Worth_Millions) FROM singer AS s GROUP BY s.Citizenship
SELECT Citizenship, MAX(`Net_Worth_Millions`) as Max_Net_Worth FROM singer GROUP BY Citizenship
SELECT T2.Title, T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID
SELECT T1.`Name`, T2.`Title` FROM singer AS T1 JOIN song AS T2 ON T1.`Singer_ID` = T2.`Singer_ID`
SELECT DISTINCT `Name` FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID WHERE song.`Sales` > 300000
SELECT DISTINCT `Name` FROM singer AS T1 JOIN song AS T2 ON T1.`Singer_ID` = T2.`Singer_ID` WHERE T2.`Sales` > 300000.0
SELECT `Name` FROM singer GROUP BY Singer_ID HAVING COUNT(Singer_ID) > 1;
SELECT `Name` FROM ( SELECT s.`Name`, COUNT(ss.`Singer_ID`) AS `Number of Songs` FROM singer s JOIN song ss ON s.`Singer_ID` = ss.`Singer_ID` GROUP BY s.`Name` ) sub_query WHERE `Number of Songs` > 1
SELECT T1.Name, SUM(T2.Sales) as Total_Sales FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Name;
error: No SQL found in the input string
SELECT `Name` FROM singer WHERE Singer_ID NOT IN (SELECT DISTINCT Singer_ID FROM song)
SELECT `Name` FROM singer WHERE Singer_ID NOT IN ( SELECT Singer_ID FROM song );
-- Step 1: Define the correct columns and table SELECT T1.Citizenship FROM singer AS T1 WHERE T1.Birth_Year < 1945 OR T1.Birth_Year > 1955
SELECT T2.Citizenship FROM singer AS T1 JOIN ( SELECT Singer_ID FROM singer WHERE Birth_Year < 1945 OR Birth_Year > 1955 GROUP BY Singer_ID HAVING COUNT(*) > 1 ) AS T3 ON T1.Singer_ID = T3.Singer_ID JOIN singer AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T2.Citizenship
SELECT COUNT(T2.feature_id) FROM Properties AS T1 JOIN Other_Property_Features AS T2 ON T1.property_id = T2.property_id
SELECT T2.feature_type_name FROM Other_Available_Features AS T1 JOIN Ref_Feature_Types AS T2 ON T1.feature_type_code = T2.feature_type_code WHERE T1.feature_name = 'AirCon';
SELECT RT.property_type_description FROM Ref_Property_Types AS RT JOIN Properties AS P ON RT.property_type_code = P.property_type_code;
SELECT DISTINCT `property_name` FROM Properties WHERE (room_count > 1) AND ((`property_type_code` = '3') OR (`property_type_code` = '5'));
