#!/bin/bash

# Check the number of arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

LOG_FILE=$1

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: The file '$LOG_FILE' does not exist."
    exit 1
fi

# Variables for the report
REPORT_FILE="log_report_$(date +%F).txt"
ERROR_COUNT=$(grep -c 'ERROR' "$LOG_FILE")
WARNING_COUNT=$(grep -c 'WARNING' "$LOG_FILE")
CRITICAL_EVENTS=$(grep -n 'CRITICAL' "$LOG_FILE")

# Generate the report
{
    echo "Log Analysis Report - $(date)"
    echo "Analyzed Log File: $LOG_FILE"
    echo "Total Error Count: $ERROR_COUNT"
    echo "Total Warning Count: $WARNING_COUNT"
    echo -e "\nCritical Events (line numbers):"
    
    if [ -z "$CRITICAL_EVENTS" ]; then
        echo "No critical events found."
    else
        echo "$CRITICAL_EVENTS"
    fi
} > "$REPORT_FILE"

echo "Analysis complete. Report saved to '$REPORT_FILE'."
