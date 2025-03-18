variable "vpc_gateway_endpoint_name" {
    type        = string
    description = "(Optional) Specify name for VPC Gateway Endpoint"
    default     = ""
}

variable "vpc_id" {
    type        = string
    description = "ID of the VPC where the cluster security group will be provisioned"
}


variable "service_name" {
    type        = string
    description = "(Required) The service name. For AWS services the service name is usually in the form `com.amazonaws.<region>.<service>` (the SageMaker Notebook service is an exception to this rule, the service name is in the form `aws.sagemaker.<region>.notebook)`"
}


variable "route_table_ids" {
    type        = list(string)
    description = "(Optional) One or more route table IDs. Applicable for endpoints of type. If set to '[]', the VPC endpoint will automatically be associated with the main route table of the VPC."
    default     = []
}

variable "vpc_endpoint_policy" {
  description = "The policy for the VPC endpoint"
  type        = string
  default     = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY
}