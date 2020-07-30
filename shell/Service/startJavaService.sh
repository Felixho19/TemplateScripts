# 1. Make sure your are running this script in the expected directory.
PROGRAM_DIR=`dirname "$0"`
cd "$PROGRAM_DIR"

# 2. Make sure only 1 service is running. Try to stop the service first.
./stopJavaService.sh

# 3. Customizable properties
USER="$USER"
PASSWORD="$PASSWORD"
JAVA_VM_ARGS=""
FIX_CLI_ARGS=""
CRON_JOB="* * * * * `which bash` `pwd`/monitorJavaService.sh $@"

# 4. Pre run checking.
echo "JAVA: `which java`"
echo "JVM parameters: $JAVA_VM_ARGS"
echo "CLI parameters: $FIX_CLI_ARGS $@"

# 5. Run the java service.
java $JAVA_VM_ARGS -jar example.jar $FIX_CLI_ARGS $@ > /dev/null 2>&1 &

# 6. Register a monitoring script to cron job.
(sshpass -p $PASSWORD sudo crontab -l -u $USER; echo "$CRON_JOB";) | sshpass -p $PASSWORD sudo crontab -u $USER -
