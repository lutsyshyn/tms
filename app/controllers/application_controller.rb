class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  WillPaginate.per_page = 15

  rescue_from Exception, :with => :exception_handler
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def after_sign_in_path_for(user)
    tickets_url
  end

  private

    def exception_handler
      flash[:error] = "You don't have access to this section."
      redirect_to root_url
    end

    def not_found
      flash[:error] = "Requested record not found"
      redirect_to root_url
    end


end

