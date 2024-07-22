locals {
  numb_mult_2 = { for key, value in var.number_map : key => value * 2 }
  oddNumbs    = { for key, value in var.number_map : key => value if value % 2 != 0 }
  evenNumbs   = { for key, value in var.number_map : key => value if value % 2 == 0 }


  # for list(object)

  getUsers = { for user in var.obj_list : user.firstname => user.lastname }
}


output "mapOps" {
  value = {
    numb_mult_2 = local.numb_mult_2,
    oddNumbs    = local.oddNumbs
    evenNumbs   = local.evenNumbs
  }
}

output "getUsers" {
  value = local.getUsers
}
