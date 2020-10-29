---
apiVersion: apps/v1
kind: Deployment
spec:
  selector:
    matchLabels:
      networkservicemesh.io/app: "iperf-client"
      networkservicemesh.io/impl: "example"
  replicas: 1
  template:
    metadata:
      labels:
        networkservicemesh.io/app: "iperf-client"
        networkservicemesh.io/impl: "example"
    spec:
      serviceAccount: nsc-acc
      containers:
      - name: iperf3-client
        image: raffaeletrani/iperf-container
        securityContext:
          capabilities:
            add: ["NET_ADMIN"]
        command: ['/bin/sh', '-c', 'sleep infinity']
      terminationGracePeriodSeconds: 0
metadata:
  name: iperf-client
  namespace: default
  annotations:
    ns.networkservicemesh.io: example
