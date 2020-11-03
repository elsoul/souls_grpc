Rails::Gke.configure do |config|
  config.project_id = "elsoul2"
  config.app = "elquest-api"
  config.network = "elsoul"
  config.machine_type = "custom-1-6656"
  config.zone = "asia-northeast1-b"
  config.domain = "elquest-api.el-soul.com"
  config.google_application_credentials = "./config/credentials.json"
end
