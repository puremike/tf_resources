resource "aws_instance" "web" {
    # AMI NGINX = "ami-0f9b0c52c0cbf4f99"
    # AMI UBUNTU = "ami-07c8c1b18ca66bb07"
    ami = "ami-0f9b0c52c0cbf4f99"
    subnet_id = aws_subnet.public.id
    instance_type = "t3.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.pb-http-traffic.id]
    tags = merge(local.common_tags, {
        Name = "05-resources-ec2"
    })

    lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "pb-http-traffic" {
    description = "Security group to allow http and https traffic"
    name = "pb-http-traffic"
    vpc_id = aws_vpc.main.id
    tags = merge(local.common_tags, {
        Name = "05-resources-SG"
    })
}

resource "aws_vpc_security_group_ingress_rule" "http" {
    security_group_id = aws_security_group.pb-http-traffic.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
}
  
resource "aws_vpc_security_group_ingress_rule" "https" {
    security_group_id = aws_security_group.pb-http-traffic.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
}
