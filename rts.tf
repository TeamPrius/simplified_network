# Presentation Layer Public Route Table For Public Subnets
resource "aws_route_table" "transit_gateway_route" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = aws_subnet.public_subnet_onprem.cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

  tags = {
    Name = "PublicRouteTable1"
  }
}


#Create Public Route table1 associations

resource "aws_route_table_association" "availability_zone_1_transit_gateway_route_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.transit_gateway_route.id
}

resource "aws_route_table_association" "availability_zone_2_transit_gateway_route_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.transit_gateway_route.id
}
###########################################################################################


# Business Logic Layer Private Route Table For Private Subnet 3

resource "aws_route_table" "bus_log_layer_rt" {
  vpc_id = aws_vpc.prod_vpc.id
}


# create public route table association for Private Subnet 1
resource "aws_route_table_association" "bus_log_layer_rta_availability_zone_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.bus_log_layer_rt.id
}


# create private route table association for Private Subnet 3
resource "aws_route_table_association" "bus_log_layer_rta" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.bus_log_layer_rt.id
}


###########################################################################################