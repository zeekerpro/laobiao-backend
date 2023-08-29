# == Schema Information
#
# Table name: api_keys
#
#  id         :bigint           not null, primary key
#  account    :string
#  content    :string
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ApiKey < ApplicationRecord


  def self.default
    ApiKey.first
  end

end
