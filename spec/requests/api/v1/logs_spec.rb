# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '::Api::V1::Logs', type: :request do
  let(:user) { create(:user) }
  let(:auth_token) { authorization_token(user) }

  describe 'GET /api/v1/logs' do
    it 'works! (now write some real specs)' do
      get api_v1_logs_path, headers: auth_token
      expect(response).to have_http_status(:ok)
    end
  end
end
