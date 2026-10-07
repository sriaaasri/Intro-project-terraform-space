terraform {

  backend "s3" {
    bucket         = "intro-project-terraform-state"
    key            = "terraform.tfstate"
    region         = "ap-south-2"
    dynamodb_table = "Intro-project-terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {

  region = "ap-south-2"
  default_tags {
    tags = {
      Project    = "Intro"
      Managed_By = "Terraform"
    }
  }

}

provider "aws" {

  alias  = "dev"
  region = "ap-south-1"


  default_tags {
    tags = {
      Environment = "Development"
    }
  }

}


