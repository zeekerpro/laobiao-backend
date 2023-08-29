class AddIndexedDbIdToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :indexed_db_id, :integer
  end
end
