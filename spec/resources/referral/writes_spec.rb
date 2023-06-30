require 'rails_helper'

RSpec.describe ReferralResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'referrals',
          attributes: attributes_for(:referral)
        }
      }
    end

    let(:instance) do
      ReferralResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Referral.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:referral) { create(:referral) }

    let(:payload) do
      {
        data: {
          id: referral.id.to_s,
          type: 'referrals',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ReferralResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { referral.reload.updated_at }
      # .and change { referral.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:referral) { create(:referral) }

    let(:instance) do
      ReferralResource.find(id: referral.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Referral.count }.by(-1)
    end
  end
end
