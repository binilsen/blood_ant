# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '::Api::V1::Doses', type: :request do
  let!(:user) { create(:user) }
  let(:token) { authorization_token(user) }

  describe 'GET /api/v1/doses' do
    let!(:doses) { create_list(:dose, 5, user:) }
    subject(:query) { get api_v1_doses_path, headers: token }

    before { query }

    it { expect(json.size).to eq(doses.size) }
  end

  describe 'GET /api/v1/doses/:id' do
    let!(:dose) { create(:dose, user:) }
    subject(:query) { get api_v1_dose_path(dose), headers: token }

    before { query }

    it { expect(json['id']).to eq(dose.id) }
    it { expect(json['remarks']).to eq(dose.remarks) }
  end

  describe 'POST /api/v1/doses' do
    let(:params) { attributes_for(:dose) }
    subject(:query) { post api_v1_doses_path, params:, headers: token, as: :json }

    before { query }
    context 'when successful' do
      it { expect(json['id']).to be_truthy }
      it { expect(json['evening']).to eq(params[:evening]) }
      it { expect(json['morning']).to eq(params[:morning]) }
    end

    context 'when unsuccessful' do
      let(:params) { attributes_for(:dose).merge(evening: 0) }

      before { query }
      it { expect(response.status).to eq(422) }
    end
  end

  describe 'PATCH /api/v1/doses/:id' do
    let!(:dose) { create(:dose, user:) }
    let(:params) { attributes_for(:dose) }
    subject(:query) { patch api_v1_dose_path(dose), params:, headers: token, as: :json }

    before { query }
    context 'when successful' do
      it { expect(json['remarks']).to eq(params[:remarks]) }
      it { expect(json['morning']).to eq(params[:morning]) }
    end

    context 'when unsuccessful' do
      let(:params) { attributes_for(:dose).merge(morning: 0) }

      before { query }
      it { expect(response.status).to eq(422) }
    end
  end

  describe 'DESTROY /api/v1/doses/:id' do
    let!(:dose) { create(:dose, user:) }
    subject(:query) { delete api_v1_dose_path(dose), headers: token, as: :json }

    before { query }
    context 'when successful' do
      it { expect(response.status).to eq(204) }
    end

    context 'when unsuccessful' do
      context 'when validation fails' do
        let(:dose) { create(:dose) }

        it { expect(response.status).to eq(404) }
      end
    end
  end
end
