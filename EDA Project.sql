-- SQL Exploratory Data Analysis EDA Project

-- https://www.kaggle.com/datasets/swaptr/layoffs-2022?resource=download

select * 
from layffs_staging2;

-- What is the total staff laid off

select sum(total_laid_off)
from layffs_staging2;

-- which is 529,701 


-- what is the period of this layoff dataset

select min(`date`), max(`date`)
from layffs_staging2;

-- It is between the start of the pandemic Covid 19 11th of March 2020 to post-pandemic 13th of June 2024

-- what is the total laid off by company

select company, sum(total_laid_off)
from layffs_staging2
Group by company
order by 2 desc;

-- Amazon leads at 27,840 laid off followed by Meta with 21,000 and then Telsa 14,500 within this period.

select count(total_laid_off) 
from layffs_staging2;

select sum(total_laid_off)
from layffs_staging2;

select Year(`date`), sum(total_laid_off)
from layffs_staging2
Group by 1
Order by 2 desc;

-- 2023 seems to be the year with the highest lay off with 212,585 and 2022 in second place with 150,707 

-- Calculate the total number of employees laid off per industry

select industry, sum(total_laid_off)
from layffs_staging2
group by 1
order by 2 desc;

-- Retail topped the charts with 68,428 and consumer followed by 64,264 jobs lost.

-- Calculate the total number of employees laid off per country

select country, sum(total_laid_off) 
from layffs_staging2
group by 1
order by 2 desc;

-- USA laid off over 368000 jobs followed by India by 47,202 and Germany at 25,345

-- Total number of jobs laid off on a particular day within the period.

select dayname(`date`), dayofweek(`date`), sum(total_laid_off)
from layffs_staging2
Group by 1, 2
order by 3 desc;

-- Wednesday had the highest lay off, followed by Tuesday and then Monday.

-- What stage of each company had the highest number of lay off.

select stage, sum(total_laid_off), row_number() over(order by sum(total_laid_off) desc) as 'Position'
from layffs_staging2
Group by 1;

-- Post IPO with 289,64

select * 
from layffs_staging2;

select Year(`date`), month(`date`), monthname(`date`),sum(total_laid_off), row_number () over (partition by year(`date`) order by sum(total_laid_off) desc) as 'Position'
from layffs_staging2
Group by 1,2,3
Order by 1,4 desc;

-- Which month had the highest job cuts? 
select Year(`date`) as 'Year', month(`date`) as 'Month' , monthname(`date`) as 'Month Name',sum(total_laid_off) as 'Total Laid Off', 
row_number () over (partition by year(`date`) order by sum(total_laid_off) desc) as 'Position',
row_number () over (order by sum(total_laid_off) desc) as 'Total Position'
from layffs_staging2
Group by 1,2,3
Order by 1,4 desc;

-- January 2023 had the higest job cuts