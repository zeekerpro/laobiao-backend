require 'rails_helper'

RSpec.describe "referrals#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "//referrals/#{referral.id}"
  end

  describe 'basic destroy' do
    let!(:referral) { create(:referral) }

    it 'updates the resource' do
      expect(ReferralResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Referral.count }.by(-1)
      expect { referral.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
