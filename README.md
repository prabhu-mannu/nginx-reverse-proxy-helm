# nginx-helm-reverse-proxy

#### Pre-requisite

- **helm chart default values are filled in to work with k8s on docker for mac**

- install nginx ingress controller

```bash
make install-ingress  
```

- install demo upstream app for default deployment to work

```bash
make install-demo-upstream
```

#### To install without https support

```bash
make install
```

#### To install with https support

```bash
make install-with-ssl
```

#### To increase number of replicas

```bash
helm upgrade --install nginx-demo nginx --set replicaCount=2
```

#### To enable ssl

```bash
helm upgrade --install nginx-demo nginx --set ingress.tlsEnabled=true
```

#### To disable ssl

```bash
helm upgrade --install nginx-demo nginx --set ingress.tlsEnabled=false
```

#### To configure upstream servers
```bash
helm upgrade --install nginx-demo nginx --set upstream.hosts={"httpbin:8000"}
```
