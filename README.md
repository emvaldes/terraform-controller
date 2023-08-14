# Provision Terraform - Infrastructure As Code (IaC)
GitHub Actions - Provision Terraform - Infrastructure As Code (IaC)

![GitHub Actions - Terraform Controller](https://github.com/emvaldes/terraform-controller/workflows/GitHub%20Actions%20-%20Terraform%20Controller/badge.svg)

```console
$ treee ~/Repos/devops/github/modules/terraform-controller/
├── .github/
│   ├── templates/
│   │   └── manage-terraform.shell
│   └── workflows/
│       ├── terraform-controller.yaml
│       └── terraform-restore.yaml
├── .gitignore
├── LICENSE
├── README.md
├── _config.yml
├── action.functions
├── action.yaml
├── configs/
│   ├── dev-configs.tfvars
│   ├── prod-configs.tfvars
│   └── uat-configs.tfvars
├── main.tf
├── modules/
│   └── s3/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── terraform.tfvars
├── variables.tf
├── website/
│   ├── corporate.jpg
│   └── index.html
└── workspace

7 directories, 22 files
```

```yaml
workflow_dispatch:
  name: Manual Deployment
  description: 'Triggering Manual Deployment'
  inputs:
    accesskey:
      description: 'Target Access Key-ID'
      required: false
      default: ''
    account:
      description: 'Target AWS Account'
      required: false
      default: ''
    destroy-terraform:
      description: 'Terraform Destroy Request'
      required: false
      default: true
    keypair-name:
      description: 'Private Key-Pair Name'
      required: false
      default: ''
    keypair-secret:
      description: 'Private Key-Pair Secret'
      required: false
      default: ''
    region:
      description: 'Target AWS Region'
      required: false
      default: ''
    secretkey:
      description: 'Target Secret Access-Key'
      required: false
      default: ''
    workspace:
      description: 'Terraform Workspace'
      required: false
      default: 'dev'
```

```yaml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_DEFAULT_ACCOUNT: ${{ secrets.AWS_DEFAULT_ACCOUNT }}
  AWS_DEFAULT_PROFILE: ${{ secrets.AWS_DEFAULT_PROFILE }}
  AWS_DEFAULT_REGION: ${{ secrets.AWS_DEFAULT_REGION }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  ## Terraform Operations: Deploy, Destroy
  BACKUP_TERRAFORM: ${{ secrets.BACKUP_TERRAFORM }}
  DEPLOY_TERRAFORM: ${{ secrets.DEPLOY_TERRAFORM }}
  DESTROY_TERRAFORM: ${{ secrets.DESTROY_TERRAFORM }}
  ## DEVOPS_ASSUMEROLE_POLICY
  ## DEVOPS_BOUNDARIES_POLICY
  ## DEVOPS_ACCESS_POLICY
  DEVOPS_ACCESS_ROLE: ${{ secrets.DEVOPS_ACCESS_ROLE }}
  DEVOPS_ACCOUNT_NAME: ${{ secrets.DEVOPS_ACCOUNT_NAME }}
  DYNAMODB_DEFAULT_REGION: ${{ secrets.DYNAMODB_DEFAULT_REGION }}
  ## INSPECT_DEPLOYMENT
  PRIVATE_KEYPAIR_FILE: ${{ secrets.PRIVATE_KEYPAIR_FILE }}
  PRIVATE_KEYPAIR_NAME: ${{ secrets.PRIVATE_KEYPAIR_NAME }}
  PRIVATE_KEYPAIR_SECRET: ${{ secrets.PRIVATE_KEYPAIR_SECRET }}
  PROVISION_TERRAFORM: ${{ secrets.PROVISION_TERRAFORM }}
  TARGET_WORKSPACE: ${{ secrets.TARGET_WORKSPACE }}
  ## UPDATE_PYTHON_LATEST
  ## UPDATE_SYSTEM_LATEST
  ##
  S3BUCKET_CONTAINER: pipelines
  terraform_input_params: ''
```

GitHub Secrets (Required):

```bash
AWS_ACCESS_KEY_ID           Service-Account AWS Access Key-Id (e.g.: AKIA2...VT7DU).
AWS_DEFAULT_ACCOUNT         The AWS Account number (e.g.: 123456789012).
AWS_DEFAULT_PROFILE         The AWS Credentials Default User (e.g.: default)
AWS_DEFAULT_REGION          The AWS Default Region (e.g.: us-east-1)
AWS_SECRET_ACCESS_KEY       Service-Account AWS Secret Access Key (e.g.: zBqDUNyQ0G...IbVyamSCpe)
BACKUP_TERRAFORM            Enable|Disable (true|false) backing-up terraform plan/state
DEPLOY_TERRAFORM            Enable|Disable (true|false) deploying terraform infrastructure
DESTROY_TERRAFORM           Enable|Disable (true|false) destroying terraform infrastructure
DEVOPS_ACCESS_POLICY        Defines the AWS IAM Policy: DevOps--Custom-Access.Policy
DEVOPS_ACCESS_ROLE          Defines the AWS IAM Role: DevOps--Custom-Access.Role
DEVOPS_ACCOUNT_NAME         A placeholder for the Deployment Service Account name (devops)
DEVOPS_ASSUMEROLE_POLICY    Defines the AWS IAM Policy: DevOps--Assume-Role.Policy
DEVOPS_BOUNDARIES_POLICY    Defines the AWS IAM Policy: Devops--Permission-Boundaries.Policy
DYNAMODB_DEFAULT_REGION     Single-Region tables are used (e.g.: us-east-1)
INSPECT_DEPLOYMENT          Enable|Disable (true|false) inspecting deployment
PRIVATE_KEYPAIR_FILE        Terraform AWS KeyPair (location: devops.pem)
PRIVATE_KEYPAIR_NAME        Terraform AWS KeyPair (e.g.: devops)
PRIVATE_KEYPAIR_SECRET      Terraform AWS KeyPair (PEM, Private file)
PROVISION_TERRAFORM         Enable|Disable (true|false) the provisioning of the terraform-toolset
S3BUCKET_CONTAINER          Identifies where the deployment will be stored
TARGET_WORKSPACE            Identifies which is your default (current) environment
UPDATE_PYTHON_LATEST        Enable|Disable (true|false) updating Python version
UPDATE_SYSTEM_LATEST        Enable|Disable (true|false) updating operating system
```

```bash
$ amazon-assumerole default--devops devops DevOpsPipeline ;
```

```bash
[default--devops]
aws_access_key_id = ASIA2XV4BKOYHQQXMIU7
aws_secret_access_key = ez33R69zA8125yt48t2QYBv202d5AFLlxUaMe41o
aws_session_token = IQoJb3JpZ2luX2VjECYaCXVzLWVhc3QtMSJGMEQCIHyVn5cxkd9zpgoPQ7WufaDD2FcNDjxZRAIdVLgixH6mAiApRkDjzvSernVBDnXB04gcmPsqo2sdo7ysxTpVN+iaISqqAghOEAAaDDczODA1NDk4NDYyNCIMaKoey/WvyA5YyqejKocCuWFNIPeijL2GczxgAMiQ3BoNzDBH65TRJVK1ybwESF+AQ5KLj5bZxsLh9DVqhpTLxA6XTJ5Mgjdqvvv2HTvimZSK0aIy3IBEtvvEK2w63VR/c81IKIltx3Naq48OUqJX54T4Qy/Af5QlF/Ho59YNHnjmSwY6smkLik5UXwLubn5Ne/vCYIWVw4L1JOHI5AozBnvNgBmkgcsS6eWy2g4y0x+7RPQVIOCWrJINRqGCYws9uQfXT96d379JWbmXCiaiAPbld0T88pRb/lsMe72YUeIc1+9COTJFUk70mvD1nG9Z9/he4c/KnYFw4fAf4mQvefWViRn8lasGWEmzaFKip6X5MEZLl6cw/sTO+wU6ngGJzj+vaUiLbDjw8mWfa2bIEM8DD1mrf0z/KkOjYsjdQmT8xoENS0h3OIOV6H0f9f5vtyAYNz78YMpH2Tkd4oXKjirQQDgTVNG+GdD8VZ49TWMzu1rHTebj5pJIoRVjEhI1dWBdn25qWVmiqL/Ghe95fPFrIhGhCcvtqL1tcRp4cr8jx+0zhsk+uhjQHO/XNip4/Mwd6JzdZdW/+IM8xA==
x_principal_arn = arn:aws:iam::123456789012:user/devops
x_security_token_expires = 2020-09-29T22:09:18+00:00
```

```json
{
    "UserId": "AROA2XV4BKOYLAX3Z52SQ:DevOpsPipeline-20200929140916",
    "Account": "123456789012",
    "Arn": "arn:aws:sts::123456789012:assumed-role/DevOps--Custom-Access.Role/DevOpsPipeline-20200929140916"
}
```

```bash
$ amazon-credentials default--devops ;
```

```console
$ terraform init ;

Initializing modules...
- bucket in modules/s3
Downloading terraform-aws-modules/vpc/aws 2.15.0 for vpc...
- vpc in .terraform/modules/vpc

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Finding latest version of hashicorp/random...
- Finding latest version of hashicorp/template...
- Installing hashicorp/random v2.3.0...
- Installed hashicorp/random v2.3.0 (signed by HashiCorp)
- Installing hashicorp/template v2.1.2...
- Installed hashicorp/template v2.1.2 (signed by HashiCorp)
- Installing hashicorp/aws v3.8.0...
- Installed hashicorp/aws v3.8.0 (signed by HashiCorp)

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, we recommend adding version constraints in a required_providers block
in your configuration, with the constraint strings suggested below.

* hashicorp/aws: version = "~> 3.8.0"
* hashicorp/random: version = "~> 2.3.0"
* hashicorp/template: version = "~> 2.1.2"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```console
$ terraform workspace new dev ;

Created and switched to workspace "dev"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```


```bash
$ terraform plan \
    -var="region=${AWS_DEFAULT_REGION}" \
    -var="aws_access_key=${AWS_ACCESS_KEY_ID}" \
    -var="aws_secret_key=${AWS_SECRET_ACCESS_KEY}" \
    -var="private_keypair_file=${HOME}/.ssh/domains/default/private/default" \
    -var="private_keypair_name=devops" \
    -var-file="configs/dev-configs.tfvars" \
    -out terraform.tfstate.d/dev/terraform.tfplan
  ;
```

```console
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.template_file.public_cidrsubnet[0]: Refreshing state...
data.aws_elb_hosted_zone_id.main: Refreshing state...
data.aws_ami.aws-linux: Refreshing state...
data.aws_availability_zones.available: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
```

```yaml
  + create

Terraform will perform the following actions:

  # aws_elb.web will be created
  + resource "aws_elb" "web" {
    ...
    }

  # aws_instance.nginx[0] will be created
  + resource "aws_instance" "nginx" {
    ...
    }

  # aws_s3_object.graphic will be created
  + resource "aws_s3_object" "graphic" {
    ...
    }

  # aws_security_group.elb-sg will be created
  + resource "aws_security_group" "elb-sg" {
    ...
    }

  # aws_security_group.nginx-sg will be created
  + resource "aws_security_group" "nginx-sg" {
    ...
    }

  # random_integer.rand will be created
  + resource "random_integer" "rand" {
    ...
    }

  # module.bucket.aws_iam_instance_profile.instance_profile will be created
  + resource "aws_iam_instance_profile" "instance_profile" {
    ...
    }

  # module.bucket.aws_iam_role.allow_instance_s3 will be created
  + resource "aws_iam_role" "allow_instance_s3" {
    ...
    }

  # module.bucket.aws_iam_role_policy.allow_s3_all will be created
  + resource "aws_iam_role_policy" "allow_s3_all" {
    ...
    }

  # module.bucket.aws_s3_bucket_acl.web_bucket will be created
  + resource "aws_s3_bucket_acl" "web_bucket" {
    ...
    }

  # module.vpc.aws_internet_gateway.this[0] will be created
  + resource "aws_internet_gateway" "this" {
    ...
    }

  # module.vpc.aws_route.public_internet_gateway[0] will be created
  + resource "aws_route" "public_internet_gateway" {
    ...
    }

  # module.vpc.aws_route_table.public[0] will be created
  + resource "aws_route_table" "public" {
    ...
    }

  # module.vpc.aws_route_table_association.public[0] will be created
  + resource "aws_route_table_association" "public" {
    ...
    }

  # module.vpc.aws_subnet.public[0] will be created
  + resource "aws_subnet" "public" {
    ...
    }

  # module.vpc.aws_vpc.this[0] will be created
  + resource "aws_vpc" "this" {
    ...
    }

Plan: 16 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: terraform.tfstate.d/dev/terraform.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "terraform.tfstate.d/dev/terraform.tfplan"
```

```bash
$ terraform apply "terraform.tfstate.d/dev/terraform.tfplan" ;

random_integer.rand: Creating...
random_integer.rand: Creation complete after 0s [id=36748]
module.bucket.aws_iam_role.allow_instance_s3: Creating...
module.vpc.aws_vpc.this[0]: Creating...
module.bucket.aws_s3_bucket_acl.web_bucket: Creating...
module.bucket.aws_iam_role.allow_instance_s3: Creation complete after 1s [id=terraform-dev-36748_allow_instance_s3]
module.bucket.aws_iam_role_policy.allow_s3_all: Creating...
module.bucket.aws_iam_instance_profile.instance_profile: Creating...
module.bucket.aws_iam_role_policy.allow_s3_all: Creation complete after 0s [id=terraform-dev-36748_allow_instance_s3:terraform-dev-36748_allow_all]
module.bucket.aws_iam_instance_profile.instance_profile: Creation complete after 1s [id=terraform-dev-36748_instance_profile]
module.vpc.aws_vpc.this[0]: Creation complete after 4s [id=vpc-08601ba0c7d611f63]
module.vpc.aws_route_table.public[0]: Creating...
module.vpc.aws_internet_gateway.this[0]: Creating...
module.vpc.aws_subnet.public[0]: Creating...
aws_security_group.elb-sg: Creating...
aws_security_group.nginx-sg: Creating...
module.vpc.aws_route_table.public[0]: Creation complete after 1s [id=rtb-00bc8c353eb56e391]
module.vpc.aws_subnet.public[0]: Creation complete after 2s [id=subnet-07ccd80b42959356e]
module.vpc.aws_route_table_association.public[0]: Creating...
module.vpc.aws_internet_gateway.this[0]: Creation complete after 2s [id=igw-01679506397fbf208]
module.vpc.aws_route.public_internet_gateway[0]: Creating...
module.vpc.aws_route_table_association.public[0]: Creation complete after 0s [id=rtbassoc-07f9d9a7a503e7d7c]
module.vpc.aws_route.public_internet_gateway[0]: Creation complete after 1s [id=r-rtb-00bc8c353eb56e3911080289494]
aws_security_group.elb-sg: Creation complete after 4s [id=sg-06ec7a84be35e7914]
aws_security_group.nginx-sg: Creation complete after 4s [id=sg-0d296ac58a656dc62]
module.bucket.aws_s3_bucket_acl.web_bucket: Still creating... [10s elapsed]
module.bucket.aws_s3_bucket_acl.web_bucket: Creation complete after 11s [id=terraform-dev-36748]
aws_s3_object.graphic: Creating...
aws_instance.nginx[0]: Creating...
aws_s3_object.graphic: Creation complete after 1s [id=/website/corporate.jpg]
aws_instance.nginx[0]: Still creating... [10s elapsed]
...
aws_instance.nginx[0]: Still creating... [30s elapsed]
aws_instance.nginx[0]: Provisioning with 'file'...
aws_instance.nginx[0]: Still creating... [40s elapsed]
...
aws_instance.nginx[0]: Still creating... [1m40s elapsed]
aws_instance.nginx[0]: Provisioning with 'file'...
aws_instance.nginx[0]: Provisioning with 'file'...
aws_instance.nginx[0]: Provisioning with 'remote-exec'...
aws_instance.nginx[0] (remote-exec): Connecting to remote host via SSH...
aws_instance.nginx[0] (remote-exec):   Host: 52.3.228.143
aws_instance.nginx[0] (remote-exec):   User: ec2-user
aws_instance.nginx[0] (remote-exec):   Password: false
aws_instance.nginx[0] (remote-exec):   Private key: true
aws_instance.nginx[0] (remote-exec):   Certificate: false
aws_instance.nginx[0] (remote-exec):   SSH Agent: true
aws_instance.nginx[0] (remote-exec):   Checking Host Key: false
aws_instance.nginx[0]: Still creating... [1m50s elapsed]
aws_instance.nginx[0]: Still creating... [2m0s elapsed]
aws_instance.nginx[0] (remote-exec): Connecting to remote host via SSH...
aws_instance.nginx[0] (remote-exec):   Host: 52.3.228.143
aws_instance.nginx[0] (remote-exec):   User: ec2-user
aws_instance.nginx[0] (remote-exec):   Password: false
aws_instance.nginx[0] (remote-exec):   Private key: true
aws_instance.nginx[0] (remote-exec):   Certificate: false
aws_instance.nginx[0] (remote-exec):   SSH Agent: true
aws_instance.nginx[0] (remote-exec):   Checking Host Key: false
aws_instance.nginx[0] (remote-exec): Connected!
aws_instance.nginx[0] (remote-exec): Loaded plugins: priorities, update-motd,
aws_instance.nginx[0] (remote-exec):               : upgrade-helper
aws_instance.nginx[0] (remote-exec): Resolving Dependencies
aws_instance.nginx[0] (remote-exec): --> Running transaction check
aws_instance.nginx[0] (remote-exec): ---> Package nginx.x86_64 1:1.18.0-1.40.amzn1 will be installed
aws_instance.nginx[0] (remote-exec): --> Processing Dependency: libprofiler.so.0()(64bit) for package: 1:nginx-1.18.0-1.40.amzn1.x86_64
aws_instance.nginx[0] (remote-exec): --> Running transaction check
aws_instance.nginx[0] (remote-exec): ---> Package gperftools-libs.x86_64 0:2.0-11.5.amzn1 will be installed
aws_instance.nginx[0] (remote-exec): --> Processing Dependency: libunwind.so.8()(64bit) for package: gperftools-libs-2.0-11.5.amzn1.x86_64
aws_instance.nginx[0] (remote-exec): --> Running transaction check
aws_instance.nginx[0] (remote-exec): ---> Package libunwind.x86_64 0:1.1-10.8.amzn1 will be installed
aws_instance.nginx[0] (remote-exec): --> Finished Dependency Resolution
aws_instance.nginx[0] (remote-exec): Dependencies Resolved
aws_instance.nginx[0] (remote-exec): ========================================
aws_instance.nginx[0] (remote-exec):  Package   Arch   Version
aws_instance.nginx[0] (remote-exec):                      Repository    Size
aws_instance.nginx[0] (remote-exec): ========================================
aws_instance.nginx[0] (remote-exec): Installing:
aws_instance.nginx[0] (remote-exec):  nginx     x86_64 1:1.18.0-1.40.amzn1
aws_instance.nginx[0] (remote-exec):                      amzn-updates 602 k
aws_instance.nginx[0] (remote-exec): Installing for dependencies:
aws_instance.nginx[0] (remote-exec):  gperftools-libs
aws_instance.nginx[0] (remote-exec):            x86_64 2.0-11.5.amzn1
aws_instance.nginx[0] (remote-exec):                      amzn-main    570 k
aws_instance.nginx[0] (remote-exec):  libunwind x86_64 1.1-10.8.amzn1
aws_instance.nginx[0] (remote-exec):                      amzn-main     72 k
aws_instance.nginx[0] (remote-exec): Transaction Summary
aws_instance.nginx[0] (remote-exec): ========================================
aws_instance.nginx[0] (remote-exec): Install  1 Package (+2 Dependent packages)
aws_instance.nginx[0] (remote-exec): Total download size: 1.2 M
aws_instance.nginx[0] (remote-exec): Installed size: 3.0 M
aws_instance.nginx[0] (remote-exec): Downloading packages:
aws_instance.nginx[0] (remote-exec): (1/3): libunwind-1 |  72 kB   00:00
aws_instance.nginx[0] (remote-exec): (2/3): gperftools- | 570 kB   00:00
aws_instance.nginx[0] (remote-exec): (3/3): nginx- 100% | 1.2 MB   --:-- ETA
aws_instance.nginx[0] (remote-exec): (3/3): nginx-1.18. | 602 kB   00:00
aws_instance.nginx[0] (remote-exec): ----------------------------------------
aws_instance.nginx[0] (remote-exec): Total      2.0 MB/s | 1.2 MB  00:00
aws_instance.nginx[0] (remote-exec): Running transaction check
aws_instance.nginx[0] (remote-exec): Running transaction test
aws_instance.nginx[0] (remote-exec): Transaction test succeeded
aws_instance.nginx[0] (remote-exec): Running transaction
aws_instance.nginx[0] (remote-exec):   Installing : libunwin [         ] 1/3
...
aws_instance.nginx[0] (remote-exec):   Installing : libunwind-1.1-10.8   1/3
aws_instance.nginx[0] (remote-exec):   Installing : gperftoo [         ] 2/3
...
aws_instance.nginx[0] (remote-exec):   Installing : gperftoo [######## ] 2/3
aws_instance.nginx[0] (remote-exec):   Installing : gperftools-libs-2.   2/3
aws_instance.nginx[0] (remote-exec):   Installing : 1:nginx- [         ] 3/3
...
aws_instance.nginx[0] (remote-exec):   Installing : 1:nginx- [######## ] 3/3
aws_instance.nginx[0] (remote-exec):   Installing : 1:nginx-1.18.0-1.4   3/3
aws_instance.nginx[0] (remote-exec):   Verifying  : 1:nginx-1.18.0-1.4   1/3
aws_instance.nginx[0] (remote-exec):   Verifying  : gperftools-libs-2.   2/3
aws_instance.nginx[0] (remote-exec):   Verifying  : libunwind-1.1-10.8   3/3
aws_instance.nginx[0] (remote-exec): Installed:
aws_instance.nginx[0] (remote-exec):   nginx.x86_64 1:1.18.0-1.40.amzn1
aws_instance.nginx[0] (remote-exec): Dependency Installed:
aws_instance.nginx[0] (remote-exec):   gperftools-libs.x86_64 0:2.0-11.5.amzn1
aws_instance.nginx[0] (remote-exec):   libunwind.x86_64 0:1.1-10.8.amzn1
aws_instance.nginx[0] (remote-exec): Complete!
aws_instance.nginx[0] (remote-exec): Starting nginx:       [  OK  ]
aws_instance.nginx[0]: Still creating... [2m10s elapsed]
aws_instance.nginx[0] (remote-exec): Collecting s3cmd
aws_instance.nginx[0] (remote-exec):   Downloading https://files.pythonhosted.org/packages/26/44/19e08f69b2169003f7307565f19449d997895251c6a6566ce21d5d636435/s3cmd-2.1.0-py2.py3-none-any.whl (145kB)
aws_instance.nginx[0] (remote-exec):
aws_instance.nginx[0] (remote-exec):     7% |██▎                             | 10kB 39.4MB/s eta 0:00:01
...
aws_instance.nginx[0] (remote-exec):     100% |████████████████████████████████| 153kB 2.9MB/s
aws_instance.nginx[0] (remote-exec): Collecting python-magic (from s3cmd)
aws_instance.nginx[0] (remote-exec):   Downloading https://files.pythonhosted.org/packages/59/77/c76dc35249df428ce2c38a3196e2b2e8f9d2f847a8ca1d4d7a3973c28601/python_magic-0.4.18-py2.py3-none-any.whl
aws_instance.nginx[0] (remote-exec): Requirement already satisfied: python-dateutil in /usr/lib/python2.7/dist-packages (from s3cmd)
aws_instance.nginx[0] (remote-exec): Requirement already satisfied: six in /usr/lib/python2.7/dist-packages (from python-dateutil->s3cmd)
aws_instance.nginx[0] (remote-exec): Installing collected packages: python-magic, s3cmd
aws_instance.nginx[0] (remote-exec): Successfully installed python-magic-0.4.18 s3cmd-2.1.0
aws_instance.nginx[0] (remote-exec): You are using pip version 9.0.3, however version 20.2.3 is available.
aws_instance.nginx[0] (remote-exec): You should consider upgrading via the 'pip install --upgrade pip' command.
aws_instance.nginx[0] (remote-exec): download: 's3://terraform-dev-36748/website/corporate.jpg' -> './corporate.jpg'  [1 of 1]
aws_instance.nginx[0] (remote-exec):  41686 of 41686   100% in    0s   351.27 KB/s
aws_instance.nginx[0] (remote-exec):  41686 of 41686   100% in    0s   350.64 KB/s  done
aws_instance.nginx[0] (remote-exec): upload: '/var/log/nginx/access.log' -> 's3://terraform-dev-36748/nginx/i-0c77a6dfacc236aba/access.log'  [1 of 3]
aws_instance.nginx[0] (remote-exec):  0 of 0     0% in    0s     0.00 B/s
aws_instance.nginx[0] (remote-exec):  0 of 0     0% in    0s     0.00 B/s  done
aws_instance.nginx[0] (remote-exec): upload: '/var/log/nginx/access.log-20200930.gz' -> 's3://terraform-dev-36748/nginx/i-0c77a6dfacc236aba/access.log-20200930.gz'  [2 of 3]
aws_instance.nginx[0] (remote-exec):  20 of 20   100% in    0s    21.73 KB/s
aws_instance.nginx[0] (remote-exec):  20 of 20   100% in    0s   750.10 B/s  done
aws_instance.nginx[0] (remote-exec): upload: '/var/log/nginx/error.log' -> 's3://terraform-dev-36748/nginx/i-0c77a6dfacc236aba/error.log'  [3 of 3]
aws_instance.nginx[0] (remote-exec):  0 of 0     0% in    0s     0.00 B/s
aws_instance.nginx[0] (remote-exec):  0 of 0     0% in    0s     0.00 B/s  done
aws_instance.nginx[0] (remote-exec): remote copy: 'access.log-20200930.gz' -> 'error.log-20200930.gz'
aws_instance.nginx[0] (remote-exec): Done. Uploaded 20 bytes in 1.0 seconds, 20.00 B/s.
aws_instance.nginx[0]: Creation complete after 2m13s [id=i-0c77a6dfacc236aba]
aws_elb.web: Creating...
aws_elb.web: Creation complete after 6s [id=dev-nginx-elb-36748]

Apply complete! Resources: 16 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate

Outputs:

aws_elb_public_dns = dev-nginx-elb-36748-1893652761.us-east-1.elb.amazonaws.com
cname_record_url = http://prototype.devops-sandbox.com
custom_contact = Updated - emvaldes@yahoo.com
custom_engineer = Updated - DevOps Team
custom_listset = Updated - Proving Nothing
custom_mapset = Updated - Testing Something
custom_timestamp = Updated - Today Is A Good Day To ...
filebased_parameters = Updated - Development Parameters loaded from a custom parameter file
resources_index = 36748
```

```bash
$ host dev-nginx-elb-36748-1893652761.us-east-1.elb.amazonaws.com;

dev-nginx-elb-36748-1893652761.us-east-1.elb.amazonaws.com has address 107.21.103.47
dev-nginx-elb-36748-1893652761.us-east-1.elb.amazonaws.com has address 18.205.134.116
```

```bash
$ terraform destroy ;

random_integer.rand: Refreshing state... [id=36748]
data.template_file.public_cidrsubnet[0]: Refreshing state... [id=a34d80f7b68bf2b583681f727bae85f5a202ee100ad60ab3b3d351b9ce929539]
data.aws_availability_zones.available: Refreshing state... [id=2020-09-30 00:10:06.441389 +0000 UTC]
data.aws_ami.aws-linux: Refreshing state... [id=ami-032930428bf1abbff]
module.bucket.aws_iam_role.allow_instance_s3: Refreshing state... [id=terraform-dev-36748_allow_instance_s3]
data.aws_elb_hosted_zone_id.main: Refreshing state... [id=Z35SXDOTRQ7X7K]
module.bucket.aws_s3_bucket_acl.web_bucket: Refreshing state... [id=terraform-dev-36748]
module.vpc.aws_vpc.this[0]: Refreshing state... [id=vpc-08601ba0c7d611f63]
module.bucket.aws_iam_instance_profile.instance_profile: Refreshing state... [id=terraform-dev-36748_instance_profile]
module.bucket.aws_iam_role_policy.allow_s3_all: Refreshing state... [id=terraform-dev-36748_allow_instance_s3:terraform-dev-36748_allow_all]
aws_security_group.elb-sg: Refreshing state... [id=sg-06ec7a84be35e7914]
aws_security_group.nginx-sg: Refreshing state... [id=sg-0d296ac58a656dc62]
module.vpc.aws_subnet.public[0]: Refreshing state... [id=subnet-07ccd80b42959356e]
module.vpc.aws_internet_gateway.this[0]: Refreshing state... [id=igw-01679506397fbf208]
module.vpc.aws_route_table.public[0]: Refreshing state... [id=rtb-00bc8c353eb56e391]
module.vpc.aws_route.public_internet_gateway[0]: Refreshing state... [id=r-rtb-00bc8c353eb56e3911080289494]
module.vpc.aws_route_table_association.public[0]: Refreshing state... [id=rtbassoc-07f9d9a7a503e7d7c]
aws_s3_object.graphic: Refreshing state... [id=/website/corporate.jpg]
aws_instance.nginx[0]: Refreshing state... [id=i-0c77a6dfacc236aba]
aws_elb.web: Refreshing state... [id=dev-nginx-elb-36748]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
```

```yaml
  - destroy

Terraform will perform the following actions:

  # aws_elb.web will be destroyed
  - resource "aws_elb" "web" {
    ...
    }

  # aws_instance.nginx[0] will be destroyed
  - resource "aws_instance" "nginx" {
    ...
    }

  # aws_s3_object.graphic will be destroyed
  - resource "aws_s3_object" "graphic" {
    ...
    }

  # aws_security_group.elb-sg will be destroyed
  - resource "aws_security_group" "elb-sg" {
    ...
    }

  # aws_security_group.nginx-sg will be destroyed
  - resource "aws_security_group" "nginx-sg" {
    ...
    }

  # random_integer.rand will be destroyed
  - resource "random_integer" "rand" {
    ...
    }

  # module.bucket.aws_iam_instance_profile.instance_profile will be destroyed
  - resource "aws_iam_instance_profile" "instance_profile" {
    ...
    }

  # module.bucket.aws_iam_role.allow_instance_s3 will be destroyed
  - resource "aws_iam_role" "allow_instance_s3" {
    ...
    }

  # module.bucket.aws_iam_role_policy.allow_s3_all will be destroyed
  - resource "aws_iam_role_policy" "allow_s3_all" {
    ...
    }

  # module.bucket.aws_s3_bucket_acl.web_bucket will be destroyed
  - resource "aws_s3_bucket_acl" "web_bucket" {
    ...
    }

  # module.vpc.aws_internet_gateway.this[0] will be destroyed
  - resource "aws_internet_gateway" "this" {
    ...
    }

  # module.vpc.aws_route.public_internet_gateway[0] will be destroyed
  - resource "aws_route" "public_internet_gateway" {
    ...
    }

  # module.vpc.aws_route_table.public[0] will be destroyed
  - resource "aws_route_table" "public" {
    ...
    }

  # module.vpc.aws_route_table_association.public[0] will be destroyed
  - resource "aws_route_table_association" "public" {
    ...
    }

  # module.vpc.aws_subnet.public[0] will be destroyed
  - resource "aws_subnet" "public" {
    ...
    }

  # module.vpc.aws_vpc.this[0] will be destroyed
  - resource "aws_vpc" "this" {
    ...
    }

Plan: 0 to add, 0 to change, 16 to destroy.

Changes to Outputs:
  - aws_elb_public_dns   = "dev-nginx-elb-36748-1893652761.us-east-1.elb.amazonaws.com" -> null
  - cname_record_url     = "http://prototype.devops-sandbox.com" -> null
  - custom_contact       = "Updated - emvaldes@yahoo.com" -> null
  - custom_engineer      = "Updated - DevOps Team" -> null
  - custom_listset       = "Updated - Proving Nothing" -> null
  - custom_mapset        = "Updated - Testing Something" -> null
  - custom_timestamp     = "Updated - Today Is A Good Day To ..." -> null
  - filebased_parameters = "Updated - Development Parameters loaded from a custom parameter file" -> null
  - resources_index      = 36748 -> null

Do you really want to destroy all resources in workspace "dev"?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.vpc.aws_route_table_association.public[0]: Destroying... [id=rtbassoc-07f9d9a7a503e7d7c]
aws_s3_object.graphic: Destroying... [id=/website/corporate.jpg]
module.vpc.aws_route.public_internet_gateway[0]: Destroying... [id=r-rtb-00bc8c353eb56e3911080289494]
aws_elb.web: Destroying... [id=dev-nginx-elb-36748]
aws_s3_object.graphic: Destruction complete after 1s
module.vpc.aws_route.public_internet_gateway[0]: Destruction complete after 0s
module.vpc.aws_internet_gateway.this[0]: Destroying... [id=igw-01679506397fbf208]
module.vpc.aws_route_table_association.public[0]: Destruction complete after 1s
module.vpc.aws_route_table.public[0]: Destroying... [id=rtb-00bc8c353eb56e391]
module.vpc.aws_route_table.public[0]: Destruction complete after 1s
aws_elb.web: Destruction complete after 6s
aws_security_group.elb-sg: Destroying... [id=sg-06ec7a84be35e7914]
aws_instance.nginx[0]: Destroying... [id=i-0c77a6dfacc236aba]
module.vpc.aws_internet_gateway.this[0]: Still destroying... [id=igw-01679506397fbf208, 10s elapsed]
aws_instance.nginx[0]: Still destroying... [id=i-0c77a6dfacc236aba, 10s elapsed]
aws_security_group.elb-sg: Still destroying... [id=sg-06ec7a84be35e7914, 10s elapsed]
module.vpc.aws_internet_gateway.this[0]: Still destroying... [id=igw-01679506397fbf208, 20s elapsed]
aws_security_group.elb-sg: Destruction complete after 19s
aws_instance.nginx[0]: Still destroying... [id=i-0c77a6dfacc236aba, 20s elapsed]
module.vpc.aws_internet_gateway.this[0]: Still destroying... [id=igw-01679506397fbf208, 30s elapsed]
aws_instance.nginx[0]: Still destroying... [id=i-0c77a6dfacc236aba, 30s elapsed]
module.vpc.aws_internet_gateway.this[0]: Still destroying... [id=igw-01679506397fbf208, 40s elapsed]
aws_instance.nginx[0]: Destruction complete after 36s
module.bucket.aws_iam_role_policy.allow_s3_all: Destroying... [id=terraform-dev-36748_allow_instance_s3:terraform-dev-36748_allow_all]
module.bucket.aws_iam_instance_profile.instance_profile: Destroying... [id=terraform-dev-36748_instance_profile]
module.vpc.aws_subnet.public[0]: Destroying... [id=subnet-07ccd80b42959356e]
aws_security_group.nginx-sg: Destroying... [id=sg-0d296ac58a656dc62]
module.bucket.aws_s3_bucket_acl.web_bucket: Destroying... [id=terraform-dev-36748]
module.vpc.aws_internet_gateway.this[0]: Destruction complete after 43s
module.bucket.aws_iam_role_policy.allow_s3_all: Destruction complete after 1s
aws_security_group.nginx-sg: Destruction complete after 1s
module.vpc.aws_subnet.public[0]: Destruction complete after 1s
module.vpc.aws_vpc.this[0]: Destroying... [id=vpc-08601ba0c7d611f63]
module.bucket.aws_iam_instance_profile.instance_profile: Destruction complete after 2s
module.bucket.aws_iam_role.allow_instance_s3: Destroying... [id=terraform-dev-36748_allow_instance_s3]
module.vpc.aws_vpc.this[0]: Destruction complete after 1s
module.bucket.aws_iam_role.allow_instance_s3: Destruction complete after 1s
module.bucket.aws_s3_bucket_acl.web_bucket: Destruction complete after 8s
random_integer.rand: Destroying... [id=36748]
random_integer.rand: Destruction complete after 0s

Destroy complete! Resources: 16 destroyed.
```
