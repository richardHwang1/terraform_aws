variable "pjt_name" {
  type        = string
  default     = "test"
}

variable "vpc_id" {
  type        = string
  default     = ""
}

variable "igw_id" {
  type        = string
  default     = ""
}

variable "sn_ids" {
  type        = map
  default     = {}
}