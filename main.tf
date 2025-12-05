provider aws {
    region = "ap-south-1"
}

resource "aws_instance" "demoserver" {
  ami = "ami-02b8269d5e85954ef"
  key_name ="jek"
  region = var.my_az[0]

  tags = {
    Name = "apache-server"
  }

  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.apache-sg.id]
  user_data = <<-EFO
                #!/bin/bash
                apt update
                apt install apache2 -y
                systemctl enable apache2
                systemctl start apache2
                cd /var/www/html/
                echo "<h1>this is created by terraform</h1>" > index.html
            EFO

}


resource "aws_security_group" "apache-sg" {
  name = "static-sg"
  ingress{
    to_port = 80
    from_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
   }
    ingress{
    to_port = 22
    from_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
    to_port =0
    from_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
   }
}