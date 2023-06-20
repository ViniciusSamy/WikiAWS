resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = var.db_name
  engine                  = "postgres"
  engine_version          = "13.11"
  instance_class          = "db.t3.micro"
  username                = var.db_user
  password                = var.db_password
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.default.name
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = tolist([for subnet in aws_subnet.private: subnet.id])

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Expose RDS to wiki-sg."
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Expose wiki service to internet"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}