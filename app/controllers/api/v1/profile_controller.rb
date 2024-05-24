# frozen_string_literal: true

module Api
  module V1
    class ProfileController < ApplicationController
      def index
        render json: { user: Current.user, session: Current.session }
      end

      def active_dose
        render json: Current.user.active_dose
      end
    end
  end
end
