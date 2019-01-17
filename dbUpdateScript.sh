if [ -e wcaExport.sql.zip ]; then
    rm wcaExport.sql.zip
fi
if [ -e WCA_Export.sql ]; then
    rm WCA_Export.sql
fi

echo "Downloading Current WCA Export"
curl -# -o wcaExport.sql.zip https://www.worldcubeassociation.org/results/misc/WCA_export.sql.zip

# extract the sql dump
unzip wcaExport.sql.zip WCA_export.sql

# i'm not dumb enough to put a plaintext password on github
pass=$(cat .sqlPass.txt)

# import sql dump
mysql -u root --password=$pass wca < WCA_export.sql

# clean up files, leave sql dump file until the next update
rm wcaExport.sql.zip
rm WCA_export.sql
clear
echo Updated $(date) >> .wcaUpdateLog.txt
