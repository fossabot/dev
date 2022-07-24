variable "scripts" {
  type = list(string)
  default = [
    "script/000-install-bare",
    "script/001-install-base",
    "script/201-install-tailscale",
    "script/800-disable-resolved",
    "script/990-defn-dev",
    "script/999-update"
  ]
}

source "digitalocean" "this" {
  image            = "ubuntu-20-04-x64"
  region           = "sfo3"
  size             = "c-2"
  snapshot_name    = "defn-dev"
  snapshot_regions = []
  ssh_username     = "root"
}

build {
  sources = ["source.digitalocean.this"]

  provisioner "shell" {
    scripts = var.scripts
  }
}
