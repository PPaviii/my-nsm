---
# Default values for vpn.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

registry: docker.io
org: networkservicemesh
tag: master
pullPolicy: IfNotPresent

global:
  # set to true to enable Jaeger tracing for NSM components
  JaegerTracing: false
root@corddev4:~/networkservicemesh/deployments/helm/example# cd templates/
root@corddev4:~/networkservicemesh/deployments/helm/example/templates# ls
example.yaml  firewall.tpl  iperf-client.tpl  iperf-server.tpl
root@corddev4:~/networkservicemesh/deployments/helm/example/templates# cat firewall.tpl
---
apiVersion: apps/v1
kind: Deployment
spec:
  selector:
    matchLabels:
      networkservicemesh.io/app: "firewall"
      networkservicemesh.io/impl: "example"
  replicas: 1
  template:
    metadata:
      labels:
        networkservicemesh.io/app: "firewall"
        networkservicemesh.io/impl: "example"
    spec:
      serviceAccount: nse-acc
      containers:
        - name: sidecar-nse
          image: raffaeletrani/sidecar-nse
          imagePullPolicy: IfNotPresent
          env:
            - name: ENDPOINT_NETWORK_SERVICE
              value: "example"
            - name: ENDPOINT_LABELS
              value: "app=firewall"
            - name: IP_ADDRESS
              value: "172.16.1.0/24"
            - name: NSM_NAMESPACE
              value: "nsm-system"
            - name: CLIENT_NETWORK_SERVICE
              value: "example"
            - name: CLIENT_LABELS
              value: "app=firewall"
          resources:
            limits:
              networkservicemesh.io/socket: 1
        - name: firewall-container
          image: raffaeletrani/iperf-container
          securityContext:
            capabilities:
              add: ["NET_ADMIN"]
          command: ['/bin/sh', '-c', 'sleep infinity']
metadata:
  name: firewall
  namespace: default
