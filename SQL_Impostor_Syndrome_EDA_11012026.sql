SELECT * FROM impostor

DESCRIBE impostor

-- Total sample count

SELECT 
	SUM(sample_sizen) AS count_samples
FROM impostor

-- count_samples = 11503

-- Total samples in each population

SELECT
	population,
    SUM(sample_sizen) AS count_samples
FROM impostor
GROUP BY population
ORDER BY count_samples DESC

-- INSIGHT: Medical students were tested most across ALL populations

-- What TOTAL percentage of each population with IS

SELECT 
	population,
    ROUND(SUM((prevalence_of_is / 100.0 ) * sample_sizen) /
    SUM(sample_sizen) * 100, 2) AS overall_prevalence
FROM impostor
GROUP BY population
ORDER BY overall_prevalence DESC;

-- Insight: Neurosurgeons had the highest rate of IS across all populations. 

-- How does this compare to overall total of samples - qty per pop over sum_samps?

SELECT
	population,
    SUM(sample_sizen) AS samps_pop,
    SUM(sample_sizen) / (SELECT
    SUM(sample_sizen) FROM impostor) AS 
    sample_ratio
FROM impostor
GROUP BY population
ORDER BY samps_pop DESC;

 -- Insight: medical students made up ~30% of overall samples studied
 
 -- Total samples taken from each location (Country)
 
 SELECT 
	location,
    SUM(sample_sizen) AS sum_samps,
    SUM(sample_sizen) / (SELECT 
    SUM(sample_sizen) FROM impostor)
    AS ratio_location
FROM impostor
GROUP BY location
ORDER BY sum_samps DESC;

-- Insight: Majority of the samples in study are from USA (~50%) and Saudi Arabia (~25%)

-- How many USA samples and which populations in the USA had most IS prevalence? 

SELECT 
	location,
	COUNT(Location) AS num_locations   
FROM impostor
GROUP BY location
ORDER BY num_usa DESC;

SELECT 
	population
FROM impostor
WHERE location LIKE 'USA'
ORDER BY population ASC;

SELECT 
	location,
    COUNT(*) AS num_usa,
    ROUND(
		COUNT(*) * 100.0 / (SELECT COUNT(*)
	FROM impostor), 2
		) AS prevalence_pct
FROM impostor
GROUP BY location
ORDER BY prevalence_pct DESC;

-- 30% of studies performed in the US 

-- What types of populations were studied in USA?

SELECT
	population,
    location
FROM impostor
WHERE location = 'USA'

-- Most prevalent population in USA 

SELECT
	population,
    location,
    prevalence_of_is,
    sample_sizen
FROM impostor
WHERE location = 'USA'
ORDER BY prevalence_of_is DESC;

-- 

    
    
    
    





 
 
 
 
 
 
 