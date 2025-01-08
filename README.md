**loganal** creates a quick report for a chosen log file.

# Description
Example for syslog:
```
bash loganal.sh /var/log/syslog
```
or
```
chmod +x loganal.sh
./loganal.sh /var/log/syslog
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
Log Analysis Report - Mon Jan  1 12:34:56 AM CET 2025
Analyzed Log File: /var/log/syslog

syslog Total Error Count: 61
syslog Total Warning Count: 34

syslog Critical Events (line numbers):

***************
JOURNALCTL LOGS
***************
Error Count since yesterday: 22
Error Count since 1 week: 26
Error Count since 1 month: 41

Critical events since yesterday: 
Jan 10 14:46:17 ubuntu sudo[4163]: pam_unix(sudo:auth): auth could not identify password for [johndoe]

Critical events since 1 week: 
Jan 01 10:46:17 ubuntu sudo[4163]: pam_unix(sudo:auth): auth could not identify password for [johndoe]

Critical events since 1 month: 
Jan 01 10:46:17 ubuntu sudo[4163]: pam_unix(sudo:auth): auth could not identify password for [johndoe]
```
In addition to the chosen file, journalctl information is added

## Requirements for the email feature (Optional)

Install Postfix and bsd-mailx
- `sudo apt install postfix bsd-mailx`
    - Choose *internet site*
    - Type a name

Enable and start Postfix
- `sudo systemctl enable postfix`
- `sudo systemctl start postfix`

Configure
- `sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.old`
- `sudo vim /etc/postfix/main.cf`
     → Replace `inet_interfaces=all` with `inet_interfaces=loopback-only`

Autorize Postfix to communicate
- `sudo ufw allow Postfix`
- `sudo ufw allow "Postfix SMTPS"`
- `sudo ufw allow "Postfix Submission"`

### Test the SMTP server
- `telnet localhost 25`, you should see something like `220 hostname.isp.domain ESMTP Postfix (Hostname)`

- `mailx address@email.com` and then enter the Subject, content, CC, and check if you received the email

When it works, you can add the email address for the variable `MAIL_RECIPIENT` and use `loganal.sh`.
