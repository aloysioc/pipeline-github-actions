variable "location" {
  description = "Define região onde os recursos serão criados"
  type        = string
  default     = "N. Virginia"
}

variable "aws_pub_key" {
  description = "Public key para VM na AWS"
  type = string
}

