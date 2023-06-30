require 'rails_helper'

RSpec.describe "referrals#update", type: :request do
  subject(:make_request) do
    jsonapi_put "//referrals/#{referral.id}", payload
  end

  describe 'basic update' do
    let!(:referral) { create(:referral) }

    let(:payload) do
      {
        data: {
          id: referral.id.to_s,
          type: 'referrals',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ReferralResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { referral.reload.attributes }
    end
  end
end
