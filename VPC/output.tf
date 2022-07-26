output "vpc_range" {
    value= aws_vpc.demovpc


}
output "vpc_publci" {
        value= aws_subnet.public1
}
output "vpc_private1" {

        value= aws_subnet.private1
}
output "igw_value" {
    value= aws_internet_gateway.igwnew
}
output "nat_gateway_ip" {
  value = aws_eip.nat_gatewayeip.public_ip
}