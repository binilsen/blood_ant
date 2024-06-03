# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '::Api::V1::Logs', type: :request do
  let(:user) { create(:user) }
  let(:auth_token) { authorization_token(user) }

  describe 'GET /api/v1/logs' do
    let!(:logs) { create_list(:log, 5, user:) }
    subject(:query) { get api_v1_logs_path, headers: auth_token }

    before { query }

    it { expect(json.size).to eq(logs.size) }
  end

  describe 'GET /api/v1/logs/:id' do
    let!(:log) { create(:log, user:) }
    subject(:query) { get api_v1_log_path(log), headers: auth_token }

    before { query }

    it { expect(json['id']).to eq(log.id) }
    it { expect(json['value']).to eq(log.value) }
  end

  describe 'POST /api/v1/logs' do
    let(:params) { attributes_for(:log, user:) }
    subject(:query) { post api_v1_logs_path, params:, headers: auth_token, as: :json }

    before { query }
    context 'when successful' do
      it { expect(json['id']).to be_truthy }
      it { expect(json['value']).to eq(params[:value]) }
      it { expect(json['session']).to eq(params[:session]) }
    end

    context 'when unsuccessful' do
      context 'when validation fails' do
        let(:params) { attributes_for(:log, user:).merge(value: 20) }

        it { expect(response.status).to eq(422) }
      end
    end
  end

  describe 'PATCH /api/v1/logs/:id' do
    let!(:log) { create(:log, user:) }
    let(:params) { attributes_for(:log, user:) }
    subject(:query) { patch api_v1_log_path(log), params:, headers: auth_token, as: :json }

    before { query }
    context 'when successful' do
      it { expect(json['value']).to eq(params[:value]) }
      it { expect(json['session']).to eq(params[:session]) }
    end

    context 'when unsuccessful' do
      context 'when validation fails' do
        let(:params) { attributes_for(:log, user:).merge(value: 20) }

        it { expect(response.status).to eq(422) }
      end
    end
  end

  describe 'DESTROY /api/v1/logs/:id' do
    let!(:log) { create(:log, user:) }
    subject(:query) { delete api_v1_log_path(log), headers: auth_token, as: :json }

    before { query }
    context 'when successful' do
      it { expect(response.status).to eq(204) }
    end

    context 'when unsuccessful' do
      context 'when validation fails' do
        let(:log) { create(:log) }

        it { expect(response.status).to eq(404) }
      end
    end
  end

  describe 'GET /api/v1/logs/active' do
    let!(:log) { create(:log, created_at: Time.zone.today, user:) }
    subject(:query) { get active_api_v1_logs_path, headers: auth_token }

    before { query }
    it { expect(response.status).to eq(200) }
    it { expect(json.size).to eq(user.logs.active.size) }
    it { expect(json[0]['id']).to eq(log.id) }
  end

  describe 'GET /api/v1/logs/filters' do
    subject(:query) { get filters_api_v1_logs_path, headers: auth_token }

    before { query }
    it { expect(response.status).to eq(200) }
    it { expect(json.keys).to include('sessions', 'tags', 'results') }
  end

  describe 'POST /api/v1/logs/generate_report' do
    let(:params) { { 'month' => '3' } }
    subject(:query) { post generate_report_api_v1_logs_path, params:, headers: auth_token, as: :json }

    it 'enqueues LogReportJob' do
      expect(LogReportJob).to receive(:perform_now)
      query
    end

    it 'returns status 200' do
      query
      expect(response.status).to eq(200)
    end
  end
end
