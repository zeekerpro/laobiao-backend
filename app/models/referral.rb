# == Schema Information
#
# Table name: referrals
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  referred_id :bigint
#  referrer_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Referral < ApplicationRecord

  belongs_to :referred, class_name: 'User', optional: true

  belongs_to :referrer, class_name: 'User', optional: false

  validates :code, presence: true, uniqueness: true

  validates :referrer, presence: true

  before_validation :generate_code, on: :create

  def generate_code
    self.code = SecureRandom.hex(6) if self.code.blank?
  end

end
