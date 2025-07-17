select *
FROM layoffs_staging2;

-- exploratory data analysis
SELECT   MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

select*
FROM layoffs_staging2
where percentage_laid_off = 1;

select *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company,SUM(total_laid_off)
from layoffs_staging2
GROUP BY COMPANY
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;


SELECT industry,SUM(total_laid_off)
from layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country,SUM(total_laid_off)
from layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`),SUM(total_laid_off)
from layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

SELECT stage,SUM(percentage_laid_off)
from layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

select substring(`date`,1,7)AS `MONTH`,SUM(total_laid_off)
from layoffs_staging2
WHERE substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc;


with rolling_Total AS
(
select substring(`date`,1,7)AS `MONTH`,SUM(total_laid_off) AS total_off
from layoffs_staging2
WHERE substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc
)
select `MONTH`,total_off,SUM(total_off) over(order by `month`)as rolling_total
from rolling_Total;

with Rank_highest (company,years,total_laid_off) as
(
SELECT company,Year(`date`),SUM(total_laid_off)
from layoffs_staging2
GROUP BY COMPANY,year(`date`)
), Company_year_Rank AS
(
select *,dense_rank() over(partition by years order by total_laid_off desc)as ranking
from Rank_highest
where years is not null
)
select *
from Company_Year_Rank
where ranking <=5;







