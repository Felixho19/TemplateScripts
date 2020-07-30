# 1. Make sure your are running this script in the expected directory.
PROGRAM_DIR=`dirname "$0"`
cd "$PROGRAM_DIR"

# 2. Find out if the example.jar is running or not. If not just start again.
processId=$(jps | grep "example" | cut -d " " -f 1)
if [ $processId ]; then
  echo "Running at process ID: $processId"
else
  ./startJavaService.sh "$@"
fi
