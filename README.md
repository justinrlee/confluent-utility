# confluent-utility
Kitchen Sink container for working with Kafka and Confluent

No guarantees or warranties provided.

Provides the following:
* Clients:
  * kafka-X CLI tools (from Confluent package)
  * confluent CLI
  * kcat (formerly kafkacat)
  * vault
  * kubectl
  * aws
  * ldapsearch
* Network tools:
  * ping
  * dig
  * curl
  * telnet
  * nslookup
  * openssl
* Misc:
  * jq
  * yq
  * unzip
  * vim
  * less
  * full Java JDK

## Use (kubernetes)

Sample Kubernetes manifest to run the utility in a Kubernetes cluster:

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: confluent-utility
  namespace: confluent
spec:
  selector:
    matchLabels:
      app: confluent-utility
  serviceName: "confluent-utility"
  replicas: 1
  template:
    metadata:
      labels:
        app: confluent-utility
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: utility
        image: justinrlee/confluent-utility:latest
```

Once running, you can exec in with:

```bash
kubectl -n confluent exec -it confluent-utility -- bash
```

## Build
Build system for confluent-utility

Usually run on an x86-64 Ubuntu EC2 instance. Does a multi-arch (amd64 and arm64) build, but you need to set up multiarch:

```bash
./scripts/install_prereqs.sh
```

Once Docker is installed, log out and log back in (to inherit new permissions). Then do:

```bash
# Replace with your username
docker login -u justinrlee
```

Download all packages (both amd64 and arm64)

```bash
./scripts/downloads.sh
```

Local build only (will create different tag for each architecture)

```bash
./scripts/build.sh
```

Create and push multi-arch image

```bash
./scripts/push.sh
```