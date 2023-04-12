resource "aws_security_group" "negative6" {
  ingress {
    from_port         = 3306
    to_port           = 3306
    protocol          = "tcp"
    ipv6_cidr_blocks  = ["fc00::/8"]
    security_group_id = aws_security_group.default.id
  }
}
