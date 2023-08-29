class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.string :account
      t.string :content
      t.boolean :status

      t.timestamps
    end
  end
end
