resource "aws_db_instance" "dev" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "beanstalk_db"
  port                 = 3306
  username             = "admin"
  password             = "admin"
  skip_final_snapshot  = "true"
}