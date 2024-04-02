resource "kubernetes_deployment" "pythonApp_API" {
  metadata {
    name = "pythonapp-fastapi-deployment"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "pythonAPP_FastAPI"
      }
    }
    template {
      metadata {
        labels = {
          app = "pythonAPP_FastAPI"
        }
      }
      spec {
        container {
          name              = "pythonapp-fastapi-container"
          image             = "merxxaz/python-app:v1.0.0"
          image_pull_policy = "Always"
          port {
            container_port = 8000
          }
          resources {
            limits = {
              cpu    = "500m" # 0.5 CPU
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
