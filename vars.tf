variable "REGION" {
  default = "us-east-1"
}

variable "BUCKET_NAME" {
  default = "vprofile-terraform"
}

variable "FOLDER_NAME1" {
  default = "terraform"
}

variable "FOLDER_NAME2" {
  default = "sshkey"
}

variable "AMIs" {
  type = map(any)
  default = {
    ap-south-1 = "ami-0851b76e8b1bce90b"
    us-east-1  = "ami-04505e74c0741db8d"
  }
}

variable "PRIVATE_KEY_PATH" {
  default = "vprofilekey"
}

variable "PUBLIC_KEY_PATH" {
  default = "vprofilekey.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "RMQUSER" {
  default = "rabbit"
}

variable "RMQPASS" {
  default = "Gr33n@pple123456"
}

variable "DBUSER" {
  default = "admin"
}

variable "DBPASS" {
  default = "admin123"
}

variable "DBNAME" {
  default = "accounts"
}

variable "INSTANCE_COUNT" {
  default = "1"
}

variable "VPC_NAME" {
  default = "vprofile-VPC"
}

variable "ZONE_A" {
  default = "us-east-1a"
}

variable "ZONE_B" {
  default = "us-east-1b"
}

variable "ZONE_C" {
  default = "us-east-1c"
}

variable "VPC_CIDR" {
  default = "172.21.0.0/16"
}

variable "PUB_SUBA_CIDR" {
  default = "172.21.1.0/24"
}

variable "PUB_SUBB_CIDR" {
  default = "172.21.2.0/24"
}

variable "PUB_SUBC_CIDR" {
  default = "172.21.3.0/24"
}

variable "PRIV_SUBA_CIDR" {
  default = "172.21.4.0/24"
}

variable "PRIV_SUBB_CIDR" {
  default = "172.21.5.0/24"
}

variable "PRIV_SUBC_CIDR" {
  default = "172.21.6.0/24"
}