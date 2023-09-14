-- Active: 1686746606802@@127.0.0.1@3306@sqlprojschema
-- Looking at the GDP, Life expectancy and Wellbeing change comparing 2020 to 2013 using index numbers.

SELECT country_dependent_territory, gdp_by_imf_2013, gdp_by_imf_2020, 
(CASE
WHEN ROUND((((gdp_by_imf_2020 / gdp_by_imf_2013) * 100) - 100),5) > 0
THEN CONCAT('+', (ROUND((((gdp_by_imf_2020 / gdp_by_imf_2013) * 100) - 100),5)), '%') 
ELSE CONCAT(ROUND((((gdp_by_imf_2020 / gdp_by_imf_2013) * 100) - 100),5), '%')
END) as 20_to_13_gdp 
FROM gdps;
SELECT country, l_expectancy_2013, l_expectancy_2020, 
(CASE
WHEN ROUND((((l_expectancy_2020 / l_expectancy_2013) * 100) - 100),5) > 0
THEN CONCAT('+', (ROUND((((l_expectancy_2020 / l_expectancy_2013) * 100) - 100),5)), '%') 
ELSE CONCAT(ROUND((((l_expectancy_2020 / l_expectancy_2013) * 100) - 100),5), '%')
END) as 20_to_13_l_expectancy 
FROM lifeexpectancy_and_wellbeing;
SELECT country, wellbeing_0to10_2013, wellbeing_0to10_2020, 
(CASE
WHEN ROUND((((wellbeing_0to10_2020 / wellbeing_0to10_2013) * 100) - 100),5) > 0
THEN CONCAT('+', (ROUND((((wellbeing_0to10_2020 / wellbeing_0to10_2013) * 100) - 100),5)), '%') 
ELSE CONCAT(ROUND((((wellbeing_0to10_2020 / wellbeing_0to10_2013) * 100) - 100),5), '%')
END) as 20_to_13_wellbeing_0to10 
FROM lifeexpectancy_and_wellbeing;


-- Looking at the GDP and Life expectancy in 2013 and 2020 and cocluding if changes are the same (growth or decline).
-- If changes are both positive or both negative, query displays 'Same', if different - 'Different'.
-- Of course, only for countries displayed in both tables (87).

SELECT country, gdp_by_imf_2013, gdp_by_imf_2020, l_expectancy_2013, l_expectancy_2020, 
(CASE
WHEN gdp_by_imf_2020 > gdp_by_imf_2013 AND l_expectancy_2020 > l_expectancy_2013
THEN 'Same'
WHEN gdp_by_imf_2020 < gdp_by_imf_2013 AND l_expectancy_2020 < l_expectancy_2013
THEN 'Same' 
ELSE 'Different'
END) as changes_note_2 
FROM gdps
INNER JOIN lifeexpectancy_and_wellbeing
ON country = country_dependent_territory;

-- Ranking of countries and territories by GDP, Life expectancy and Wellbeing in 2013.

SELECT (RANK() OVER(ORDER BY gdp_by_imf_2013 DESC)) as 13_gdp_rank, country_dependent_territory, gdp_by_imf_2013 
FROM gdps;
SELECT (RANK() OVER(ORDER BY l_expectancy_2013 DESC)) as 13_l_expectancy_rank, country, l_expectancy_2013
FROM lifeexpectancy_and_wellbeing;
SELECT (RANK() OVER(ORDER BY wellbeing_0to10_2013 DESC)) as 13_wellbeing_rank, country, wellbeing_0to10_2013 
FROM lifeexpectancy_and_wellbeing;

-- Ranking of countries and territories by GDP, Life expectancy and Wellbeing in 2020.

SELECT (RANK() OVER(ORDER BY gdp_by_imf_2020 DESC)) as 20_gdp_rank, country_dependent_territory, gdp_by_imf_2020 
FROM gdps;
SELECT (RANK() OVER(ORDER BY l_expectancy_2020 DESC)) as 20_l_expectancy_rank, country, l_expectancy_2020
FROM lifeexpectancy_and_wellbeing;
SELECT (RANK() OVER(ORDER BY wellbeing_0to10_2020 DESC)) as 20_wellbeing_rank, country, wellbeing_0to10_2020 
FROM lifeexpectancy_and_wellbeing;

-- Displaying rankings 

