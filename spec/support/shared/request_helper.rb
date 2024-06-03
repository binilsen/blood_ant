# frozen_string_literal: true

module Requests
  def authorization_token(user)
    { 'Authorization' => generate_token(user), 'Content-Type' => 'application/json' }
  end

  def generate_token(user)
    payload = { account_id: user.id, authenticated_by: ['password'] }
    JWT.encode payload, 'test', 'HS256'
  end

  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end
  end
end
