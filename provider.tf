provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstateepsilontraining3"
    key    = "epsilon/mandeep/lambda/tfstate"
    region = "us-east-1"
  }
}