# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  #GET /resource/sign_up
  def new
    invitation = Invitation.find_by(token: params[:token])
    if !invitation
      flash[:error] = "Sorry, you don't have permission to do this, please contact an admin!"
      redirect_to new_user_session_path
    else
      @token = invitation.token
      build_resource
      self.resource.email = invitation.email
      yield resource if block_given?
      respond_with resource
    end
  end

  #POST /resource
  def create
    invitation = Invitation.find_by(token: params[:user][:invitation_token])

    if !invitation
      flash.now[:error] = "Sorry that token is invalid"
      render :new
    else
      @token = invitation.token

      user = build_resource(sign_up_params.merge(admin: invitation.admin))

      resource.save
      yield resource if block_given?
      if resource.persisted?
        invitation.destroy
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name])
  end

  # The path used after sign up.
  def after_update_path_for(resource)
    if sign_in_after_change_password?
      if resource.admin?
        water_meter_readings_path
      else
        new_water_meter_reading_path
      end
    else
      new_session_path(resource_name)
    end
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
