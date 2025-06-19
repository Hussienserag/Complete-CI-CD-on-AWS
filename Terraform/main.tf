module "Network_Module" {
    source = "./Modules/Network_Module"
    vpc_cidr = var.cidr_blocks["vpc_cidr"]
    Public_Subnet1_cidr= var.cidr_blocks["public_subnet1_cidr"]
    Public_Subnet2_cidr= var.cidr_blocks["public_subnet2_cidr"]
    Private_Subnet1_cidr= var.cidr_blocks["private_subnet1_cidr"]
    Private_Subnet2_cidr= var.cidr_blocks["private_subnet2_cidr"]
    Availabillity_Zone1 = var.Availabillity_Zones[0]
    Availabillity_Zone2 = var.Availabillity_Zones[1]
}
module "Jenkin_EC2_Module" {
    source = "./Modules/Jenkins_EC2_Module"
    Public_Security_Group_id = module.Network_Module.Public_Security_Group_id
    Public_Subnet1_id = module.Network_Module.Public_Subnet1_id
}

module "Eks_Cluster_Module" {
    source = "./Modules/EKS_Cluster_Module"
    Public_Subnet1_id = module.Network_Module.Public_Subnet1_id 
    Public_Subnet2_id = module.Network_Module.Public_Subnet2_id
    security_group_id = module.Network_Module.Public_Security_Group_id
    my_key = module.Jenkin_EC2_Module.my_key
}

# module "CloudWatch_Module" {
#     source = "./Modules/CloudWatch_Module"
#     cluster_name = "eks-cluster"
#     jenkins_instance_id = module.Jenkin_EC2_Module.EC2_Jenkins_id
# }

module "S3_Logs_Module" {
    source = "./Modules/S3_Logs_Module"
}

# module "AWS_Backup_Module" {
#     source = "./Modules/Aws_Backup_Module"
#     Jenkins_EC2_ID = module.Jenkin_EC2_Module.EC2_Jenkins_id
# }
module "ECR_Module" {
   source = "./Modules/ECR_Module"
 }

# Outputs are now managed in outputs.tf file
# This keeps main.tf clean and organized