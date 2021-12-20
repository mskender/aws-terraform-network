
output private_subnets {
    
    value = var.create_private_subnets ? aws_subnet.private : [ ]

}

output public_subnets {
    
    value = var.create_public_subnets ? aws_subnet.public : []

}