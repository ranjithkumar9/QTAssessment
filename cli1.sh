     
#####create vpc 
  aws ec2 create-vpc --cidr-block 10.0.0.0/16
        id==="vpc-0dac2bb5f672c6c89",
#### create subnet 
  aws ec2 create-subnet --vpc-id vpc-0dac2bb5f672c6c89 --cidr-block 10.0.0.0/24
       id==="subnet-0a352c12024394954",

 ###create internet gateway
   aws ec2 create-internet-gateway
        id ===="igw-0d28600edb2558f3c",
###attach igw to vpc
   aws ec2 attach-internet-gateway --internet-gateway-id igw-0d28600edb2558f3c --vpc-id vpc-0dac2bb5f672c6c89

 #####  create a route table in your vpc & add the route to internet gateway
         aws ec2 create-route-table --vpc-id vpc-0dac2bb5f672c6c89    
               "rtb-08266abba0fb8af24"
        aws ec2 create-route --route-table-id rtb-08266abba0fb8af24 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-0d28600edb2558f3

                
######  attaching subnets to route tables  
        aws ec2 associate-route-table --route-table-id rtb-08266abba0fb8af24 --subnet-id subnet-0a352c12024394954
             "AssociationId": "rtbassoc-02c23f99069738e25"

        
## create security group
        aws ec2 create-security-group --description "security group for vm" --group-name linuxweb --vpc-id vpc-0dac2bb5f672c6c89
                "GroupId": "sg-0b6d01fdd45b82366"
  ##adding ingress rules
aws ec2 authorize-security-group-ingress --group-id sg-0b6d01fdd45b82366 --protocol tcp --port 22 --cidr 0.0.0.0/0   
aws ec2 authorize-security-group-ingress --group-id sg-0b6d01fdd45b82366 --protocol tcp --port 88 --cidr 0.0.0.0/0    

 ## create ubuntu 16 with t2.micro in public subnet with linuxweb security group
aws ec2 run-instances --image-id ami-0d773a3b7bb2bb1c1 --instance-type t2.micro --key-name mumbai --security-group-ids sg-0b6d01fdd45b82366 --subnet-id subnet-0a352c12024394954 --count 1 --associate-public-ip-address            
        "InstanceId": "i-090c5e42a8c33af32"
##showing our ec2 vm
aws ec2 describe-instances
  "PrivateIpAddress": "10.0.0.77"
  "PublicIp": "13.232.93.175"
  ssh -i oregon.pem ubuntu@13.232.93.175 
## create image 
aws ec2 create-image --instance-id i-090c5e42a8c33af32 --name  myami
   "ImageId": "ami-0e9ff8f77b5313932"



