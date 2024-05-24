# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    @signed_id = @user.generate_token_for(:password_reset)

    mail to: @user.email, subject: 'Reset your password'
  end

  def email_verification
    @user = params[:user]
    @signed_id = @user.generate_token_for(:email_verification)

    mail to: @user.email, subject: 'Verify your email'
  end

  def send_report
    @user = params[:user]
    report = Rails.root.join('tmp', params[:file_name]).read
    attachments[params[:file_name]] = report
    mail to: @user.email, subject: params[:file_name].gsub(@user.name, '')
    Rails.root.join('tmp', params[:file_name]).delete
  end
end
