# frozen_string_literal: true

module Api
  module V1
    class DosesController < ApplicationController
      include Paginatable
      before_action :set_dose, only: %i[show update destroy]

      # GET /doses
      def index
        render json: Current.user.doses.order(status: :desc)
      end

      # GET /doses/1
      def show
        render json: @dose
      end

      # POST /doses
      def create
        @dose = Current.user.doses.new(dose_params)

        if @dose.save
          render json: @dose, status: :created
        else
          render json: @dose.errors.full_messages, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /doses/1
      def update
        if @dose.update(dose_params)
          render json: @dose
        else
          render json: @dose.errors.full_messages, status: :unprocessable_entity
        end
      end

      # DELETE /doses/1
      def destroy
        @dose.destroy!
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_dose
        @dose = Current.user.doses.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def dose_params
        params.require(:dose).permit(%i[morning afternoon evening night medicine status remarks])
      end
    end
  end
end
