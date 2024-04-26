# terragrunt-dependency-resolver

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
│   │   │   ├── autoscaling.tf
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variables.tf
│   │   ├── ec2
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   └── workflow
│       ├── api_ecs
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variable.tf
│       └── dynamodb_tables
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
├── plan.html
├── Readme.md
└── terragrunt-dependency-resolver.sh
```

```yaml
- name: Find changes
    id: changes
    shell: bash
    run: |
        git fetch origin ${{ github.base_ref }}
        ./terragrunt-dependency-resolver.sh ${{ github.base_ref }} > changes.list

        touch ${{ matrix.environment }}.terragrunt.list
        cat changes.list | grep ^${{ matrix.environment }} | cut -d / -f 2- > ${{ matrix.environment }}.terragrunt.list || true

        if ! [[ -s ${{ matrix.environment }}.terragrunt.list ]]; then
            echo "No changes to plan/apply"
            echo "TERRAGRUNT_INCLUDE_PATHS=--terragrunt-include-dir=" >> $GITHUB_ENV
            exit 0
        fi

        include_paths=""

        for change in $(cat ${{ matrix.environment }}.terragrunt.list); do
            include_paths="${include_paths} --terragrunt-include-dir=$change"
        done

        echo "TERRAGRUNT_INCLUDE_PATHS=${include_paths}" >> $GITHUB_ENV
```

| Before | After |
|-|-|
|![image](https://github.com/kritish-dhaubanjar/terragrunt-dependency-resolver/assets/25634165/10497013-ea2c-4827-a81b-44ed97103d22)|![image](https://github.com/kritish-dhaubanjar/terragrunt-dependency-resolver/assets/25634165/8c236f39-e963-4a08-9d5a-eac184c2002a)|


## Pricing calculator
![image](https://github.com/kritish-dhaubanjar/terragrunt-dependency-resolver/assets/25634165/8f7a89ab-5acf-4cb3-8543-208ecca36390)
