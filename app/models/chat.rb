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

  has_many :messages, dependent: :destroy

  before_validation :set_default_api_key

  validates :indexed_db_id, presence: true

  def messages_for_openai
    messages = self.messages.order(:created_at).map do |msg|
      { role: msg.role, content: msg.content }
    end
    messages
  end

  private

  def set_default_api_key
    self.api_key = ApiKey.default if self.api_key.nil?
  end

end
