# output "ip_addres" {
#     value=data.http.myipaddr.body
  
# }
# output "public_ipv6" {
#     value = data.http.myipaddr.body
  
# }
output "security_group_ids" {
  value = [aws_security_group.allow_egress.id, aws_security_group.allow_http.id, aws_security_group.allow_https.id, aws_security_group.allow_ssh.id]
}
