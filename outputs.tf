// A variable for extracting the external IP address of the instance

output "jenkins_ip" {
  value = "  http://${google_compute_instance.vm_instance_2.network_interface.0.access_config.0.nat_ip}:8080 "
}