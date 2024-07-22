locals {
  evenNumbers    = [for n in var.number_list : n if n % 2 == 0]
  oddNumbers     = [for n in var.number_list : n if n % 2 != 0]
  numbers_mult_2 = [for n in var.number_list : n * 2]
}


output "listOps" {
  value = {
    evenNumbers    = local.evenNumbers
    oddNumbers     = local.oddNumbers
    numbers_mult_2 = local.numbers_mult_2
  }
}