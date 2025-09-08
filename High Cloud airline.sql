create database airline;
use airline;
select * from maindata;

-- question 1
CREATE VIEW DATE AS SELECT CONCAT(YEAR,"-",`Month (#)`,"-",DAY) AS DATE FROM MAINDATA;
CREATE VIEW WHOLEDATA AS SELECT *, CONCAT(YEAR,"-",`Month (#)`,"-",DAY) AS DATE FROM MAINDATA;
-- A. DATE,YEAR,MONTHNO,MONTHFULLNAME,QUARTER,YEARMONTH,WEEKDAYNO,WEEKDAYNAME,FINANCIALMONTH,QUARTERFINANCIAL
SELECT * FROM DATE;
SELECT DATE,YEAR(DATE) AS YEAR ,month(DATE) AS MONTHNO,monthname(DATE) AS MONTHFULLNAME,quarter(DATE) AS QUARTER,
CONCAT(extract(YEAR FROM DATE),"-",extract(MONTH FROM DATE)) AS YEARMONTH,dayofweek(DATE) WEEKDAYNO,
dayname(DATE) AS WEEKDAY_NAME ,MONTH(date) AS calendar_month,CASE
WHEN MONTH(date) >= 4 THEN MONTH(date) - 3  
ELSE MONTH(date) + 9  
END AS financial_month,CASE 
WHEN MONTH(DATE) IN (1,2,3) THEN 4
WHEN MONTH(DATE) IN (4,5,6) THEN 1
WHEN MONTH(DATE) IN (7,8,9) THEN 2
ELSE 3
END AS FINANCIAL_QUARTER FROM WHOLEDATA;




-- 2)
SELECT * FROM MAINDATA;
SELECT `# Transported Passengers`, `# Available Seats`FROM MAINDATA;
SELECT sum(`# Available Seats`) FROM MAINDATA;
SELECT sum(`# Transported Passengers`) FROM MAINDATA;
-- Q.2-- YEAR WISE LOAD FACTOR DATA
SELECT YEAR(DATE) AS year, QUARTER(DATE) AS quarter, monthname(DATE) AS MONTH,SUM(`# Available Seats`) / SUM(`# Transported Passengers`) * 100
 AS load_factor_percentage FROM WHOLEDATA GROUP BY YEAR(DATE), quarter(DATE),monthname(DATE)
ORDER BY year, quarter;

-- Q.3 LOAD FACTOR PERCENTAGE ON CARRIER NAME BASIS
SELECT `Carrier Name`,(sum(`# Available Seats`)/sum(`# Transported Passengers`))*100 AS LOAD_FACTOR_PERCENTAGE FROM MAINDATA GROUP BY `Carrier Name`;


-- Q.4) TOP 10 CARRIER NAME BASED ON PASSENGERS PREFERENCES
SELECT `Carrier Name`, SUM(`# Transported Passengers`) AS PASSENGERS_PREFERENCES FROm wholedata GROUP BY `Carrier Name` ORDER BY
 PASSENGERS_PREFERENCES DESC LIMIT 10;

-- Q.5)TOP ROUTES (FROM-TO-CITY) BASED ON NUMBER OF FLIGHTS
 select `From - To City`,sum(`# Departures Performed`) as "no.of.flights" from wholedata group by  `From - To City` order by  
 "no.of.flights" desc limit 5 ;
   
 
 -- Q.6)LOAD FACTOR OCCUPIED ON WEEKEND VS WEEKDAYS
 SELECT CASE 
        WHEN DAYOFWEEK(DATE) IN (1, 7) 
        THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS TYPEOFDAY,
    SUM(`# Transported Passengers`) / SUM(`# Available Seats`) * 100 AS load_factor FROM WHOLEDATA GROUP BY TYPEOFDAY;

-- QUESTION 7) NUMBER OF FLIGHTS BASED ON DISTANCE GROUP
SELECT `%Distance Group ID`, SUM(`# Departures Performed`) AS total_flights FROM WHOLEDATA GROUP BY `%Distance Group ID`
 ORDER BY `%Distance Group ID` ;

 
 



