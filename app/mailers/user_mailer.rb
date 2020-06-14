class UserMailer < ApplicationMailer
  def invitation_email
    @invitation = params[:invitation]
    @url = "http://localhost:3000/sign_up?token=#{@invitation.token}"
    mail(to: @invitation.email, subject: "You have been invited to join the Cemex Water Meter App")
  end
end
