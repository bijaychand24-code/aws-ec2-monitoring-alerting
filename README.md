# AWS EC2 Monitoring & Alerting

A hands-on AWS cloud operations project focused on monitoring an Ubuntu EC2 server, configuring CloudWatch alarms, and sending infrastructure alerts through Amazon SNS.

## Project Overview

This project demonstrates how to monitor the health and performance of an AWS EC2 instance using Amazon CloudWatch.

A CloudWatch alarm is configured to monitor CPU utilization. When CPU usage crosses the configured threshold, the alarm triggers an Amazon SNS notification and sends an alert to the subscribed email address.

The project also includes a Linux shell script for checking basic server health information such as CPU, memory, disk usage, uptime, and Nginx status.

## Architecture

```text
                    AWS Cloud
                        |
                        v
                +---------------+
                |  EC2 Ubuntu   |
                |   Web Server   |
                +-------+-------+
                        |
              CPU / Server Metrics
                        |
                        v
                +---------------+
                |  CloudWatch   |
                +-------+-------+
                        |
                 CloudWatch Alarm
                        |
                        v
                +---------------+
                |      SNS      |
                +-------+-------+
                        |
                        v
                   Email Alert
```

## AWS Services Used

* Amazon EC2
* Amazon CloudWatch
* Amazon SNS
* AWS IAM
* Ubuntu Linux
* Nginx

## Project Structure

```text
aws-ec2-monitoring-alerting/
│
├── README.md
│
├── scripts/
│   └── server-health.sh
│
├── architecture/
│   └── architecture.png
│
└── screenshots/
    ├── ec2-instance.png
    ├── nginx.png
    ├── cloudwatch-metrics.png
    ├── cloudwatch-alarm.png
    └── sns-email.png
```

## EC2 Setup

An Ubuntu EC2 instance was created for the monitoring environment.

Basic server configuration:

```bash
sudo apt update
sudo apt install nginx -y
```

Check Nginx:

```bash
sudo systemctl status nginx
```

The EC2 instance can be accessed through its public IP address using HTTP.

## Server Health Monitoring Script

The project includes a Bash script:

```text
scripts/server-health.sh
```

The script checks:

* Hostname
* Server uptime
* Memory usage
* Disk usage
* CPU usage
* Load average
* Nginx service status

Run the script:

```bash
chmod +x scripts/server-health.sh
./scripts/server-health.sh
```

## CloudWatch Monitoring

Amazon CloudWatch is used to monitor the EC2 instance.

The primary metric used in this project is:

```text
CPUUtilization
```

The metric is used to observe CPU usage of the EC2 instance.

## CloudWatch Alarm

A CloudWatch alarm is configured for high CPU utilization.

Example configuration:

```text
Metric: CPUUtilization
Condition: CPU > 70%
Period: 5 minutes
Action: Send notification through SNS
```

When the configured threshold is breached, the alarm changes to the `ALARM` state.

## SNS Alerting

Amazon SNS is used to send email notifications.

Flow:

```text
EC2
  ↓
CloudWatch Metric
  ↓
CloudWatch Alarm
  ↓
SNS Topic
  ↓
Email Notification
```

The email subscription must be confirmed before notifications can be delivered.

## Testing

The alerting workflow can be tested by generating temporary CPU load on the EC2 instance.

Install `stress-ng`:

```bash
sudo apt install stress-ng -y
```

Generate CPU load:

```bash
stress-ng --cpu 2 --timeout 300s
```

The expected workflow is:

```text
CPU utilization increases
        ↓
CloudWatch detects metric
        ↓
Threshold is breached
        ↓
CloudWatch Alarm → ALARM
        ↓
SNS notification
        ↓
Email alert
```

After the CPU load stops, the instance should return toward normal CPU utilization and the alarm can return to the `OK` state according to its configured evaluation period.

## Troubleshooting

### Check server health

```bash
./scripts/server-health.sh
```

### Check Nginx

```bash
sudo systemctl status nginx
```

### Check disk usage

```bash
df -h
```

### Check memory

```bash
free -h
```

### Check CPU and processes

```bash
top
```

### Check system logs

```bash
journalctl -xe
```

## Key Learnings

* EC2 instance management
* Ubuntu/Linux server administration
* Nginx installation and service management
* CloudWatch metrics and monitoring
* CloudWatch alarms
* SNS email notifications
* Basic Bash scripting
* Infrastructure troubleshooting
* Cloud operations fundamentals

## Future Improvements

* Add memory and disk monitoring
* Add CloudWatch Logs
* Create dashboards for multiple EC2 instances
* Integrate automated remediation
* Explore Auto Scaling based on CloudWatch alarms

## Disclaimer

This project is created for learning and demonstration purposes. AWS resources should be monitored and terminated when no longer required to avoid unnecessary charges.

