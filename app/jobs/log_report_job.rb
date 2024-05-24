# frozen_string_literal: true

require 'csv'

class LogReportJob < ApplicationJob
  include SuckerPunch::Job

  def perform(user, params)
    user = User.find(user)
    records = LogQuery.perform(user.logs, params)
    attribute_names = %w[value remark session tag created_at]
    CSV.open(Rails.root.join('tmp', file_name(user, params)), 'wb') do |csv|
      csv << attribute_names

      records.each do |record|
        csv << record.attributes.values_at(*attribute_names)
      end
    end
    UserMailer.with(user:, file_name: file_name(user, params)).send_report.deliver_later
  end

  private

  def file_name(user, params)
    start_date = Time.zone.today - Integer(params[:month], 10).months
    end_date = Time.zone.today
    "#{user.name} Blood Ant Report: #{start_date.strftime('%b')}-#{end_date.strftime('%b')}.csv"
  end
end
