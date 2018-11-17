Apipie.configure do |config|
  config.app_name                = "Baseball"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.default_locale = 'ja'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/*.rb"
  # config.api_controllers_matcher = Rails.root.join('app', 'controllers', '**', '*.rb')
  config.default_version = 'v1'

  # ローカライズ不要
  config.translate = false
end
