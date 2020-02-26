# always remove lingering zip archives before we proceed
if [[ -e wcaExport.sql.zip ]]; then
    rm wcaExport.sql.zip
fi

# remove and redownload the file if the current export is more than 1 day old
if [[ $(find "WCA_export.sql" -mtime +1 -print) ]]; then
    rm WCA_Export.sql
    echo "Downloading Current WCA Export"
    curl -# -o wcaExport.sql.zip https://www.worldcubeassociation.org/results/misc/WCA_export.sql.zip
    # extract the sql dump
    unzip wcaExport.sql.zip WCA_export.sql && rm wcaExport.sql.zip
fi

# specify a .sqlPass with root user password and nothing else, otherwise prompt for the password
if [[ -e .sqlPass ]]; then
    pass=$(cat .sqlPass)
else
    read -s -p "MySQL Password: " pass
fi

echo "Importing Database"
# import sql dump
mysql -u root --password=$pass wca < WCA_export.sql

echo "Database import complete. Removing archived export files."

# clean up files, leave sql dump file until the next update
rm wcaExport.sql.zip
clear
echo Updated $(date) >> .updateLog
