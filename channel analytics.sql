
CREATE TABLE PRODUCT_ANALYTICS AS
select cust_id, case when mobile_banking >=1 and internetbanking >=1 and ussd >= 1 then '3 PRODUCT'
WHEN (mobile_banking >=1 and internetbanking >=1) THEN 'MB AND IB' WHEN
(internetbanking >=1 and ussd >= 1) THEN 'IB AND USSD' 
WHEN (mobile_banking >=1 and USSD >=1) THEN 'MB AND USSD' WHEN mobile_banking >=1 THEN 'MB'
WHEN internetbanking >=1 THEN 'IB' WHEN USSD >=1 THEN 'USSD' ELSE 'NO DIGITAL' END CHANNEL, 
PRODUCT_CNT, DIGITAL_CHANNEL from product_table;


CREATE TABLE PRODUCT_ANALYTICS_TMP1 AS
SELECT distinct a.cust_id, c.bu_desc, c.group_desc, a.CHANNEL, 
a.PRODUCT_CNT, a.DIGITAL_CHANNEL  FROM PRODUCT_ANALYTICS a, report.d_acct_details_tbl@exadata_lnk b,
report.d_business_units_dim@exadata_lnk c
where A.CUST_ID = b.cust_id
and b.desk_code = c.desk_code
and c.bu_code in ('4', '5', '6');


truncate table PRODUCT_ANALYTICS;

drop table PRODUCT_ANALYTICS;


select count (distinct cust_id) from PRODUCT_ANALYTICS_TMP

select channel, bu_desc, count (distinct cust_id) from PRODUCT_ANALYTICS_TMP1
group by channel, bu_desc


select count(distinct cust_id), avg(revenue) AVG_REV, bu_desc, GROUP_DESC,channel,
case when digital_channel = 0 then 'NO CHANNEL' ELSE 'CHANNEL' END NO_or_YES,
CASE when digital_channel = 0 THEN 'NO CHANNEL'
when digital_channel = 1 THEN 'SINGLE CHANNEL' ELSE 'MULTIPLE CHANNELS' END CHANNEL_BREAKDOWN
from PRODUCT_ANALYTICS_TMP_NR
GROUP BY bu_desc, 
case when digital_channel = 0 then 'NO CHANNEL' ELSE 'CHANNEL' END,
CASE when digital_channel = 0 THEN 'NO CHANNEL'
when digital_channel = 1 THEN 'SINGLE CHANNEL' ELSE 'MULTIPLE CHANNELS' END, GROUP_DESC, channel


select A.CUST_ID, CUST_NAME, BU_DESC, GROUP_DESC, PHONE1, EMAIL_ID1, PRIMARY_SOL_ID
from PRODUCT_ANALYTICS_TMP_NR A, 
report.d_CUST_details_tbl@exadata_lnk B, report.d_acct_details_tbl@exadata_lnk C
where channel = 'NO DIGITAL'
AND DIGITAL_CHANNEL = 0
AND A.CUST_ID = B.CUST_ID
AND A.CUST_ID = C.CUST_ID
AND ACCT_STATUS = 'A'



select distinct city from station
where city not LIKE '%a' 
and city not LIKE '%e' 
and city not LIKE '%i' 
and city not LIKE '%o' 
and city not LIKE '%u';  

2. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicate;

select distinct city from station
where city not LIKE '%a' 
and city not LIKE '%e' 
and city not LIKE '%i' 
and city not LIKE '%o' 
and city not LIKE '%u'
and city not LIKE 'A%' 
and city not LIKE 'E%' 
and city not LIKE 'I%' 
and city not LIKE 'O%' 
and city not LIKE 'U%';



-----(Query the Name of any student in STUDENTS who scored higher than  Marks. 
------Order your output by the last three characters of each name. If two or more students both have names 
------ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID).

select name from students
where marks > 75
order by right(name, 3), id asc;



----Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than 2000 
----per month who have been employees for less than  months. Sort your result by ascending employee_id.

select name from employee
where salary > 2000
and months < 10
order by employee_id;



----Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) 
----as both their first and last characters. Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(SUBSTR(CITY, 1, 1)) IN ('a', 'e', 'i', 'o', 'u')
AND LOWER(SUBSTR(CITY, -1, 1)) IN ('a', 'e', 'i', 'o', 'u');


----Write a query to print all prime numbers less than or equal to . 
---Print your result on a single line, and use the ampersand () character as your separator (instead of a space).

WITH 
  numbers AS (SELECT LEVEL+1 AS n FROM DUAL
    CONNECT BY LEVEL < 1000
  ),
  primes AS (SELECT n FROM numbers n1
    WHERE n1.n > 1 AND NOT EXISTS (
      SELECT 1 FROM numbers n2
      WHERE n2.n > 1 AND n2.n < n1.n AND MOD(n1.n, n2.n) = 0
    ))
SELECT LISTAGG(n, '&') WITHIN GROUP (ORDER BY n) AS prime_numbers
FROM primes;


----Query a list of CITY names from STATION for cities that have an even ID number. 
----Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT CITY FROM STATION
where MOD(ID, 2) = 0;



select customer_id, name, ('+'|| country_code ||''|| phone_number) phone_number 
from customers a left join country_codes b 
on a.country = b.country
order by customer_id;




SELECT b.id AS user_id, 
       b.first_name, 
       b.last_name, 
       c.id AS customer_id, 
       c.customer_name,
       COUNT(DISTINCT a.contact_type_id) AS contact_count
FROM contact a 
LEFT JOIN user_account b 
ON a.user_account_id = b.id
LEFT JOIN customer c 
ON a.customer_id = c.id
WHERE a.contact_type_id IS NOT NULL
GROUP BY b.id, b.first_name, b.last_name, c.id, c.customer_name
HAVING COUNT(DISTINCT a.contact_type_id) > 1
ORDER BY b.id;




