default_api_key = ApiKey.find_by(content: Rails.application.credentials.openai.api_key);
default_api_key = ApiKey.create(
  account: Rails.application.credentials.openai.account,
  content: Rails.application.credentials.openai.api_key,
  service_provider: 'openai',
  status: true,
) if default_api_key.blank?


medisearch_api_key = ApiKey.find_by(content: Rails.application.credentials.medisearch.api_key);
medisearch_api_key = ApiKey.create(
  account: Rails.application.credentials.medisearch.account,
  content: Rails.application.credentials.medisearch.api_key,
  service_provider: 'medisearch',
  status: true,
) if medisearch_api_key.blank?
