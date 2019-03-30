aws ec2 create-vpc --cidr-block 10.10.0.0/16
aws ec2 create-subnet --cidr-block 10.10.1.0/24 --vpc-id vpc-0aa923ece11b8083a
aws ec2 create-subnet --cidr-block 10.10.2.0/24 --vpc-id vpc-0aa923ece11b8083a
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --internet-gateway-id igw-098f12e09d351a94e --vpc-id vpc-0aa923ece11b8083a
aws ec2 create-route-table --vpc-id vpc-0aa923ece11b8083a
aws ec2 create-route --route-table rtb-0e6a0f495672176b8 --destination-cidr-block "0.0.0.0/0" --gateway-id igw-098f12e09d351a94e
aws ec2 associate-route-table --route-table rtb-0e6a0f495672176b8 --subnet-id subnet-0c896958ec2af44b4
aws ec2 associate-route-table --route-table rtb-0e6a0f495672176b8 --subnet-id subnet-0246e78de56bb5411
aws ec2 create-key-pair --key-name MyKeyPair
aws ec2 create-security-group --group-name linuxweb --description "my security group" --vpc-id vpc-0aa923ece11b8083a
aws ec2 authorize-security-group-ingress --group-id sg-0304a6595edd2e256 --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-0304a6595edd2e256 --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 run-instances --image-id ami-0bbe6b35405ecebdb --instance-type t2.micro --key-name mykeypair --security-group-ids sg-0304a6595edd2e256 --subnet-id subnet-0246e78de56bb5411 --count 1 --associate-public-ip-address