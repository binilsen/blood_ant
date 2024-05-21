# frozen_string_literal: true

class LogQuery < ApplicationQuery
  def resolve
    @records = by_tag if params[:tag].present?
    @records = by_result  if params[:result].present?
    @records = by_session if params[:session].present?
    @records
  end

  private

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