ALTER TABLE gdps
ADD COLUMN rank_2013 INT,
ADD COLUMN rank_2020 INT;
UPDATE gdps AS g
JOIN (
SELECT country_dependent_territory, gdp_by_imf_2013, (RANK() OVER (ORDER BY gdp_by_imf_2013 DESC)) AS rank_2013
FROM gdps) AS g1 
ON g.country_dependent_territory = g1.country_dependent_territory
SET g.rank_2013 = g1.rank_2013;
UPDATE gdps AS g
JOIN (
SELECT country_dependent_territory, gdp_by_imf_2020, (RANK() OVER (ORDER BY gdp_by_imf_2020 DESC)) AS rank_2020
FROM gdps) AS g1 
ON g.country_dependent_territory = g1.country_dependent_territory
SET g.rank_2020 = g1.rank_2020;
ALTER TABLE lifeexpectancy_and_wellbeing
ADD COLUMN expectancy_rank_2013 INT,
ADD COLUMN expectancy_rank_2020 INT,
ADD COLUMN wellbeing_rank_2013 INT,
ADD COLUMN wellbeing_rank_2020 INT;
UPDATE lifeexpectancy_and_wellbeing AS l
JOIN (
SELECT country, l_expectancy_2013, (RANK() OVER (ORDER BY l_expectancy_2013 DESC)) AS expectancy_rank_2013
FROM lifeexpectancy_and_wellbeing) AS l1 
ON l.country = l1.country
SET l.expectancy_rank_2013 = l1.expectancy_rank_2013;
UPDATE lifeexpectancy_and_wellbeing AS l2
JOIN (
SELECT country, l_expectancy_2020, (RANK() OVER (ORDER BY l_expectancy_2020 DESC)) AS expectancy_rank_2020
FROM lifeexpectancy_and_wellbeing) AS l3 
ON l2.country = l3.country
SET l2.expectancy_rank_2020 = l3.expectancy_rank_2020;
UPDATE lifeexpectancy_and_wellbeing AS w
JOIN (
SELECT country, wellbeing_0to10_2013, (RANK() OVER (ORDER BY wellbeing_0to10_2013 DESC)) AS wellbeing_rank_2013
FROM lifeexpectancy_and_wellbeing) AS w1 
ON w.country = w1.country
SET w.wellbeing_rank_2013 = w1.wellbeing_rank_2013;
UPDATE lifeexpectancy_and_wellbeing AS w2
JOIN (
SELECT country, wellbeing_0to10_2020, (RANK() OVER (ORDER BY wellbeing_0to10_2020 DESC)) AS wellbeing_rank_2020
FROM lifeexpectancy_and_wellbeing) AS w3 
ON w2.country = w3.country
SET w2.wellbeing_rank_2020 = w3.wellbeing_rank_2020;

-- Displaying pro/regress in ratings from 2013 to 2020 for each country or a territory.
-- Progress is displayed as a sign and a number each.
-- +n means ranking of a country in a certain category grew comparing to 2013 in 2020 by n units, opposite thing for -n.
-- --- is displayed when ranking did not change throughout the given period.

SELECT country_dependent_territory, rank_2013, rank_2020,
(CASE 
WHEN (rank_2013 - rank_2020) > 0 THEN CONCAT('+', (rank_2013 - rank_2020))
WHEN (rank_2013 - rank_2020) < 0 THEN (rank_2013 - rank_2020)
ELSE '---'
END) as gdp_ranking_movement
FROM gdps; 
SELECT country, expectancy_rank_2013, expectancy_rank_2020,
(CASE 
WHEN (expectancy_rank_2013 - expectancy_rank_2020) > 0 THEN CONCAT('+', (expectancy_rank_2013 - expectancy_rank_2020))
WHEN (expectancy_rank_2013 - expectancy_rank_2020) < 0 THEN (expectancy_rank_2013 - expectancy_rank_2020)
ELSE '---'
END) as expectancy_ranking_movement,
wellbeing_rank_2013, wellbeing_rank_2020,
(CASE 
WHEN (wellbeing_rank_2013 - wellbeing_rank_2020) > 0 THEN CONCAT('+', (wellbeing_rank_2013 - wellbeing_rank_2020))
WHEN (wellbeing_rank_2013 - wellbeing_rank_2020) < 0 THEN (wellbeing_rank_2013 - wellbeing_rank_2020)
ELSE '---'
END) as wellbeing_ranking_movement
FROM lifeexpectancy_and_wellbeing;

-- Displaying the best and the worst countries to live in a year before COVID associated crisis and during it 
-- (assuming that crisis started early 2020), their GDP, Life expectancy and Wellbeing.
-- Worst country is the country with the lowest by ranking possible combination of GDP, Life expectancy and Wellbeing.

SELECT country as best_country_2019, gdp_by_imf_2019, l_expectancy_2019, wellbeing_0to10_2019
FROM gdps
JOIN lifeexpectancy_and_wellbeing
ON country = country_dependent_territory
ORDER BY ((RANK() OVER(ORDER BY gdp_by_imf_2019 DESC)) + 
(RANK() OVER(ORDER BY l_expectancy_2019 DESC)) +
(RANK() OVER(ORDER BY wellbeing_0to10_2019 DESC))) ASC
LIMIT 1;
SELECT country as worst_country_2019, gdp_by_imf_2019, l_expectancy_2019, wellbeing_0to10_2019
FROM gdps
JOIN lifeexpectancy_and_wellbeing
ON country = country_dependent_territory
ORDER BY ((RANK() OVER(ORDER BY gdp_by_imf_2019 DESC)) + 
(RANK() OVER(ORDER BY l_expectancy_2019 DESC)) +
(RANK() OVER(ORDER BY wellbeing_0to10_2019 DESC))) DESC
LIMIT 1;
SELECT country as best_country_2020, gdp_by_imf_2020, l_expectancy_2020, wellbeing_0to10_2020
FROM gdps
JOIN lifeexpectancy_and_wellbeing
ON country = country_dependent_territory
ORDER BY ((RANK() OVER(ORDER BY gdp_by_imf_2020 DESC)) + 
(RANK() OVER(ORDER BY l_expectancy_2020 DESC)) +
(RANK() OVER(ORDER BY wellbeing_0to10_2020 DESC))) ASC
LIMIT 1;
SELECT country as worst_country_2020, gdp_by_imf_2020, l_expectancy_2020, wellbeing_0to10_2020
FROM gdps
JOIN lifeexpectancy_and_wellbeing
ON country = country_dependent_territory
ORDER BY ((RANK() OVER(ORDER BY gdp_by_imf_2020 DESC)) + 
(RANK() OVER(ORDER BY l_expectancy_2020 DESC)) +
(RANK() OVER(ORDER BY wellbeing_0to10_2020 DESC))) DESC
LIMIT 1;

