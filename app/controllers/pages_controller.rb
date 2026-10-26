class PagesController < ApplicationController
  def home
  end

  def visiting
  end

  def about
  end

  allow_unauthenticated_access only: [:index, :show] 
end