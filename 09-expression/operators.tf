locals {
  add     = 2 + 2
  sub     = 10 - 3
  bool    = true
  notTrue = !true
  div     = 50 / 5
}


output "operators" {
  value = {
    "Addition" : local.add,
    "Subtraction" : local.sub,
    "Boolean" : local.bool,
    "Not True" : local.notTrue,
    "Division" : local.div,
  }
}
