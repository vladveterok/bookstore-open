require 'fog/aws'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret],
      region: 'eu-west-2'
    }
    config.fog_directory = 'veterokbookstore'
    config.storage = :fog
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end
