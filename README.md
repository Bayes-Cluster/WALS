# WALS

A successor of [MESOCP](https://github.com/bayes-cluster/MESOCP)

```bash
sudo docker build -f Dockerfile.BASE -t bayes-cluster/wals-base:latest ./
sudo docker build -f Dockerfile -t bayes-cluster/wals-server:latest ./
sudo docker compose up -d 
```