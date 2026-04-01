-- Data-Cleaning :
-- 1. Remove Duplicates.
-- 2.Standadize the data.
-- 3.Null values and Blank Values.
-- 4.Remove unnecessary columns.

USE data_cleaning;

SELECT *
FROM layoffs;

-- Lets create a duplicate table to not effect original table

CREATE TABLE layoff_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoff_staging;

-- 1. Remove Duplicates.

-- Lets insert a row number in CTE to identify the unique ones

WITH CTE_layoff AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoff_staging
)
SELECT *
FROM CTE_layoff
WHERE row_num > 1;

-- verification

SELECT *
FROM layoff_staging
WHERE company = 'Cazoo';

-- Creating new table to insert row_num column , There are many ways but new table will work wonderful

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoff_staging2;

INSERT INTO layoff_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoff_staging;

DELETE
FROM layoff_staging2
WHERE row_num > 1;

SELECT *
FROM layoff_staging2
WHERE row_num > 1;

-- 2.Standadize the data.

-- Checking every possible column

SELECT company,TRIM(company)
FROM layoff_staging2;

UPDATE layoff_staging2
SET company = TRIM(company);

SELECT DISTINCT location
FROM layoff_staging2
ORDER BY 1;

SELECT DISTINCT industry
FROM layoff_staging2
ORDER BY 1;

-- Lets standadize 'Crypto' here

SELECT industry
FROM layoff_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoff_staging2
ORDER BY 1;

-- Lets standadize 'United States' here

SELECT DISTINCT country,TRIM(TRAILING '.' FROM country)
FROM layoff_staging2
ORDER BY 1;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- Lets Format the date

SELECT `date`,
STR_TO_DATE(`date` , '%m/%d/%Y')
FROM layoff_staging2;

UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date` , '%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` date;

-- 3. Null values and Blank values.

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
AND funds_raised_millions IS NULL;

-- These are unnecessary based on the 'layoffs' data

DELETE
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
AND funds_raised_millions IS NULL;

SELECT *
FROM layoff_staging2
WHERE industry IS NULL OR industry = '';

SELECT DISTINCT t1.company,t1.industry,t2.industry
FROM layoff_staging2 AS t1
JOIN layoff_staging2 AS t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL OR t1.industry = '';

UPDATE layoff_staging2
SET industry = NULL 
WHERE industry = '';

UPDATE layoff_staging2 AS t1
JOIN layoff_staging2 AS t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- 4.Remove unnecessary columns.

-- Now 'row_num' is unnecessary

ALTER TABLE layoff_staging2
DROP COLUMN row_num;

SELECT *
FROM layoff_staging2;