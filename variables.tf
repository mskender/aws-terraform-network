variable cidr {
    description = "Main CIDR which we'll carve up into subnets. One per region"
    type = string
    default = "172.100.0.0/16"
}

variable create_igw {
    type=bool
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

variable crete_natgw {
    
    type=bool
    description = "Whether to create NAT Gateway for private subnets and attach it to the VPC"
}