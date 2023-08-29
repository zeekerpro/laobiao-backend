# == Schema Information
#
# Table name: chats
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  api_key_id    :bigint           not null
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  indexed_db_id :integer
#
class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :api_key
end
