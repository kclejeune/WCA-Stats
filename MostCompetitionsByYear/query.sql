SELECT personId, personName, COUNT(DISTINCT(competitionId)) as numComps FROM Results
WHERE LEFT(personId, 4) = '2016'
GROUP BY personId, personName
ORDER BY numComps DESC
LIMIT 100;
