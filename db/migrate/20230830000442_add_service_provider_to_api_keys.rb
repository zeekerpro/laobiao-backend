class AddServiceProviderToApiKeys < ActiveRecord::Migration[7.0]
  def change
    add_column :api_keys, :service_provider, :string, default: 'openai', null: false
  end
end
