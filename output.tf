output "server_id" {
  value = "${aws_instance.instance.id}"
}

output "public_dns" {
  value = "${aws_instance.instance.public_dns}"
}

output "public_ip" {
  value = "${aws_instance.instance.public_ip}"
}

output "address" {
  value = "${aws_elb.example.dns_name}"
}
