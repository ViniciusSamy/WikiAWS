data "template_file" "init" {
  template = "${file("userdata/ubuntu.sh")}"

  vars = {
    wiki_port   = "${var.wiki_port}"
    db_host     = "${aws_db_instance.default.address}"
    db_user     = "${var.db_user}"
    db_pass     = "${var.db_password}"
    db_port     = "5432"
    db_name     = "${var.db_name}"
  }
}

resource "aws_key_pair" "wiki" {
  key_name   = "wiki-key"
  public_key = var.wiki_pubkey
}

resource "aws_instance" "wiki" {
  ami                   = var.wiki_ami
  instance_type         = var.wiki_instance_type
  key_name              = aws_key_pair.wiki.key_name
  user_data             = "${data.template_file.init.rendered}"


  network_interface {
    network_interface_id = aws_network_interface.wiki.id
    device_index         = 0
  }

  tags = {
    "Name": "wiki"
  }

  volume_tags = {
    "Name": "wiki"
  }

  depends_on = [ aws_db_instance.default ]
}

resource "aws_network_interface" "wiki" {
  subnet_id       = aws_subnet.public[0].id
  #  private_ips     = [var.private-ips["wiki"]]
  security_groups = [aws_security_group.wiki.id]
}

resource "aws_security_group" "wiki" {
  name        = "wiki-sg"
  description = "Expose wiki to internet."
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Allow SSH from personal ip"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["187.19.173.235/32"]
  }

  ingress {
    description      = "Expose wiki service to internet"
    from_port        = var.wiki_port
    to_port          = var.wiki_port
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
    Name = "wiki-sg"
  }
}

output "teste" {
  value = "${data.template_file.init.rendered}"
}
