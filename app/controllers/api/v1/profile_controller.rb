# frozen_string_literal: true

module Api
  module V1
    class ProfileController < ApplicationController
      def index
        render json: { user: Current.user, session: Current.session }
      end

      def active_dose
        render json: Current.user.doses.active.first
      end
    end
  end
end
