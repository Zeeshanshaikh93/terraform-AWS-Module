#Web security group rule

resource "aws_security_group" "web" {
  name        = var.web_security_group.name
  description = var.web_security_group.description
  vpc_id      = aws_vpc.base.id
  tags = {
    Name = var.web_security_group.name
  }
  depends_on = [aws_vpc.base]
}

resource "aws_vpc_security_group_ingress_rule" "web" {
  count             = length(var.web_security_group.inbound_rules)
  security_group_id = aws_security_group.web.id
  ip_protocol       = var.web_security_group.inbound_rules[count.index].ip_protocol
  cidr_ipv4         = var.web_security_group.inbound_rules[count.index].source
  from_port         = var.web_security_group.inbound_rules[count.index].port
  to_port           = var.web_security_group.inbound_rules[count.index].port
  description       = var.web_security_group.inbound_rules[count.index].description
  depends_on        = [aws_security_group.web]
  tags = {
    Name = "web"
  }
}

resource "aws_vpc_security_group_egress_rule" "web" {
  security_group_id = aws_security_group.web.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  depends_on        = [aws_security_group.web]
  tags = {
    Name = "web"
  }
}

#App security group rule 

resource "aws_security_group" "app" {
  name        = var.app_security_group.name
  description = var.app_security_group.description
  vpc_id      = aws_vpc.base.id
  tags = {
    Name = var.app_security_group.name
  }
  depends_on = [aws_vpc.base]
}

resource "aws_vpc_security_group_ingress_rule" "app" {
  count             = length(var.app_security_group.inbound_rules)
  security_group_id = aws_security_group.app.id
  ip_protocol       = var.app_security_group.inbound_rules[count.index].ip_protocol
  cidr_ipv4         = var.app_security_group.inbound_rules[count.index].source
  from_port         = var.app_security_group.inbound_rules[count.index].port
  to_port           = var.app_security_group.inbound_rules[count.index].port
  description       = var.app_security_group.inbound_rules[count.index].description
  depends_on        = [aws_security_group.app]
  tags = {
    Name = "app"
  }
}

resource "aws_vpc_security_group_egress_rule" "app" {
  security_group_id = aws_security_group.app.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  depends_on        = [aws_security_group.app]
  tags = {
    Name = "app"
  }
}

#db security group

resource "aws_security_group" "db" {
  name        = var.db_security_group.name
  description = var.db_security_group.description
  vpc_id      = aws_vpc.base.id
  tags = {
    Name = var.db_security_group.name
  }
  depends_on = [aws_vpc.base]
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  count             = length(var.db_security_group.inbound_rules)
  security_group_id = aws_security_group.db.id
  ip_protocol       = var.db_security_group.inbound_rules[count.index].ip_protocol
  cidr_ipv4         = var.db_security_group.inbound_rules[count.index].source
  from_port         = var.db_security_group.inbound_rules[count.index].port
  to_port           = var.db_security_group.inbound_rules[count.index].port
  description       = var.db_security_group.inbound_rules[count.index].description
  depends_on        = [aws_security_group.db]
  tags = {
    Name = "db"
  }
}

resource "aws_vpc_security_group_egress_rule" "db" {
  security_group_id = aws_security_group.db.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  depends_on        = [aws_security_group.db]
  tags = {
    Name = "db"
  }
}