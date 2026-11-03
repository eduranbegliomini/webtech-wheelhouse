class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  allow_browser versions: :modern

  after_action :verify_authorized, unless: -> { action_name == "index" || skip_pundit? }
  after_action :verify_policy_scoped, if: -> { action_name == "index" && !skip_pundit? }

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def pundit_user
    Current.user
  end

  def user_not_authorized
    render "application/forbidden", status: :forbidden
  end

  def skip_pundit?
    devise_controller? rescue false
  end
end