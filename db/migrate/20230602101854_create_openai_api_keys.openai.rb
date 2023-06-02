# This migration comes from openai (originally 20230602090853)
class CreateOpenaiApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :openai_api_keys do |t|
      t.references :openai_account, null: false, foreign_key: true
      t.string :constent

      t.timestamps
    end
  end
end
