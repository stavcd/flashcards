CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
  else
    config.fog_credentials = {
        aws_access_key_id: Rails.application.secrets.aws_access_key_id,
        aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
        provider: 'AWS'
    }
    config.fog_directory = Rails.application.secrets.aws_fog_directory
    config.fog_public = true
  end
end