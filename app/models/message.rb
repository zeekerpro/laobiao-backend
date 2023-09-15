# == Schema Information
#
# Table name: messages
#
#  id            :bigint           not null, primary key
#  chat_id       :bigint           not null
#  content       :text
#  role          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  indexed_db_id :integer
#
class Message < ApplicationRecord
  belongs_to :chat

  enum role: { system: 'system', assistant: 'assistant', user: 'user' }

end
