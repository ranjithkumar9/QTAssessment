provider "aws" {
    access_key = "AKIAIEYALCPMQMKKYKSQ"
    secret_key = "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"
    region = "us-west-2"
  
}

      

       
resource "aws_instance" "machine1" {
   ami = "ami-036affea69a1101c9"
	 availability_zone = "us-west-2a"
	 key_name = "terraform"
	 instance_type = "t2.micro"
    associate_public_ip_address = "true"
    subnet_id = "${aws_subnet.sub1.id}"
    vpc_security_group_ids = ["${aws_security_group.mysec.id}"] 

  connection {
       type = "ssh"
       user = "ec2-user"
       private_key = "${file("./terraform.pem")}"
       }

	  
   provisioner "remote-exec" {
     inline = "shopizer.yml"
 
}   

    resource "aws_security_group" "mysec" {
	  name = "mysec"
	  description = "Allowing traffic"
      vpc_id      = "${aws_vpc.myvpc.id}"
	  
	    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
        ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

    

    }
    }
}
    