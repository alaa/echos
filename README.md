
# Echos
[![Build Status](https://travis-ci.org/alaa/echos.svg?branch=master)](https://travis-ci.org/alaa/echos)

### Simple monitoring system for Micro-Services

## Requirements:
* Ruby Version > 2.1.4
* RabbitMQ for the Bus communications

# Usage:
## Define your system checks in the checks.yml
```
check_load:
  command: check_load -w 2 -w 3
  path: /usr/lib/nagios/plugins/

check_ntp:
  command: check_ntp -H localhost -w 0.5 -c 1.0
  path: /usr/lib/nagios/plugins/

check_http:
  command: check_http -H localhost
  path: /usr/lib/nagios/plugins/

check_database_replication:
  command: check_mysql_replication
  path: /usr/local/custom/checks

check_open_ports:
  command: nmap -PN0 localhost
  interval: 30

check_external_ruby_script:
  command: ruby ~/checks/online_users.rb
```

## Run echos with the [--config] or [-c] option:
```echos_ctl start -- -c /path/to/checks.yml```
