# AWS STS
AWS STS - Role As A Service (RaaS)

![GitHub Actions - AWS STS Assume Role](https://github.com/emvaldes/raas/workflows/GitHub%20Actions%20-%20AWS%20STS%20Assume%20Role/badge.svg)

**<span style="color:red">1</span>** -) Create a Public|Private GitHub Repository for your project

**<span style="color:red">2</span>** -) Inject your project into your GitHub Repository

**<span style="color:red">3</span>** -) Create the GitHub Secrets to store sensitive|private data

```console
AWS_ACCESS_KEYPAIR:     Terraform AWS KeyPair (PEM file).
AWS_ACCESS_KEY_ID:      Terraform AWS Access Key-Id (e.g.: AKIA2...VT7DU).
AWS_DEFAULT_ACCOUNT:    The AWS Account number (e.g.: 123456789012).
AWS_DEFAULT_PROFILE:    The AWS Credentials Default User (e.g.: default).
AWS_DEFAULT_REGION:     The AWS Default Region (e.g.: us-east-1)
AWS_DEPLOY_TERRAFORM:   Enable|Disable (true|false) deploying terraform infrastructure
AWS_DESTROY_TERRAFORM:  Enable|Disable (true|false) destroying terraform infrastructure
AWS_SECRET_ACCESS_KEY:  Terraform AWS Secret Access Key (e.g.: zBqDUNyQ0G...IbVyamSCpe)
DEVOPS_ACCESS_POLICY:   Defines the STS TrustPolicy for the Terraform user.
DEVOPS_ACCESS_ROLE:     Defines the STS Assume-Role for the Terraform user.
DEVOPS_ACCOUNT_NAME:    A placeholder for the Deployment Service Account's name (terraform).
DEVOPS_ACCOUNT_ID:      It's intended to mask the AWS IAM User-ID when it gets listed.
INSPECT_DEPLOYMENT:     Control-Process to enable auditing infrastructure state.
UPDATE_PYTHON_LATEST:   Enforce the upgrade from the default 2.7 to symlink to the 3.6
UPDATE_SYSTEM_LATEST:   Enforce the upgrade of the Operating System.
```
**<span style="color:red">4</span>** -) Create a GitHub Action - Pipeline to deploy your project: .github/workflows/main.yaml <br>
**Note**: This is just a prototype of how to use this GitHub Action (uses: emvaldes/raas@v0.1)

[Pipeline Deployment](https://github.com/emvaldes/raas/blob/master/.github/workflows/main.yaml)

```console
name: GitHub Actions - AWS STS Assume Role
on: [push]
####----------------------------------------------------------------------------
env:
  ...
####----------------------------------------------------------------------------
jobs:
  credentials:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
        ...
####----------------------------------------------------------------------------
      - name: AWS STS Assume Role
        uses: ./
        id: request_credentials
        with:
          session-timestamp: 'DevOpsPipeline--20200827193000'
          aws-default-account: ${{ env.AWS_DEFAULT_ACCOUNT }}
          aws-access-key-id: ${{ env.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ env.AWS_SECRET_ACCESS_KEY }}
          aws-default-profile: 'default'
          aws-default-region: 'us-east-1'
          devops-access-role: ${{ env.DEVOPS_ACCESS_ROLE }}
          devops-account-id: ${{ env.DEVOPS_ACCOUNT_ID }}
          devops-account-name: ${{ env.DEVOPS_ACCOUNT_NAME }}
####----------------------------------------------------------------------------
```

**<span style="color:red">4</span>** -) The output will be like this:

```console
Injecting Default User-Credentials into AWS-Credentials file: /home/runner/work/raas/raas/.aws/credentials

Initiating STS Assume Role request ...
Fetched STS Assumed Role Values:

Constructed Session Items [array]:
AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_TOKEN_EXPIRES

Obtaining Caller Identity (Default-Role):
{
    "UserId": "***",
    "Account": "***",
    "Arn": "arn:aws:iam::***:user/***"
}

Injecting Credential: -> aws_access_key_id = ASIAS...C727X
Injecting Credential: -> aws_secret_access_key = jzpfr...mz0qC
Injecting Credential: -> aws_session_token = IQoJb3JpZ2...LzUd1QbDo=
Injecting Credential: -> x_principal_arn = arn:aws:iam::***:user/***
Injecting Credential: -> x_security_token_expires = 2020-08-28T18:27:33+00:00

Obtaining Caller Identity (Assumed-Role):
{
    "UserId": "***:DevOpsPipeline--20200827193000",
    "Account": "***",
    "Arn": "arn:aws:sts::***:assumed-role/***/DevOpsPipeline--20200827193000"
}
[
    {
        "Path": "/",
        "UserName": "***",
        "UserId": "***",
        "Arn": "arn:aws:iam::***:user/***",
        "CreateDate": "2020-08-23T05:03:10+00:00"
    }
]
```

Happy Coding & Share your work!
