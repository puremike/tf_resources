locals {
  name = "Lauro Müller"
  age  = 15
  my_object = {
    key1 = 10
    key2 = "my_value"
  }
}


output "funcOps" {
  value = {
    startsWith = startswith(lower(local.name), "lauro")
    pow        = pow(local.age, 2)
  }

}

output "exa" {
  value = yamldecode(file("${path.module}/users.yml")).users[*].name
}

output "jsonencode" {
  value = jsonencode((local.my_object))
}