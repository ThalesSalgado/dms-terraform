resource "aws_security_group" "database" {
  vpc_id = "${aws_vpc.main.id}"
  name = "rds_database"

  ingress {
    from_port = 0 #5432
    to_port = 0 #5432
    protocol = "-1" #"tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "dms" {
#   vpc_id = "${aws_vpc.main.id}"
#   name = "dms_sg"

#   ingress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     self = true
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "allow_ssh" { 
#   vpc_id = "${aws_vpc.main.id}"
#   name = "dms_allow_ssh"

#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     # cidr_blocks = ["${var.my_public_ip}"]
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "allow_outbound" {
#   vpc_id = "${aws_vpc.main.id}"
#   name = "dms_allow_outbound"

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "cluster_communication" {
#   vpc_id = "${aws_vpc.main.id}"
#   name = "dms_cluster_communication"

#   ingress {
#     from_port = 2377
#     to_port = 2377
#     protocol = "tcp"
#     self = true
#   }

#   ingress {
#     from_port = 7946
#     to_port = 7946
#     protocol = "tcp"
#     self = true
#   }

#   ingress {
#     from_port = 7946
#     to_port = 7946
#     protocol = "udp"
#     self = true
#   }

#   ingress {
#     from_port = 4789
#     to_port = 4789
#     protocol = "udp"
#     self = true
#   }
# }
