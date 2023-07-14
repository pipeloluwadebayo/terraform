
output "admin-group-id" {
  description = "A reference to the group of users with administrator access"
  value       = aws_iam_group.admin-group.id
}
