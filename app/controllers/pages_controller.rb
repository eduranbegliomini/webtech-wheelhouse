class PagesController < ApplicationController
  allow_unauthenticated_access

  skip_after_action :verify_authorized

  def about
  end
  
end