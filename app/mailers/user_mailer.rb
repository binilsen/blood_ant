class UserMailer < ApplicationMailer
  def send_report
    @user = params[:user]
    report = Rails.root.join('tmp', params[:file_name]).read 
    attachments[params[:file_name]] = report
    mail to: @user.email, subject: params[:file_name].gsub(@user.name, '')
    Rails.root.join('tmp', params[:file_name]).delete
  end
end
