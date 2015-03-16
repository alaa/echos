
# Echos
[![Build Status](https://travis-ci.org/alaa/echos.svg?branch=master)](https://travis-ci.org/alaa/echos)

[WIP] Echos is a simple monitoring tool built mainly for microservices architecture, It has a modular event store layer and publishes all metrics to it.

Echos runs on the top of eventmachine and uses a simple YAML configurations file to load its checks.
Every check has the following attributes

- command [mandatory]
- path [optional, default: $PATH]
- interval [optional, default: 30]
- timeout [optional, default: 5]

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
  interval: 30
  timeout: 2

check_database_replication:
  command: check_mysql_replication
  path: /usr/local/custom/checks

check_external_ruby_script:
  command: ruby ~/checks/online_users.rb
```

## Run echos with the [--config] or [-c] option:
```echos_ctl start -- -c /path/to/checks.yml```

## License
MIT
