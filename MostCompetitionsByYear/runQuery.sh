#!/bin/bash
password=$(cat ~/sqlPass.txt)
for (( year=2003; year <= 2018; year++ ))
do
    echo "\n## $year\n"
    echo "SELECT personId, personName, COUNT(DISTINCT(competitionId)) as numComps FROM Results
WHERE LEFT(personId, 4) = $year
GROUP BY personId, personName
ORDER BY numComps DESC
LIMIT 100;" | mysql -t -u root --password=$password wca | ghead -n -1 | gtail -n +2
done > output.md