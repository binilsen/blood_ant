# frozen_string_literal: true

module Api
  module V1
    class LogsController < ApplicationController
      include Paginatable
      before_action :set_logs
      before_action :set_log, only: %i[show update destroy]

      # GET /logs
      def index
        @logs = LogQuery.perform(@logs, params)
        render json: params[:all].present? ? @logs : paginate(@logs)
      end

      # GET /logs/1
      def show
        render json: @log
      end

      # POST /logs
      def create
        @log = @logs.new(log_params)

        if @log.save
          render json: @log, status: :created
        else
          render json: @log.errors.full_messages, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /logs/1
      def update
        if @log.update(log_params)
          render json: @log
        else
          render json: @log.errors.full_messages, status: :unprocessable_entity
        end
      end

      # DELETE /logs/1
      def destroy
        @log.destroy!
      end

      def filters
        render json: available_filters
      end

      def active
        render json: @logs.active
      end

      def generate_report
        LogReportJob.perform_now(current_account.id, params)
        render json: 'Report Send!', status: :ok
      end

      private

      def available_filters
        { sessions: Log.sessions.keys, tags: Log.tags.keys, results: Log.results.keys }
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_log
        @log = @logs.find(params[:id])
      end

      def set_logs
        @logs = current_account.logs
      end

      # Only allow a list of trusted parameters through.
      def log_params
        params.require(:log).permit(%i[value session tag remark])
      end
    end
  end
end
