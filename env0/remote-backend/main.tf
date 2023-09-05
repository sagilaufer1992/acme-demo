locals {
  myMap = {"a" = {name="a"}, "b" = {name="b"}, "c" = {name="c"}}
}

module randomStrings {
  for_each = local.myMap

  source = "../../modules/random"

  refresh_token = each.value.name
}

resource "null_resource" "null" {
  for_each = local.myMap

  triggers = {
    name = each.value.name
  }
}

output name {
  value = module.randomStrings[*]
}
