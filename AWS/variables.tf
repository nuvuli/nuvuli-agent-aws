
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

variable "schedule_name" {
  description = "Display name for this schedule"
  type = string
}

variable "matching_tags" {
  description = "Comma-separated list of Key=Value pairs cloud resources must attach in order to be managed"
  type = string
}

variable "schedule" {
  description = "JSON object representing hours where resources are to be turned OFF"
  type = string
}

variable "paused" {
  description = "If the schedule is paused, it will NOT manage resources in any way."
  type = bool
}
