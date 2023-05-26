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

  @@protected_attributes = [ :password, :password_digest, :username, :phone, :email ]

  validates :username, presence: false, uniqueness: true

  validates :phone, presence: false, uniqueness: true, length: { is: 11 }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, on: :create

  # don't use first<or query like first> method in scope, because scope will return all records if where get nil
  # https://stackoverflow.com/questions/21649804/activerecord-first-method-in-scope-returns-more-than-one-record
  # scope :find_by_account, -> (account) {
  #   where("username = :account OR phone = :account OR email = :account", { account: account }).first
  # }
  def self.find_by_account(account)
    where("username = :account OR phone = :account OR email = :account", { account: account }).first
  end

end
