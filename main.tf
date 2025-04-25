module "virtual-machine" {
    source          = "./modules/virtual-machines"
    name_label      = "var.vm-name"
    memory_max       = 1073733632
    cpus             = 1

    # Prefer to run the VM on the primary pool instance
    affinity_host = data.xenorchestra_pool.pool.master
    network {
      network_id = data.xenorchestra_network.net.id
    }

    disk {
      sr_id      = "7f469400-4a2b-5624-cf62-61e522e50ea1"
      name_label = "Ubuntu Bionic Beaver 18.04_imavo"
      size       = 32212254720
    }

    tags = [
      "Ubuntu",
      "Bionic",
    ]
}

module "cloud-init-configuration" {
    source          = "./modules/cloud-init"
    cloud_config    = xenorchestra_cloud_config.demo.template

}