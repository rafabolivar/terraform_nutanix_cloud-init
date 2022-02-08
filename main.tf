terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.2.2"
    }
  }
}

data "nutanix_cluster" "cluster" {
  name = var.cluster_name
}
data "template_file" "script" {
  template = "${file("./init.tpl")}"
}

provider "nutanix" {
  username = var.user
  password = var.password
  endpoint = var.endpoint # prism central endpoint
  insecure = true
}

resource "nutanix_virtual_machine" "vm" {
  name                 = var.vm_name
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "2"
  num_sockets          = "2"
  memory_size_mib      = 8192

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = var.imguuid
    }
  }

  disk_list {
    disk_size_bytes = 40 * 1024 * 1024 * 1024
    device_properties {
      device_type = "DISK"
      disk_address = {
        "adapter_type" = "SCSI"
        "device_index" = "1"
      }
    }
  }
  nic_list {
    subnet_uuid = var.netuuid
  }
guest_customization_cloud_init_user_data = base64encode(data.template_file.script.rendered)
}
