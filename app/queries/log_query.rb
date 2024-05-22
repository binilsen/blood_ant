# frozen_string_literal: true

class LogQuery < ApplicationQuery
  def resolve
    @records = by_tag if params[:tag].present?
    @records = by_result  if params[:result].present?
    @records = by_session if params[:session].present?
    @records = by_month if params[:month].present?
    @records = by_dates if params[:start_date].present? && params[:end_date].present?
    @records.order(created_at: :desc)
  end

  private

  def by_month
    start_date = Time.zone.today - Integer(params[:month], 10).months
    end_date = Time.zone.today
    @records = @records.where(created_at: start_date...end_date).order(:created_at)
  end

  def by_dates
    start_date = Date.new(params[:start_date])
    end_date = Date.new(params[:end_date])
    @records = @records.where(created_at: start_date...end_date).order(:created_at)
  end

  def by_tag
    @records = @records.bookmark if params[:tag] == 'bookmark'
    @records = @records.default if params[:tag] == 'default'
    @records
  end

  def by_result
    @records = @records.high if params[:result] == 'high'
    @records = @records.low if params[:result] == 'low'
    @records = @records.normal if params[:result] == 'normal'
    @records
  end

  def by_session
    session = params[:session]
    if session && @records.respond_to?(session)
      @records.public_send(session)
    else
      @records
    end
  end
end
