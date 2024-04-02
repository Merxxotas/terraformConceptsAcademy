resource "kubernetes_service" "pythonApp_API" {
  metadata {
    name = "pythonapp-fastapi-service"
  }
  spec {
    selector = {
      app = "pythonAPP_FastAPI"
    }
    type = "NodePort"
    port {
      port        = 8000
      target_port = 8000
      node_port   = 30007
    }
  }
}
