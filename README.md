# devops-stack-module-minio

A [DevOps Stack](https://devops-stack.io) module to deploy and configure [MinIO](https://min.io/).


## Usage

```hcl
module "storage" {
  source = "git::https://github.com/camptocamp/devops-stack-module-minio.git//modules"

  cluster_info     = module.cluster.info
  cluster_issuer   = "ca-issuer"

  minio = {
    buckets = {
      loki = {}
      thanos = {}
    }
  }

  depends_on = [ module.monitoring ]
}
```
