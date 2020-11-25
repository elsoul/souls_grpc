Souls.configure do |config|
  config.project_id = "elsoul2"
  config.app = "souls-api"
  config.namespace = "souls-api"
  config.service_name = "blog-service"
  config.network = "elsoul"
  config.machine_type = "custom-1-6656"
  config.zone = "asia-northeast1-a"
  config.domain = "souls-api.el-soul.com"
  config.google_application_credentials = "./config/keyfile.json"
  config.strain = "api"
  config.proto_package_name = "souls"
end
