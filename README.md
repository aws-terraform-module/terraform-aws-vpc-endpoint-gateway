# terraform-aws-vpc-endpoint-gateway

Via Module, you can create S3 Endpoint Gateway easily  
You only provide:  
\- VPC ID  
\- Service name (e.g., com.amazonaws.us-west-2.s3, com.amazonaws.us-west-2.s3express, etc…)

```hcl
module "s3-endpoint-gateway" {
    source  = "aws-terraform-module/vpc-endpoint-gateway/aws"
    version = "1.0.0"
    vpc_id  = vpc-06f018be62beabffd
    service_name = "com.amazonaws.eu-central-1.s3"
}
```

#### Look into VPC-ENDPOINT

Refer to Document: [https://nimtechnology.com/2024/09/24/s3-aws-how-to-reduce-s3s-cost-by-the-gateway-and-interface-endpoints-privatelink/](https://nimtechnology.com/2024/09/24/s3-aws-how-to-reduce-s3s-cost-by-the-gateway-and-interface-endpoints-privatelink/)

#### Specific route table for Module to create 

Besides, you can determine the specific routes in VPC:

```hcl
module "s3-endpoint-gateway" {
    source  = "aws-terraform-module/vpc-endpoint-gateway/aws"
    version = "1.0.0"
    vpc_id  = vpc-06f018be62beabffd
    service_name = "com.amazonaws.eu-central-1.s3"
    route_table_ids = ["rtb-01a34cd8a5106b00c"]
}
```

Default: If route\_table\_ids are not provided, the module will attach all routes belonging to the specified VPC.

#### Add an Extra name for the VPC endpoint Gateway.

```hcl
module "s3-endpoint-gateway" {
    source  = "aws-terraform-module/vpc-endpoint-gateway/aws"
    version = "1.0.0"
    vpc_id  = vpc-06f018be62beabffd
    service_name = "com.amazonaws.eu-central-1.s3"
    route_table_ids = ["rtb-01a34cd8a5106b00c"]
    vpc_gateway_endpoint_name = "ahihi"
}
```

I usually get a VPC ID via remote TF state. You can refer to my code

```hcl
data terraform_remote_state "network" {
   backend = "s3"
   config = {
       bucket = "private-windows-mdaas-eks-tf-lock"
       key = "network.tfstate"
       region = "us-east-1"
    }
}

 

module "s3-endpoint-gateway" {
    source  = "aws-terraform-module/vpc-endpoint-gateway/aws"
    version = "1.0.0"
    vpc_id  = data.terraform_remote_state.network.outputs.vpc_id
    service_name = "com.amazonaws.eu-central-1.s3"
    route_table_ids = ["rtb-01a34cd8a5106b00c"]
    vpc_gateway_endpoint_name = "ahihi"
}
```

You can change the policy of `vpc-endpoint-gateway`

```plaintext
module "s3-endpoint-gateway" {
    source  = "aws-terraform-module/vpc-endpoint-gateway/aws"
    version = "1.0.0"
    vpc_id  = vpc-06f018be62beabffd
    service_name = "com.amazonaws.eu-central-1.s3"
    vpc_endpoint_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowS3Access",
      "Action": [
          "s3:*"
        ],
      "Effect": "Allow",
      "Resource": [
          "arn:aws:s3:::*"
        ],
      "Principal": "*"
    }
  ]
}
POLICY
}
```
