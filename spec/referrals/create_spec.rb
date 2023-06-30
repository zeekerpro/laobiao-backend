require 'rails_helper'

RSpec.describe "referrals#create", type: :request do
  subject(:make_request) do
    jsonapi_post "//referrals", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:referral)
    end
    let(:payload) do
      {
        data: {
          type: 'referrals',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(ReferralResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Referral.count }.by(1)
    end
  end
end
