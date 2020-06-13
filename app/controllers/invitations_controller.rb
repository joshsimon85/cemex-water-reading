class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @invitations = Invitation.page(params[:page])
  end

  def new
    @invitation = Invitation.new
  end
end
