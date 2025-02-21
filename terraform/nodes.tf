resource "google_service_account" "k8s_account" {
  account_id = "kubernetes"
}

resource "google_container_node_pool" "general" {
  name       = "default-pool"
  cluster    = google_container_cluster.k8s_assignment.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-standard-8"
    disk_type    = "pd-standard"
    disk_size_gb = 10

    labels = {
      role = "default-pool"
    }
  }
}