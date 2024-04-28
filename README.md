# terragrunt-dependency-resolver

## Usage
```bash
./terragrunt-dependency-resolver.sh main
```

## Example
```
$ ./terragrunt-dependency-resolver.sh main
dev/iam/terraform
dev/database/aurora_postgres
qa/iam/terraform

$ ./terragrunt_changes.sh | grep ^dev | sed 's/^dev\/\?/.\//'| grep -v '^$'
./iam/terraform
./database/aurora_postgres

$ ./terragrunt_changes.sh | grep ^qa | sed 's/^qa\/\?/.\//'| grep -v '^$'
./iam/terraform
./
```

![image](https://github.com/kritish-dhaubanjar/terragrunt-dependency-resolver/assets/25634165/dfb21da6-efd6-4f18-9114-d1d5ed17bcf1)


## Directory Structure Example
```shell
├── dev
│   ├── api
│   │   └── terragrunt.hcl
│   ├── common_vars.hcl
│   ├── database
│   │   ├── dynamodb
│   │   │   └── terragrunt.hcl
│   └── web_portals
│       └── analytics
│           └── terragrunt.hcl
├── Dockerfile
├── _env
│   ├── api.hcl
│   ├── dynamodb.hcl
│   └── web_portal.hcl
├── global_vars.hcl
├── index.html
├── modules
│   ├── service
│   │   ├── dynamodb
│   │   │   ├── main.tf
│   │   ├── ec2
│   │   │   ├── main.tf
│   └── workflow
│       ├── api_ecs
│       │   ├── main.tf
│       └── dynamodb_tables
│           ├── main.tf
│           └── variables.tf
└── terragrunt-dependency-resolver.sh
```

| Before | After |
|-|-|
|![image](https://github.com/kritish-dhaubanjar/terragrunt-dependency-resolver/assets/25634165/10497013-ea2c-4827-a81b-44ed97103d22)|![image](https://github.com/kritish-dhaubanjar/terragrunt-dependency-resolver/assets/25634165/8c236f39-e963-4a08-9d5a-eac184c2002a)|


## Pricing calculator
![image](https://github.com/kritish-dhaubanjar/terragrunt-dependency-resolver/assets/25634165/8f7a89ab-5acf-4cb3-8543-208ecca36390)
