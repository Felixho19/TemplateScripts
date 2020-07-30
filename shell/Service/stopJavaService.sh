# 1. Make sure your are running this script in the expected directory.
PROGRAM_DIR=`dirname "$0"`
cd "$PROGRAM_DIR"

# 2. Customizable properties
USER="$USER"
PASSWORD="$PASSWORD"

# 3. Remove monitoring cron job.
sshpass -p $PASSWORD sudo crontab -l -u $USER | grep -v "monitorJavaService.sh" | sshpass -p $PASSWORD sudo crontab -u $USER -

# 4. Find out if the example.jar is running
processId=$(jps | grep "example" | cut -d " " -f 1)
if [ $processId ]; then
  kill -9 $processId
fi
