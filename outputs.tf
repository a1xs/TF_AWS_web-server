output "web_server_instance_id" {
    description = "Instance ID"
    value = aws_instance.web_server[0].id
}

output "web_server_instance_pub_ip" {
    description = "Public IP of EC2 instance"
    value       = aws_instance.web_server[0].public_ip
}

output "web_server_instance_pub_dns" {
    description = "Public DNS of EC2 instance"
    value       = aws_instance.web_server[0].public_dns
}

output "web_server_instance_security_group" {
    description = "Security Group"
    value       = aws_security_group.web_server_g.id
}