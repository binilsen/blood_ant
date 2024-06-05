# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Profiles', type: :request do
  let!(:user) { create(:user) }
  let(:token) { authorization_token(user) }

  describe 'GET /api/v1/profiles' do
    subject(:query) { get api_v1_profile_index_path, headers: token }

    before { query }

    it { expect(response.status).to eq(200) }
    it { expect(json['user']['id']).to eq(user.id) }
    it { expect(json['user']['email']).to eq(user.email) }
  end

  describe 'GET /api/v1/profile/active_dose' do
    let!(:active_dose) { create(:dose, status: 'active', user:) }
    subject(:query) { get active_dose_api_v1_profile_index_path, headers: token }

    before { query }

    context 'when user has active dose' do
      it { expect(json['id']).to eq(active_dose.id) }
      it { expect(json['medicine']).to eq(active_dose.medicine) }
    end

    context 'when user has no active doses' do
      let(:active_dose) { create(:dose) }

      it { expect(response.status).to eq(200) }
      it { expect(json).to be_falsey }
    end
  end
end
