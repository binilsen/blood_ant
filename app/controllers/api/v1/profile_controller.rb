# frozen_string_literal: true

module Api
  module V1
    class ProfileController < ApplicationController
      def index
        render json: { user: current_account }
      end

      def active_dose
        render json: current_account.active_dose
      end
    end
  end
end
