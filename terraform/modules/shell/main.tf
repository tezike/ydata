resource "null_resource" "shell" {
  provisioner "local-exec" {
    command = var.command
  }
}