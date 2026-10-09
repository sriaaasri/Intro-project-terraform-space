
#It is a IAM role
#import command -> terraform import aws_iam_role.<resource_name> <role_name> 
resource "aws_iam_role" "prod_baston_server_IAM_Role" {
  assume_role_policy = file("baston_IAM_Role_trust_policy.json")
  name               = "prod_baston_server_IAM_Role"
  description        = "Allows EC2 instance to call AWS resources on users belhalf"
  tags = {
    Server = "prod_baston_server"
  }
}

#it is inline policy so we are using iam_role_policy . if is a standalone policy we need to use aws_iam_policy
#import command -> terraform import aws_iam_role_policy.<resource_name> <role_name>:<policy_name>
resource "aws_iam_role_policy" "prod_baston_server_IAM_RolePolicy" {

  name   = "prod_baston_server_IAM_RolePolicy"
  role   = aws_iam_role.prod_baston_server_IAM_Role.id
  policy = file("baston_IAM_policy.json")

}

