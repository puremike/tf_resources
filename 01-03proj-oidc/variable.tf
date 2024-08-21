variable "openIDURL" {
  type        = string
  default     = "https://app.terraform.io"
  description = "OpenID Connect URL for Terraform"
}

variable "terraform_cloud_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The default credentials for terraform aws (audience)"
}

variable "thumbprint_list" {
  type    = string
  default = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

variable "policy_arn" {
    type = string
    default = "arn:aws:iam::aws:policy/AdministratorAccess"
    description = "the policy arn of the attached policy"
}

variable "role_arn" {
    type = string
    default = "arn:aws:iam::533267037869:oidc-provider/app.terraform.io"
    description = "role arn"
}