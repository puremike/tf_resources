locals {
  users_yml = yamldecode(file("${path.module}/user-roles.yml")).users
  user_list = [for userconf in local.users_yml : userconf.user]
  users_map = {
    for user_config in local.users_yml : user_config.user => user_config.roles
  }
}


# IAM_USER_LIST
resource "aws_iam_user" "users" {
  for_each = toset(local.user_list)
  # for_each = toset(local.users_yml[*].user) //splat method
  name = each.value
}

# IAW_USER_LOGIN_PROFILE
resource "aws_iam_user_login_profile" "users" {
  for_each        = aws_iam_user.users
  user            = each.key //each.value.name
  password_length = 10

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

output "password" {
  value = { for user, user_login in aws_iam_user_login_profile.users : user => user_login.password }
}