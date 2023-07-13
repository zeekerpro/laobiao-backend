class ReferralResource < ApplicationResource

  attribute :code, :string, writable: true

  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :referred, class_name: 'User', optional: true, resource: UserResource

  belongs_to :referrer, class_name: 'User', optional: false, resource: UserResource

end
