# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  password_digest :string
#  phone           :string
#  email           :string
#  wechat_open_id  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

  has_secure_password :password, validations: true

  has_many :referrals, foreign_key: :referrer_id
  has_many :referrings, class_name: 'User', through: :referrals, source: :referred

  has_one :referral, foreign_key: :referred_id
  has_one :referrer, class_name: 'User', through: :referral, source: :referrer

  has_many :chats

  @@protected_attributes = [ :password, :password_digest, :username, :phone, :email ]

  validates :username, presence: false, uniqueness: true

  normalizes :phone, with: -> phone { phone.gsub(/\D+/, '') }
  validates :phone, presence: false, uniqueness: true, length: { is: 11 }

  normalizes :email, with: -> email { email.strip.downcase }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, on: :create
  # https://edgeguides.rubyonrails.org/7_1_release_notes.html#add-activerecord-base-generates-token-for
  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  # don't use first<or query like first> method in scope, because scope will return all records if where get nil
  # https://stackoverflow.com/questions/21649804/activerecord-first-method-in-scope-returns-more-than-one-record
  # scope :find_by_account, -> (account) {
  #   where("username = :account OR phone = :account OR email = :account", { account: account }).first
  # }
  def self.find_by_account(account)
    where("username = :account OR phone = :account OR email = :account", { account: account }).first
  end

  def is_admin?
    self.id == 1
  end

end
