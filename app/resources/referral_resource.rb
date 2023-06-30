class ReferralResource < ApplicationResource

  attribute :code, :string

  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
end