-- Calculating and adding the mean GDP, Life expectancy and Wellbeing for each country for observed period to use in future calculations

ALTER TABLE gdps
ADD COLUMN gdp_mean DOUBLE;
UPDATE gdps
SET gdp_mean = ((gdp_by_imf_2013 + gdp_by_imf_2014 + gdp_by_imf_2015 + gdp_by_imf_2016 + gdp_by_imf_2017 + 
gdp_by_imf_2018 + gdp_by_imf_2019 + gdp_by_imf_2020) / 8);
ALTER TABLE lifeexpectancy_and_wellbeing
ADD COLUMN l_expectancy_mean DOUBLE;
UPDATE lifeexpectancy_and_wellbeing
SET l_expectancy_mean = ((l_expectancy_2013 + l_expectancy_2014 + l_expectancy_2015 + l_expectancy_2016 + l_expectancy_2017 + 
l_expectancy_2018 + l_expectancy_2019 + l_expectancy_2020) / 8);
ALTER TABLE lifeexpectancy_and_wellbeing
ADD COLUMN w_mean DOUBLE;
UPDATE lifeexpectancy_and_wellbeing
SET w_mean = ((wellbeing_0to10_2013 + wellbeing_0to10_2014 + wellbeing_0to10_2015 + wellbeing_0to10_2016 + wellbeing_0to10_2017 + 
wellbeing_0to10_2018 + wellbeing_0to10_2019 + wellbeing_0to10_2020) / 8);

-- Calculating Quartiles for average GDP, Life expectancy and Wellbeing 

SELECT 
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(gdp_mean 
ORDER BY gdp_mean SEPARATOR ','), ',', 25/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS gdp_Q1,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(gdp_mean 
ORDER BY gdp_mean SEPARATOR ','), ',', 50/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS gdp_Q2_or_median,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(gdp_mean 
ORDER BY gdp_mean SEPARATOR ','), ',', 75/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS gdp_Q3
FROM gdps;
SELECT 
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(l_expectancy_mean 
ORDER BY l_expectancy_mean SEPARATOR ','), ',', 25/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS expectancy_Q1,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(l_expectancy_mean 
ORDER BY l_expectancy_mean SEPARATOR ','), ',', 50/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS expectancy_Q2_or_median,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(l_expectancy_mean 
ORDER BY l_expectancy_mean SEPARATOR ','), ',', 75/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS expectancy_Q3
FROM lifeexpectancy_and_wellbeing;
SELECT 
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(w_mean 
ORDER BY w_mean SEPARATOR ','), ',', 25/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS wellbeing_Q1,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(w_mean 
ORDER BY w_mean SEPARATOR ','), ',', 50/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS wellbeing_Q2_or_median,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(w_mean 
ORDER BY w_mean SEPARATOR ','), ',', 75/100 * COUNT(*) + 1), ',', -1) AS DOUBLE) 
AS wellbeing_Q3
FROM lifeexpectancy_and_wellbeing;

-- Calculating Pearson's Correlation Coeficient for averages GDP and Wellbeing / GDP and Life expectancy / Life expectancy and Wellbeing 
-- to see the type of relationship between two measures

SELECT (AVG(gdp_mean * w_mean) - (AVG(gdp_mean) * AVG(w_mean))) / (STDDEV(gdp_mean) * STDDEV(w_mean)) 
AS gdp_wellbeing_pearson_r
FROM gdps
JOIN lifeexpectancy_and_wellbeing
ON country = country_dependent_territory;
SELECT (AVG(gdp_mean * l_expectancy_mean) - (AVG(gdp_mean) * AVG(l_expectancy_mean))) / (STDDEV(gdp_mean) * STDDEV(l_expectancy_mean)) 
AS gdp_expectancy_pearson_r
FROM gdps
JOIN lifeexpectancy_and_wellbeing
ON country = country_dependent_territory;
SELECT (AVG(w_mean * l_expectancy_mean) - (AVG(w_mean) * AVG(l_expectancy_mean))) / (STDDEV(w_mean) * STDDEV(l_expectancy_mean)) 
AS lifeexpectancy_and_wellbeing_pearson_r
FROM lifeexpectancy_and_wellbeing;