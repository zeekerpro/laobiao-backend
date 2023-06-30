require 'rails_helper'

RSpec.describe ReferralResource, type: :resource do
  describe 'serialization' do
    let!(:referral) { create(:referral) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(referral.id)
      expect(data.jsonapi_type).to eq('referrals')
    end
  end

  describe 'filtering' do
    let!(:referral1) { create(:referral) }
    let!(:referral2) { create(:referral) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: referral2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([referral2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:referral1) { create(:referral) }
      let!(:referral2) { create(:referral) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            referral1.id,
            referral2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            referral2.id,
            referral1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
