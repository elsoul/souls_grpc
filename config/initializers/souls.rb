Souls.configure do |config|
  config.project_id = "elsoul2"
  config.app = "elquest-api"
  config.namespace = "elquest-api"
  config.service_name = "blog-service"
  config.network = "elsoul"
  config.machine_type = "custom-1-6656"
  config.zone = "asia-northeast1-a"
  config.domain = "elquest-api.el-soul.com"
  config.google_application_credentials = "./config/keyfile.json"
  config.strain = "api"
  config.proto_package_name = "souls"
end