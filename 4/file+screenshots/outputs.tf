# output "vm_ip1" {
#   value = yandex_compute_instance.VM[0].network_interface.0.ip_address
# }
# output "vm_nat_ip1" {
#   value = yandex_compute_instance.VM[0].network_interface.0.nat_ip_address
# }
# output "vm_ip2" {
#   value = yandex_compute_instance.VM[1].network_interface.0.ip_address
# }
# output "vm_nat_ip2" {
#   value = yandex_compute_instance.VM[1].network_interface.0.nat_ip_address
# }
output "vm_lan_ip" {
  value = [yandex_compute_instance.VM[0].network_interface.0.ip_address, yandex_compute_instance.VM[1].network_interface.0.ip_address]
}

output "vm_nat_ip" {
  value = [yandex_compute_instance.VM[0].network_interface.0.nat_ip_address, yandex_compute_instance.VM[1].network_interface.0.nat_ip_address]
}

output "load_balance_ip" {
  value = yandex_lb_network_load_balancer.balance-test.listener
}