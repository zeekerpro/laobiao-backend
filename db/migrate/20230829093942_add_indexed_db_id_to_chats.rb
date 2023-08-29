class AddIndexedDbIdToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :indexed_db_id, :integer
  end
end
