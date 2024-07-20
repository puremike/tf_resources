variable "number_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
}


variable "obj_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))

  default = [
    {
      firstname = "John"
      lastname  = "Smith"
    },
    {
      firstname = "Jane"
      lastname  = "Smith"
    },
    { firstname = "Lauro"
    lastname = "Müller" }
  ]
}


variable "number_map" {
  type = map(number)
  default = {
    one   = 1
    two   = 2
    three = 3
    four  = 4
  five = 5 }

}

variable "users" {
  type = list(object({
    username = string
    role     = string
  }))

  default = [
    {
      role     = "admin"
      username = "john"
    },
    {
      role     = "developer"
      username = "jane"
    },
    {
      role     = "auditor"
      username = "jane"
    },
    {
      role     = "auditor"
      username = "lauro"
    }
  ]

}