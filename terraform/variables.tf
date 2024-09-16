variable "ami_id" {
  description = "AMI id for ec2 instance"
  type        = string
  default     = "ami-0522ab6e1ddcc7055"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
