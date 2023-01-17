# s3bench: Simple app to benchmark s3 services

- based on https://github.com/shpaz/s3bench/


To run:
- Configure your awscli environment
- Run:
```bash
make provision
make build-image
make push image
make helm-deploy
```
- Wait for the the kibana dashboard to be alive.
- Create an index for `s3-perf-index`.
- Open the `Demo` dashboard.