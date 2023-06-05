class CreateReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :referrals do |t|

      t.string :code, unique: true, null: false

      t.references :referred, foreign_key: { to_table: :users }

      t.references :referrer, null: false, foreign_key: {to_table: :users}

      t.timestamps

    end
  end
end
