# Create a web server

resource "digitalocean_volume" "resource_space" {
    region      = "sfo2"
    name        = "resource-space-data"
    size        = ${var.datastore_size} 
    description = "Resource Space Datastore"
}

resource "digitalocean_droplet" "resource_space" {
    image = "ubuntu-16-04-x64"
    name = "rs-1"
    region = "sfo2"
    size = "512mb"
	user_data = ""
	ssh_keys = ["${var.ssh_key_fingerprint}"] 
	volume_ids = ["${digitalocean_volume.resource_space_data.id}"] 
}

resource "digitalocean_floating_ip" "resource_space" {
    droplet_id = "${digitalocean_droplet.resource_space.id}"
    region = "${digitalocean_droplet.resource_space.region}"
}

