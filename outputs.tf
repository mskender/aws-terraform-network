output "vpc" {
    value = aws_vpc.main
}

output route_table {

    value = aws_route_table.default
}