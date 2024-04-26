provider "vault" {
    address = "http://127.0.0.1:8200"
}

resource "vault_mount" "example" {
  path        = "dummy"
  type        = "generic"
  description = "This is an example mount"
}