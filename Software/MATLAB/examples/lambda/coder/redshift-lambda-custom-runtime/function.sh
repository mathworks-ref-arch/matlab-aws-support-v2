function handler () {
  # Log the raw input data to stderr
  echo "Raw input data: $1" 1>&2

  # Define the path to the jq binary
  JQ_PATH="./jq"  # Ensure this path is correct

  # Check if jq is executable
  if [ ! -x "$JQ_PATH" ]; then
    echo "jq binary not found or not executable at $JQ_PATH" 1>&2
    RESPONSE_JSON='{"success": false, "error_msg": "jq binary not found or not executable", "num_records": 0, "results": []}'
    echo "$RESPONSE_JSON"
    return
  fi

  # Extract the arguments array from the input JSON
  ARGUMENTS=$(echo "$1" | "$JQ_PATH" -r '.arguments[] | @csv')

  # Prepare the response structure
  RESPONSE_JSON='{"success": true, "num_records": 0, "results": []}'
  RESULTS=()

  # Get the directory of the current script
  SCRIPT_DIR=$(dirname "$0")

  # Full path to the executable
  EXECUTABLE="$SCRIPT_DIR/matlabFunction"

  if [ ! -x "$EXECUTABLE" ]; then
    echo "Executable $EXECUTABLE not found or not executable" 1>&2
    RESPONSE_JSON='{"success": false, "error_msg": "Executable not found or not executable", "num_records": 0, "results": []}'
    echo "$RESPONSE_JSON"
    return
  fi

  # Process each set of arguments
  for ARG_SET in $ARGUMENTS; do
    # Remove quotes from the CSV format
    ARG_SET=$(echo $ARG_SET | tr -d '"')

    # Convert CSV to array
    IFS=',' read -r -a ARGS <<< "$ARG_SET"

    # Debugging: Print the command to be executed to stderr
    echo "Executing: $EXECUTABLE with arguments: ${ARGS[@]}" 1>&2

    # Run the specified executable with the function name and arguments, and capture its output
    FN_RESULT=$("$EXECUTABLE" "${ARGS[@]}")
    EXIT_STATUS=$?

    if [ $EXIT_STATUS -eq 0 ]; then
      RESULTS+=("$FN_RESULT")
    else
      echo "Error executing $EXECUTABLE: $FN_RESULT" 1>&2
      RESPONSE_JSON='{"success": false, "error_msg": "Error executing function", "num_records": 0, "results": []}'
      echo "$RESPONSE_JSON"
      return
    fi
  done

  # Prepare results as a JSON array
  RESULTS_JSON=$(printf '%s\n' "${RESULTS[@]}" | "$JQ_PATH" -R . | "$JQ_PATH" -s .)

    # Check if RESULTS_JSON is valid JSON
    if ! echo "$RESULTS_JSON" | "$JQ_PATH" . > /dev/null 2>&1; then
        echo "Invalid JSON generated for results" 1>&2
        RESPONSE_JSON='{"success": false, "error_msg": "Invalid JSON generated for results", "num_records": 0, "results": []}'
        echo "$RESPONSE_JSON"
        return
    fi

    # Update the response JSON with valid JSON data
    RESPONSE_JSON=$("$JQ_PATH" -n --argjson results "$RESULTS_JSON" --arg num_records "${#RESULTS[@]}" \
        '{"success": true, "num_records": $num_records|tonumber, "results": $results}')

    echo "response JSON: $RESPONSE_JSON" 1>&2

    # Stringify the RESPONSE_JSON
    STRINGIFIED_RESPONSE_JSON=$(echo "$RESPONSE_JSON" | "$JQ_PATH" -c 'tostring')

    # Log the stringified JSON to stderr
    echo "Stringified response JSON: $STRINGIFIED_RESPONSE_JSON" 1>&2

    # Ensure that the response is a single JSON object
    echo "$STRINGIFIED_RESPONSE_JSON"
}