# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def current_account
    rodauth.rails_account
  end

  def authenticate
    rodauth.require_account # redirect to login page if not authenticated
  end
end
