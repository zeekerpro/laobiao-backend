default_api_key = ApiKey.find_by(content: Rails.application.credentials.openai.api_key);
default_api_key = ApiKey.create(
  account: 'default',
  content: Rails.application.credentials.openai.api_key,
  status: true,
) if default_api_key.blank?
