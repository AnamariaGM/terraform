output "ip_addres" {
    value=data.http.myipaddr.body
  
}
output "public_ipv6" {
    value = data.http.myipaddr.body
  
}