# Changelog

## [3.0.0](https://github.com/camptocamp/devops-stack-module-minio/compare/v2.2.0...v3.0.0) (2024-01-19)


### ⚠ BREAKING CHANGES

* remove the ArgoCD namespace variable
* remove the namespace variable

### Bug Fixes

* change condition to also support the selfsigned-issuer ([5cd6b70](https://github.com/camptocamp/devops-stack-module-minio/commit/5cd6b7051a882b46d9c386d6087ab2061490249f))
* change the default cluster issuer ([07c8350](https://github.com/camptocamp/devops-stack-module-minio/commit/07c8350a4748e9d8829ed2b4a6b7f2ec1b20a74b))
* hardcode the release name to remove the destination cluster ([a8b1fa4](https://github.com/camptocamp/devops-stack-module-minio/commit/a8b1fa477acc5fcb63a956ee77c0ca9e10859acb))
* remove the ArgoCD namespace variable ([c800bb0](https://github.com/camptocamp/devops-stack-module-minio/commit/c800bb00179f58ce3e40a78bd6345e374f095f66))
* remove the namespace variable ([c45a435](https://github.com/camptocamp/devops-stack-module-minio/commit/c45a435c29c390186d1ec38cbd55df34ffb53f13))

## [2.2.0](https://github.com/camptocamp/devops-stack-module-minio/compare/v2.1.0...v2.2.0) (2023-10-19)


### Features

* add standard variables and variable to add labels to Argo CD app ([611aceb](https://github.com/camptocamp/devops-stack-module-minio/commit/611aceb503f1436960919efd8e9565563c6c5647))
* add variables to set AppProject and destination cluster ([ad25865](https://github.com/camptocamp/devops-stack-module-minio/commit/ad25865f08ff1dcea77b915b48ebb5755b9dde80))

## [2.1.0](https://github.com/camptocamp/devops-stack-module-minio/compare/v2.0.1...v2.1.0) (2023-08-14)


### Features

* **chart:** patch update of dependencies on minio chart ([#41](https://github.com/camptocamp/devops-stack-module-minio/issues/41)) ([6363233](https://github.com/camptocamp/devops-stack-module-minio/commit/6363233191e4eac5a63edc17684c03945b039f85))

## [2.0.1](https://github.com/camptocamp/devops-stack-module-minio/compare/v2.0.0...v2.0.1) (2023-08-09)


### Bug Fixes

* readd support to deactivate auto-sync which was broken by [#37](https://github.com/camptocamp/devops-stack-module-minio/issues/37) ([e40434d](https://github.com/camptocamp/devops-stack-module-minio/commit/e40434dd13ad7d13c350c9588cd6ce8c32dacb41))

## [2.0.0](https://github.com/camptocamp/devops-stack-module-minio/compare/v1.1.2...v2.0.0) (2023-07-11)


### ⚠ BREAKING CHANGES

* add support to oboukili/argocd >= v5 ([#37](https://github.com/camptocamp/devops-stack-module-minio/issues/37))

### Features

* add support to oboukili/argocd &gt;= v5 ([#37](https://github.com/camptocamp/devops-stack-module-minio/issues/37)) ([bcf507c](https://github.com/camptocamp/devops-stack-module-minio/commit/bcf507ca2c83f400417dc1257fa37b61176d0963))
* setup auto-upgrade helm chart ([#30](https://github.com/camptocamp/devops-stack-module-minio/issues/30)) ([085b53e](https://github.com/camptocamp/devops-stack-module-minio/commit/085b53e5184fbe3c15cf4780b17548e7f1c7053d))


### Bug Fixes

* chart version ([#32](https://github.com/camptocamp/devops-stack-module-minio/issues/32)) ([bf1d223](https://github.com/camptocamp/devops-stack-module-minio/commit/bf1d223e33434139c15e179d89bae98cbc2b2927))

## [1.1.2](https://github.com/camptocamp/devops-stack-module-minio/compare/v1.1.1...v1.1.2) (2023-06-09)


### Bug Fixes

* fix the secret when using letsencrypt-staging ([ffbb35e](https://github.com/camptocamp/devops-stack-module-minio/commit/ffbb35e26d88e289b7de018390780b11b0e2011d))
* remove the need for the optional by using null ([cf8e4bf](https://github.com/camptocamp/devops-stack-module-minio/commit/cf8e4bfbd2b1577e29d63b53fe04438c263989da))

## [1.1.1](https://github.com/camptocamp/devops-stack-module-minio/compare/v1.1.0...v1.1.1) (2023-05-30)


### Bug Fixes

* add default argocd_namespace ([4bad9f5](https://github.com/camptocamp/devops-stack-module-minio/commit/4bad9f54a291af5b2e62321e372e6b9c8798c990))
* add missing providers ([af38d7b](https://github.com/camptocamp/devops-stack-module-minio/commit/af38d7bef3d86ed103c9e5aa8913d6bd09095459))

## [1.1.0](https://github.com/camptocamp/devops-stack-module-minio/compare/v1.0.0...v1.1.0) (2023-05-15)


### Features

* **metrics:** add flag to enable ServiceMonitor ([4f34387](https://github.com/camptocamp/devops-stack-module-minio/commit/4f34387cc890fe49ec10a257edbb8e1eff1a075b))
* **oidc:** add oidc configuration to the helm_values local ([83f46d5](https://github.com/camptocamp/devops-stack-module-minio/commit/83f46d576c619519cfe87fa8fa4e0ccb40421e75))
* update chart to v5.0.9 ([6549c75](https://github.com/camptocamp/devops-stack-module-minio/commit/6549c751834afaab5e7009d72298709070b95970))

## 1.0.0 (2023-04-24)


### Features

* add locals basic cofiguration ([33787f9](https://github.com/camptocamp/devops-stack-module-minio/commit/33787f900cc0fefa2a1f8383af3d4ea4f4a989a9))
* add minio helm chart ([f6078d3](https://github.com/camptocamp/devops-stack-module-minio/commit/f6078d35eea09bf4b80eb818a297d18bd7d37b3a))
* add random password for rootUser ([a012e84](https://github.com/camptocamp/devops-stack-module-minio/commit/a012e847db7dff2982c6b3326cb3fbded2d8fee7))
* add root user and password for test ([c8ec251](https://github.com/camptocamp/devops-stack-module-minio/commit/c8ec251448fe4e1a5293c7686194a9309fe253bb))
* add variable for policies - users -buckets creation ([c8f8ccf](https://github.com/camptocamp/devops-stack-module-minio/commit/c8f8ccfd7f51cacc7723fae9461aa9c9ef5af17a))
* call minio_config var in local.tf ([775a95c](https://github.com/camptocamp/devops-stack-module-minio/commit/775a95c773465b1375e9b075807d71cb4880e434))
* Configuration ArgoCD application for the module ([52e0160](https://github.com/camptocamp/devops-stack-module-minio/commit/52e0160e4a5b4b9f28362b25ab352402a243ae55))
* output minio endpoint ([2423667](https://github.com/camptocamp/devops-stack-module-minio/commit/24236675e37cc8ce310d401ab4e60422e0991ddf))
* output root random password ([07d91d7](https://github.com/camptocamp/devops-stack-module-minio/commit/07d91d7b57eadc77f13dc3c0db42b6e043321dd0))


### Bug Fixes

* activate release please workflow ([a3e4fc6](https://github.com/camptocamp/devops-stack-module-minio/commit/a3e4fc6793fe8e9e6012f7ac8a4a196e4209998f))
* add correct namespace to minio project and app ([ac6bfcd](https://github.com/camptocamp/devops-stack-module-minio/commit/ac6bfcdf751c5d78a05eec962331846b7de95226))
* add messing varaible base_domain ([17c23e8](https://github.com/camptocamp/devops-stack-module-minio/commit/17c23e80f76c3a54a371a5b7737e2813b0c7713f))
* add missing cluster_issuer varaible ([e05ed22](https://github.com/camptocamp/devops-stack-module-minio/commit/e05ed22d51935482de40db2e5686413ab4b2f547))
* add missing namespace variable to minio module ([3ea2f81](https://github.com/camptocamp/devops-stack-module-minio/commit/3ea2f81dd0bfc6e8c2022a9697f088a7be473453))
* correction of syntax for antora ([17d6233](https://github.com/camptocamp/devops-stack-module-minio/commit/17d623348b94589115a6a88dd05bcbaf02300278))
* output root password ([50833d2](https://github.com/camptocamp/devops-stack-module-minio/commit/50833d2ec27ebe1afc8e09618d817c91fcd2822f))
* readme.adoc ([08537dc](https://github.com/camptocamp/devops-stack-module-minio/commit/08537dcd8c5386e03aec8e47b88b96113978053f))
* root password length ([c7680f8](https://github.com/camptocamp/devops-stack-module-minio/commit/c7680f82ed8d54131782f86c47e7dac71a08f65e))
* terraform syntax ([a10a131](https://github.com/camptocamp/devops-stack-module-minio/commit/a10a13109f11072f866975bb573932702963e984))
