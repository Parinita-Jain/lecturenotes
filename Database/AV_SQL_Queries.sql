create database fifa19;
use fifa19;
create table players(
id int,
name varchar(30),
age int(3),
nationality varchar(255),
overallrating int,
potentialrating int,
club varchar(255),
value int,
wage int,
preferredfoot enum('Left','Right'),
jerseynumber int,
joined date,
height varchar(10),
weight int(3),
penalties int(3)
);

select sum(wage) as total_wage,jerseynumber from players group by jerseynumber order by total_wage desc
limit 1;

# what is the freq distributionof nationality whose club name starts with M?

select count(*) as freq,nationality from players where club like "M%" group by nationality;

# how many players have joined there respective clubs in the date range 20 May 2018 and 10 Apr 2019
# both inclusive---

#nowthis kind of filtering based on timeline..arevery useful

select count(*) from players where joined >= "2018-05-20" and joined <= "2019-04-10";

# u can alsouse between clause

# now lets say I want to see distribution of players as to how many players have joined there 
# respective clubs date wise orlets say yearwise..we can also use this kind of query like how
# many users connect daily tomy website

select count(*) as freq,date(joined) from players group by date(joined);

# lets say we want to see yearly


select count(*) as freq,year(joined) from players group by year(joined);

select concat(name,' ',nationality) from players limit 10;

select ucase(nationality) from players;
select lcase(nationality) from players;

# trimming string means..u can remove leading and trailing spaces

select ltrim("   Hello");
select rtrim("Hello     ");
select trim("   Hello  ");

# slicing a string or getting substring from a string

#getting only starting 2 letters of players

select left(name,2) from players limit 10; 
# last 2 characters--
select right(name,2) from players limit 10;

# in between characters--
select substring(name,2,5) from players limit 10;

# reg exp is a special sequence of characters that helpsu match or find other strings or setsof strings
# this is what a reg exp looks like- '[a-zA-Z0-9._-]+@\w+\.com'

# lets say we have a text col in our table--
# find out the words that starts with M ?- ^M
# ending with ing ?- ing$
# words that starts with m and c?- ^[mc]
# starts with m ends with y?- ^m.*y$---.* for anything in between
# words that contain digits ?-/d
# find 3 digit numbers ?-^/d{3}$

select distinct nationality from players where nationality regexp '^A'; 
select distinct nationality from players where nationality regexp '^A.*n$';

# date time functions
select now(),curdate(),curtime();

# extracting date and time
select joined from players limit 5;
select date(joined) from players limit 5;
select time(joined) from players limit 5;
select joined ,date(joined),month(joined),day(joined),year(joined) from players limit 5 ;
#formatting date and time as strings-
select joined,date_format(joined,"%m/%d/%y") from players limit 5;

# numeric functions--
select value/wage ,round(value/wage) as nearest_integer,floor(value/wage) as floor_integer,
ceiling(value/wage) as ceil_integer,truncate(value/wage,2) as two_decimal_places
from players limit 3;
# absolute function..so first creating a -ve weight,then take abs value of -ve weight
select -weight,abs(-weight) from players;

# conditional flow--
# case stmt--categorizing players based on rating--

select name, 
case 
when overallratig >90 then "WorldClass"
when overallrating between 80 and 90 then "High Performer"
when overallrating beween 60and 80 then "Average"
else "BelowPar"
end as "Category"
from players; 

# Subqueries--------------------------------
# find count of all players whose overall rating doesnot equal to the maxi overall rating
# fromany nationality?
select count(*) from players where overallrating<>ALL( select max(overallrating)
from players group by nationality); 
select max(overallrating)
from players group by nationality; 

# find count of allplayers whose overall ratings equals to the maximum overall rating from
# any nationality

select count(*) from players where overallrating = Any(
select max(overallrating) from players group by nationality);

# multicol subqueries--

# find name,age and nationality of players whose nationality starts with A and age is lessthan 25
select name,age,nationality from players where (nationality,age) in 
(select nationality,age from players where nationality like "A%" and age<25);

# correlated subqueries---
#find name,nationality and overallrating of players whose overallrating is greater than the 
# avg rating ofplayers within the same nationality
select name,nationality,overallrating from players p1
where overallrating>(select avg(overallrating) from players p2
where p1.nationality=p2.nationality ) order by nationality;

# exists operator--here subquery returns 0,1, or many rows.

#find name,nationality and overallrating,joiningdate of players who have joined before
#2018-07-10
select name,nationality,overallrating,joined from players where exists 
(select 1 from players where joined<'2018-07-10');

# specifies if there exists any record where joined<2018-07-10 
select 1 from players where joined<'2018-07-10';
select * from players limit 1;
# now lets say we want to find all those players who joined after 158023 
select joined from players where id=158023; 
select name from players where joined>(select joined from players where id=158023);

# adding not null and default constraints--
create table emp
( id int not null,first_name varchar(255), salary int default 10000,bonus int
);

insert into emp values(1,"david",12000,1000);
insert into emp(id,first_name,bonus) values(2,"jennifer",1000);

select * from emp;

alter table emp modify first_name varchar(255) not null;

alter table emp modify bonus int default 0;

create table emp_constarints(
id int not null,
first_name varchar(255) not null,
last_name varchar(255) default null,
age int default null,
salary int default 10000,
bonus int default 0,
unique(id),
check (age>22)
);

alter table emp_constarints add constraint salary_bonus check (bonus<0.5*salary);

alter table emp_constarints add constraint unique_name unique(first_name,last_name);




    






 