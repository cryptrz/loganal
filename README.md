**loganal** creates a quick report for a chosen log file.

Example for syslog:
```
bash loganal.sh /var/log/syslog
```
When the analysis is done, a message with the report's path appears, it's saved in the current folder: 
```
Analysis complete. Report saved to '/home/johndoe/loganal/log_report_2025-01-01.txt'.
```
Then you can read it using cat:
```
cat log_report_2025-01-01.txt
```
The report looks like this:
```
Log Analysis Report - Mon Jan  1 01:23:45 AM CET 2025
Analyzed Log File: /var/log/syslog
Total Error Count: 32
Total Warning Count: 40

Critical Events (line numbers):
No critical events found.

```
