require 'rails_helper'

RSpec.describe "referrals#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "//referrals", params: params
  end

  describe 'basic fetch' do
    let!(:referral1) { create(:referral) }
    let!(:referral2) { create(:referral) }

    it 'works' do
      expect(ReferralResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['referrals'])
      expect(d.map(&:id)).to match_array([referral1.id, referral2.id])
    end
  end
end
