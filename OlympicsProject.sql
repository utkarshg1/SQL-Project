-- Importing large data more than lakhs of rows

-- 1. Create the table athletes
create table athletes(
	Id int,
    Name varchar(200),
    Sex char(1),
    Age int,
    Height float,
    Weight float,
    Team varchar(200),
    NOC char(3),
    Games varchar(200),
    Year int,
    Season varchar(200),
    City varchar(200),
    Sport varchar(200),
    Event varchar(200),
    Medal Varchar(50));

-- View the blank Athletes table
select * from athletes;

-- Location to add the csv
SHOW VARIABLES LIKE "secure_file_priv";

-- Load the data from csv file after saving to above location
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned.csv'
into table athletes
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- View the table
select * from athletes;

-- Check number of rows in the table
select count(*) from athletes;

-- To avoid 1055 error
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Q1. Show how many medal counts present for entire data.
select medal, count(medal) from athletes
group by medal;

-- Q2. Show count of unique Sports are present in olympics.
select count(distinct sport) from athletes;

select distinct sport from athletes;

-- Q3. Show how many different medals won by Team India in data.
select medal, count(medal) as medal_count from athletes
where team='India' and medal<>'NoMedal'
group by medal
order by medal_count desc;

-- Q4. Show event wise medals won by india show from highest to lowest medals won in order.
select team, event, count(medal) as medal_count
from athletes
where team='india' and medal<>'NoMedal'
group by event
order by medal_count desc;

-- Q5. Show event and yearwise medals won by india in order of year.
select team, year, event, count(medal) as medal_count
from athletes
where team='india' and medal<>'NoMedal'
group by year,event
order by year desc;

-- Q6. Show the country with maximum medals won gold, silver, bronze
select team, count(medal) as medal_count
from athletes
where medal<>'NoMedal'
group by team
order by medal_count desc
limit 1;

-- Q7. Show the top 10 countries with respect to gold medals
select team, count(medal) as gold_medal_count
from athletes
where medal='gold'
group by team
order by gold_medal_count desc
limit 10;

-- Q9. In which sports United States has most medals
select year, count(medal) as medal_count
from athletes 
where team = 'United States' and medal<>'NoMedal'
group by year
order by medal_count desc
limit 1;

-- Q9. In which sports United States has most medals
select sport, count(medal) as medal_count
from athletes
where team = 'United States' and medal<>'NoMedal'
group by sport
order by medal_count desc
limit 1;

-- Q10. Find top 3 players who have won most medals along with their sports and country.
select name, sport, team, count(medal) as medal_count
from athletes
where medal<>'NoMedal'
group by name 
order by medal_count desc
limit 3;

-- Q11. Find player with most gold medals in cycling along with his country.
select name, team, sport, count(medal) as gold_medal_count
from athletes
where medal='Gold' and sport='Cycling'
group by name
order by gold_medal_count desc
limit 1;

-- Q12. Find player with most medals (Gold + Silver + Bronze) in Basketball also show his country.
select name, sport, team, count(medal) as medal_count
from athletes 
where sport='Basketball' and medal<>'NoMedal'
group by name
order by medal_count desc
limit 1;

-- Q13. Find out the count of different medals of the top basketball player.
select name, medal, count(medal) as medal_count
from athletes
where name='Teresa Edwards' and medal<>'NoMedal'
group by medal
order by medal_count desc;

-- Q14. Find out medals won by male, female each year . Export this data and plot graph in excel.
select year, sex, count(medal) as medal_count 
from athletes
where medal<>'NoMedal'
group by year, sex
order by year asc;
