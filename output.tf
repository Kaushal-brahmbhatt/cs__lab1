output "policy_arn" {
    value = aws_iam_policy.cs_ec2_policy.arn
}

output "ec2_role_name" {
    value = aws_iam_role.cs_ec2_role.name
}

output "ec2_instance_profile_name" {
    value = aws_iam_instance_profile.cs_ec2_instance_profile.name
}