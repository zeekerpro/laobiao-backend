require 'rails_helper'

RSpec.describe "referrals#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "//referrals/#{referral.id}", params: params
  end

  describe 'basic fetch' do
    let!(:referral) { create(:referral) }

    it 'works' do
      expect(ReferralResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('referrals')
      expect(d.id).to eq(referral.id)
    end
  end
end
