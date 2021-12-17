variable region {

    description = "Region in which to create resources."
    type = string
    default = "eu-west-1"
}
variable cidr {
    description = "Main CIDR which we'll carve up into subnets. One per region"
    type = string
    default = "172.100.0.0/16"
}

variable create_igw {
    type=bool
    default = true
    description = "Whether to create Internet Gateway and attach it to the VPC"
}

variable create_public_subnets {
    type = bool
    description = "Whether to create public-facing, igw-attached subnets"
    default = false
}

variable create_private_subnets {
    type = bool
    description = "Whether to create private subnets"
    default = false
}

variable subnet_size {

    type = number
    description = "CIDR (slash) size of (both) public and private subnets. Must be in range [18-28]"
    default = 24
}

variable create_natgw {
    
    type=bool
    description = "Whether to create NAT Gateway for private subnets and attach it to the VPC"
}

variable tags {

    
    default = null
    description = "Tags to apply to all created objects (vpc, subnets, igw and natgw)"
}

variable prefix {
    type = string
    default = ""
    description = "A string to prefix all resource names for easier sorting"
}

variable suffix {
    type = string
    default = ""
    description = "A string to suffix all resource names."
}

variable map_public_ips {
    description = "Map public IP's to resources in public subnets"
    default = false
    type = string 

}