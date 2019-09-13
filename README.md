# home-firewall

## Introduction
I have a homelab, and it is not very big. To save costs, my homelab is also the internet router/firewall. My goal was to minimise my use of virtual machines in order to save resources. Running my gateway inside a container means I have a standard configuration for my firewall, managed by Kubernetes.

## Quickstart
```
$ git clone https://github.com/lnattrass/docker.home-firewall.git
$ cd docker.home-firewall
$ vim docker.home-firewall/values.yaml
  # Adjust accordingly.
$ helm template --name=firewall docker.home-firewall > firewall.yaml
$ kubectl apply -f firewall.yaml
```

My local testing configuration is available in [test/config/config.yaml](test/config/config.yaml)

## Features

- Keepalived for fast failover within the StatefulSet
- Conntrackd keeps connection state synces
- Bird for any routing [I use calico + multus on my K8S cluster)
- Zerotier [disabled by default) for VPN
- Metrics support [nftables_exporter](https://github.com/Sheridan/nftables_exporter)
- Policy routing for the kubernetes interface
- Jinja2 templating based on the contents of config.yaml

## Requirements
In order to use this, you need to have a CNI plugin that supports multiple interfaces. 

I am currently using [Multus-CNI](https://github.com/intel/multus-cni) with [Calico](https://github.com/projectcalico/calico) and the CNI [bridge](https://github.com/containernetworking/plugins/tree/master/plugins/main/bridge) plugin. (I use v0.8.1 as it has support for adding bridge networks with _no_ IPAM, which is what I want.)

### TLDR
You need
- [Multus-CNI](https://github.com/intel/multus-cni)
- Layer-2 networking between pods, for firewall/vrrp state synchronisation

