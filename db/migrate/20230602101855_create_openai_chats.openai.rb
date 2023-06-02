# This migration comes from openai (originally 20230602090913)
class CreateOpenaiChats < ActiveRecord::Migration[7.0]
  def change
    create_table :openai_chats do |t|
      t.references :openai_api_key, null: false, foreign_key: true
      t.string :name
      t.text :prompt
      t.string :model

      t.timestamps
    end
  end
end
