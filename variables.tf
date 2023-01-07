
variable "api_url" {
  description = "Fully qualified path to bootstrap URL"
  default = "https://api.nuvulicloud.com/tenants/bootstrap/agent"
  type = string
}

variable "api_key" {
  description = "Javascript Web Token used to securely access Nuvuli Cloud API's"
  type = string
}

variable "tenant_id" {
  description = "Tenant UUID for your access to Nuvuli Cloud"
  type = string
}

variable "schedule_id" {
  description = "Schedule UUID for your access to Nuvuli Cloud Schedule"
  type = string
}

variable "account_id" {
  description = "AWS Cloud Account Number"
  type = string
}
