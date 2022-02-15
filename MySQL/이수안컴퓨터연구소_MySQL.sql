-- SQL 초급
show databases;
use world;
show tables;
show table status;
describe city;
desc country;
desc countrylanguage;

select *
from city
where countrycode='KOR'
and population >= 1000000;

select *
from city
where name in ('seoul', 'tokyo');

select *
from city
where countrycode = (select countrycode
					from city
                    where name='seoul');

select *
from city
where population > any (select population
					from city
                    where district ='New York');

select *
from city
where population > all (select population
					from city
                    where district ='New York');
                    
select countrycode, max(population)
from city
group by countrycode
order by population
limit 5;

select count(*)
from city;

select countrycode, max(population)
from city
group by countrycode
having max(population) > 8000000;

-- 총합 또는 중간 합계 필요시 rollup
select countrycode, name, sum(population)
from city
group by countrycode, name with rollup;

select length('asdfasdf');
select concat('My', 'sql Op', 'en Source');
select locate('abc', 'ababababababababc');
select left('MySQL is an open source relational database management system', 5);
select right('MySQL is an open source relational database management system', 5);
select replace('MSSQL', 'MS', 'My');
-- 공백제거
select trim('         mySQL      ');
-- 특수문자 앞에 지워줘
select trim(Leading '#' from '###MySQL##');
-- 특수문자 뒤에 지워줘
select trim(trailing '#' from '###MySQL##');
select format(12312313123.123213123, 3);
select sqrt(4), pow(2,3), exp(3), log(3);
select sin(pi()/2), cos(pi()), tan(pi()/2);
select abs(-3), rand(), round(rand()*100, 0); 

-- 날짜: now = curdate+curtime
select now(), curdate(), curtime();
select now(), date(now()), month(now()), day(now()), hour(now()), minute(now()), second(now());
select now(), monthname(now()), dayname(now());
-- dayofweek: 0이 일요일
select now(), dayofmonth(now()), dayofweek(now()), dayofyear(now());
select date_format(now(), '%D %y % a %d %m %n %j');

-- SQL 고급
create table city2 as select * from city;
show tables;
create database huni;
show databases;

use huni;
select *
from test;

create table test2(
	id int not null primary key,
    col1 int null,
    col2 float null,
    col3 varchar(45) null
);

select * from test2;
desc test2;

alter table test2
add col4 int null;
select * from test2;
alter table test2
drop col4;
select * from test2;

-- 인덱스
create index ColIdx
on test(col1);
show index from test;

-- non_unique = 0
create unique index Col2Idx
on test(col2);
show index from test;

alter table test
add col3 int;
alter table test
add fulltext Col3Idx(col3);
show index from test;

alter table test
drop index Col3Idx;
show index from test;

-- view
create view testView as
select col1, col2
from test;
select * from testView;

alter view testView as
select col1, col2, col3
from test;
select * from testView;

drop view testview;

-- Lab
use world;
create view allView AS
select city.name, country.surfacearea, city.population, countrylanguage.language
from city
join country on city.countrycode = country.code
join countrylanguage on city.countrycode = countrylanguage.countrycode
where city.countrycode='kor';

select * from allView;

-- insert
use huni;
insert into test
value (1, 123, 1.1, 1.2);
select * from test;
-- insert into select
insert into test2 select * from test;
select * from test2;

-- update: where절 필수
update test
set col1 =1, col2=1.0, col3= 4
where id=1;
select * from test;

-- delete: where절 필수
delete from test
where id=1;
select * from test;

-- truncate: 복구 불가, 테이블 껍데기만 남기기
truncate table test;
select * from test;

-- drop table
drop table test;

-- drop database
drop database huni;

