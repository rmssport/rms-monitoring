# What is in this repository?

This repository contains easily deployable monitoring solution which uses:
 - Grafana (frontend for monitoring + alerts)
 - Prometheus (monitoring solution pulling metrics from exporter)
 - Telegraf (monitoring agent)
 - InfluxDB (persistent timeseries storage)
 - alertmanager (alerting)


# How to build it
cd telegraf
sudo docker build -t rms-telegraf .

# How to run it
sudo docker-compose up -d

# Where to run
Any linux with docker capabilities will do.
Should also work in WSL

# SNMP
# Calculate throughput from Octes
bps = ((poll2 -poll1)*8)/time_in_seconds_between_polls