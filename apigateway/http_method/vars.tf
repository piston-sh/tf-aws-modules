variable "rest_api_id" {}
variable "resource_id" {}

variable "http_method" {
  default = "GET"
}

variable "enabled" {
  default = true
}

variable "cognito_authorizer_id" {
  default = ""
}

variable "custom_request_parameters" {
  type    = "map"
  default = {}
}
