# frozen_string_literal: true

module Api
  module V1
    class ProfileController < ApplicationController
      def index
        render json: { user: Current.user, session: Current.session }
      end
    end
  end
end
