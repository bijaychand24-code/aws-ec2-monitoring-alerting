#!/bin/bash

echo "======================================"
echo "        SERVER HEALTH REPORT"
echo "======================================"

echo ""
echo "Hostname:"
hostname

echo ""
echo "Uptime:"
uptime -p

echo ""
echo "Memory Usage:"
free -h

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)"

echo ""
echo "Load Average:"
uptime | awk -F'load average:' '{ print $2 }'

echo ""
echo "Nginx Status:"
systemctl is-active nginx

echo ""
echo "======================================"
echo "        HEALTH CHECK COMPLETED"
echo "======================================"
