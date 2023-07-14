terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}


provider "aws" {
  region = "us-east-2"
}


resource "aws_iam_user" "admin-user" {
  name     = each.value
  for_each = toset(var.administrators)
  tags = {
    Description = "Administrator"
  }
}


resource "aws_iam_group" "admin-group" {
  name = "AdminDepartment"

}


resource "aws_iam_policy" "admin-group-policy" {
  name   = "AdminGroup"
  policy = file("admin-group-policy.json")
}


resource "aws_iam_user_group_membership" "admin-group-members" {
  groups = [
    aws_iam_group.admin-group.name
  ]
  user     = each.key
  for_each = toset(var.administrators)

}


resource "aws_iam_group_policy_attachment" "admin-group-access" {
  group      = aws_iam_group.admin-group.name
  policy_arn = aws_iam_policy.admin-group-policy.arn
}
