
# Drycc Monitor v2

[![Build Status](https://woodpecker.drycc.cc/api/badges/drycc/monitor/status.svg)](https://woodpecker.drycc.cc/drycc/monitor)

Drycc (pronounced DAY-iss) Workflow is an open source Platform as a Service (PaaS) that adds a developer-friendly layer to any [Kubernetes](http://kubernetes.io) cluster, making it easy to deploy and manage applications on your own servers.

For more information about the Drycc Workflow, please visit the main project page at https://github.com/drycc/workflow.

We welcome your input! If you have feedback, please [submit an issue][issues]. If you'd like to participate in development, please read the "Development" section below and [submit a pull request][prs].

# About
This repository aims to contain the necessary components for a production quality monitoring solution that runs on top of the kubernetes cluster scheduler. It provides part of the [TICK](https://influxdata.com/time-series-platform/) stack which is produced by the influxdata team.

## Current State
Currently this repo provides only 2 components (Telegraf, and Grafana). Telegraf is the metrics collection agent that runs using the daemon set API. For more infomation please read [this](telegraf/README.md).

Grafana is a stand alone graphing application. It natively supports Influxdb as a datasource and provides a robust engine for creating dashboards on top of timeseries data. We provide a few out of the box dashboards for monitoring Drycc Workflow and Kubernetes but please feel free to use them as a starting point for creating your own dashboards.

# Architecture Diagram

```
                        ┌────────┐                            
                        │ Router │                  ┌────────┐
                        └────────┘                  │ Logger │
                            │                       └────────┘
                        Log file                        │    
                            │                           │    
                            ▼                           ▼    
┌────────┐             ┌─────────┐    logs/metrics   ┌──────────────┐
│App Logs│──Log File──▶│ fluentd │───────topics─────▶│ Redis Stream │
└────────┘             └─────────┘                   └──────────────┘
                                                        │    
                                                        │    
┌─────────────┐                                         │    
│ HOST        │                                         ▼    
│  Telegraf   │───┐                                ┌────────┐
└─────────────┘   │                                │Telegraf│
                  │                                └────────┘
┌─────────────┐   │                                    │    
│ HOST        │   │    ┌───────────┐                   │    
│  Telegraf   │───┼───▶│ InfluxDB  │◀────Wire ─────────┘    
└─────────────┘   │    └───────────┘   Protocol       
                  │          ▲                        
┌─────────────┐   │          │                        
│ HOST        │   │          ▼                        
│  Telegraf   │───┘    ┌──────────┐                   
└─────────────┘        │ Grafana  │                   
                       └──────────┘                                        
```

[k8s-home]: http://kubernetes.io/
[issues]: https://github.com/drycc/monitor/issues
[prs]: https://github.com/drycc/monitor/pulls
[v2.18]: https://github.com/drycc/workflow/releases/tag/v2.18.0

