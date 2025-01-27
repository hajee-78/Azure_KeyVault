variable "resource_group_name" {
    default = "dev"
}
variable "location" {
    default = "SouthEast Asia" 
}
variable "vnet" {
    default = ["10.0.0.0/16"]
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet" {
  default = ["10.0.1.0/24"]
}
