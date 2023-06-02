# This migration comes from openai (originally 20230602090818)
class CreateOpenaiAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :openai_accounts do |t|
      t.string :email

      t.timestamps
    end
  end
end
