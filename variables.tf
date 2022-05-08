variable "location" {
  description = "Define região onde os recursos serão criados"
  type        = string
  default     = "West Europe"
}

variable "aws_pub_key" {
  description = "Public key para VM na AWS"
  type = string
}

variable "azure_pub_key" {
  description = "Public key para VM na Azure"
  type = string
}

