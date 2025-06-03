# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow DB access from Bastion"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306 //mysql
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Adjust or use specific SGs instead
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Subnet group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "RDS Subnet Group"
  }
}

# RDS DB instance
resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
#   name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  storage_encrypted    = true
  publicly_accessible  = false
  multi_az             = false
}
