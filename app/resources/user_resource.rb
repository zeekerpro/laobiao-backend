class UserResource < ApplicationResource
  attribute :username, :string
  attribute :email, :string
  attribute :phone, :string
  attribute :password, :string
  attribute :password_confirmation, :string
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  has_one :referral, foreign_key: :referred_id #, resource: ReferralResource

  has_many :referrals, foreign_key: :referrer_id
  has_many :referrings, class_name: 'User', through: :referrals, source: :referred, resource: UserResource

  filter :referrer_id, :integer

end
