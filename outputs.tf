output "kubernetes_cluster_name" {
  value = module.gke.cluster_name
}

output "kubernetes_endpoint" {
  value = module.gke.cluster_endpoint
}

locals {
  repositories = flatten([
    for repo in module.gar.repositories : [
      {
        PROJECT_ID      = replace(replace("\\$secrets.GKE_PROJECT }}", "secrets", "{{ secretes"), "\\", "")
        GAR_LOCATION    = repo.location
        GKE_CLUSTER     = module.gke.cluster_name
        GKE_ZONE        = module.gke.cluster_zone
        DEPLOYMENT_NAME = replace(replace("\\$github.event.repository.name }}", "github", "{{ github"), "\\", "")
        REPOSITORY      = repo.name
        IMAGE           = replace(replace("\\$github.event.repository.name }}", "github", "{{ github"), "\\", "")
      }
    ]
  ])
}

# for github actions configuration
output "github_actions_env_cfg" {
  value = local.repositories
}