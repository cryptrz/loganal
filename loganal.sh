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
ERROR_COUNT=$(grep -ci 'ERROR' "$LOG_FILE")
WARNING_COUNT=$(grep -ci 'WARNING' "$LOG_FILE")
CRITICAL_EVENTS=$(grep -ni 'CRITICAL' "$LOG_FILE")

ERROR_COUNT_YESTERDAY=$(journalctl -p err --since=yesterday | wc -l)
ERROR_COUNT_WEEK=$(journalctl -p err --since="1 week ago" | wc -l)
ERROR_COUNT_MONTH=$(journalctl -p err --since="1 month ago" | wc -l)

CRIT_COUNT_YESTERDAY=$(journalctl -p crit --since=yesterday | wc -l)
CRIT_COUNT_WEEK=$(journalctl -p crit --since="1 week ago" | wc -l)
CRIT_EVENTS_YESTERDAY=$(journalctl -p crit --since=yesterday)
CRIT_EVENTS_WEEK=$(journalctl -p crit --since="1 week ago")
CRIT_EVENTS_MONTH=$(journalctl -p crit --since="1 month ago")
# Generate the report
{
    echo "Log Analysis Report - $(date)"
    echo "Analyzed Log File: $LOG_FILE"
    echo -e "\n$(basename $1) Total Error Count: $ERROR_COUNT"
    echo "$(basename $1) Total Warning Count: $WARNING_COUNT"
    echo -e "\n$(basename $1) Critical Events (line numbers):"

    if [ -z "$CRITICAL_EVENTS" ] && [ -z "$CRIT_COUNT_YESTERDAY" ] && [ "$CRIT_COUNT_WEEK" ]; then
        echo "No critical events found."
    else
	echo "$CRITICAL_EVENTS"
    fi

    echo -e "***************\nJOURNALCTL LOGS\n***************"
    echo "Error Count since yesterday: $ERROR_COUNT_YESTERDAY"
    echo "Error Count since 1 week: $ERROR_COUNT_WEEK"
    echo "Error Count since 1 month: $ERROR_COUNT_MONTH"
    echo -e "\nCritical events since yesterday: \n$CRIT_EVENTS_YESTERDAY"
    echo -e "\nCritical events since 1 week: \n$CRIT_EVENTS_WEEK"
    echo -e "\nCritical events since 1 month: \n$CRIT_EVENTS_MONTH"
    
} > "$REPORT_FILE"

echo "Analysis complete. Report saved to '$(pwd)/$REPORT_FILE'."
