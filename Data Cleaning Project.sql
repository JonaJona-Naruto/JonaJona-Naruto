-- SQL Cleaning Project

-- https://www.kaggle.com/datasets/swaptr/layoffs-2022?resource=download

-- first make a duplicate table from the original table "layffs_staging"
 
INSERT INTO layffs_staging2
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised`,
`row_num`)
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised
			) AS row_num
	FROM 
		layffs_staging;
	
Select * from layffs_staging2 
where row_num > 1;

-- Now delete any duplicate row in table layffs_staging2

Delete from layffs_staging2
where row_num > 1;

-- some of the company names have spaces in them, let me remove them

select company, trim(company)
from layffs_staging2
order by 1;

update layffs_staging2
set company = trim(company)
order by company;

-- some locations are not spelt correctly like:
-- FlorianÃ³polis in Brazil
-- DÃ¼sseldorf in Germany
-- Cure.fit company name is spelt incorrectly showing duplicates, let me correct this

select location, company
from layffs_staging2
where country like "Brazil";

update layffs_staging2
set location = "Florianopolis"
where country like "Brazil"
and company like "Involves";

select *
from layffs_staging2
where country like "Brazil"
and company like "Involves";

select distinct country, location, company
from layffs_staging2
order by 2;

Select location
from layffs_staging2
where country like "Germany"
and company like "Springlane";

Update layffs_staging2
set location = "Dusseldorf"
where country like "Germany"
and company like "Springlane";

Select *
from layffs_staging2
where country like "Germany"
and company like "Springlane";

Select location, company, country
from layffs_staging2
where country like "India"
order by 1;

select company
from layffs_staging2
where company like "%fit"
and Location like "Bengaluru";

update layffs_staging2
set company = "Curefit"
where company like "%fit"
and Location like "Bengaluru";

select *
from layffs_staging2
where total_laid_off = ''
and percentage_laid_off = '';

-- 521 rows had no records of total_laid_off and percentage_laid_off, such rows are regarded not useful and so will be deleted

delete from layffs_staging2
where total_laid_off = ''
and percentage_laid_off = '';

select *
from layffs_staging2
where total_laid_off = ''
and percentage_laid_off = '';

select *
from layffs_staging2;

-- since all duplicated rows have been identified and removed, the row_num column can be removed from the table

ALTER TABLE layffs_staging2
DROP COLUMN row_num;

select *
from layffs_staging2;