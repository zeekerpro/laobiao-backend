class Referral < ApplicationRecord

  belongs_to :referred, class_name: 'User', optional: true

  belongs_to :referrer, class_name: 'User', optional: false

  validates :code, presence: true, uniqueness: true

  validates :referrer, presence: true

  before_validation :generate_code, on: :create

  def generate_code
    self.code = SecureRandom.hex(6)
  end

end
