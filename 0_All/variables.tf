variable "resource_group_name" {}
variable "sql_db_name" {}
variable "sql_server_name" {}

variable "location" {
  type        = string
  description = "Location used for all resources"
}
