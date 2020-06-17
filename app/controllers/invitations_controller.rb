class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_user!
  before_action :require_admin!

  def index
    @invitations = Invitation.page(params[:page])
    @invitation = Invitation.new
  end

  def create
    @invitations = Invitation.page(params[:page])
    @invitation = Invitation.new(invitation_params
                            .merge(user_id: current_user.id))

    if User.find_by(email: params[:invitation][:email]).present?
      flash.now[:error] = 'There is already a user with that email address!'
      render :index
      return
    end

    if @invitation.save
      UserMailer.with(invitation: @invitation).invitation_email.deliver_now
      Audit.create(created_by: current_user.full_name,
                   action_type: "creation",
                   record_id: @invitation.id,
                   record_type: "invitation: #{@invitation.email}")

      flash[:success] = 'Your invitation has been sent!'
      redirect_to invitations_path
    else
      flash.now[:error] = 'There was a problem sending your invitation.'
      render :index
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    Audit.create(created_by: current_user.full_name,
                 action_type: "deletion",
                 record_id: @invitation.id,
                 record_type: "invitation: #{@invitation.email}")

    flash[:success] = 'The invitation has been deleted!'
    redirect_to invitations_path
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :admin)
  end
end
