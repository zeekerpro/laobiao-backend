class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :phone
      t.string :email
      t.string :wechat_open_id

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :phone
    add_index :users, :username

  end
end
