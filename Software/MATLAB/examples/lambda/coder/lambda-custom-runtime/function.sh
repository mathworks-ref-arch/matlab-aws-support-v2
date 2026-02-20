function handler () {

  EVENT_DATA=$(echo "$1" | ./jq -r '.input')
  echo "$EVENT_DATA" 1>&2
  RESPONSE="Echoing request: '$EVENT_DATA'"

  # Get the directory of the current script
  SCRIPT_DIR=$(dirname "$0")

  # Full path to the executable
  EXECUTABLE="$SCRIPT_DIR/matlabFunction"

  if [ ! -x "$EXECUTABLE" ]; then
    echo "Executable $EXECUTABLE not found or not executable" 1>&2
    RESPONSE="Error: Executable $EXECUTABLE not found or not executable"
    echo $RESPONSE
    return
  fi

  # Convert the comma-separated string into an array of arguments
  IFS=',' read -ra ARGS <<< "$EVENT_DATA"

  # Trim spaces around each argument
  for i in "${!ARGS[@]}"; do
    ARGS[$i]=$(echo "${ARGS[$i]}" | xargs)
  done

  # Debugging: Print the command to be executed
  echo "Executing: $EXECUTABLE with arguments: ${ARGS[*]}" 1>&2

  # Run the specified executable with the arguments, and capture its output
  FN_RESULT=$("$EXECUTABLE" "${ARGS[@]}")
  EXIT_STATUS=$?

  if [ $EXIT_STATUS -eq 0 ]; then
    RESPONSE="$FN_RESULT"
  else
    echo "Error executing $EXECUTABLE: $FN_RESULT" 1>&2
    RESPONSE="Error executing $EXECUTABLE: $FN_RESULT"
  fi

  echo $RESPONSE
}