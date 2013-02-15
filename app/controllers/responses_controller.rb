class ResponsesController < ApplicationController

skip_before_filter :authenticate_user!, only: :create
before_filter :find_responses, only: [:show, :edit, :update, :destroy]

respond_to :html, :json

  def index
    @responses = Response.all
    respond_with @responses
  end

  def show
    respond_with @response
  end

  def new
    @response = Response.new
  end

  def edit
    respond_with @response
  end

  def create
    @response = Response.new(params[:response])

    if params[:reference] == Ticket.find(params[:response][:ticket_id]).reference
      flash[:success] = 'Response was successfully created.' if @response.save

      if @response.status_id.present? && user_signed_in?
        @response.ticket.update_attributes(status_id: @response.status_id)
      else
        @response.ticket.update_attributes(status_id: Status.where("name LIKE '%staff response%'").first.id)
      end

      CustomerMailer.ticket_responded(@response).deliver if Rails.env == 'production'
      respond_with @response.ticket
    else
      flash[:error] = 'Ticket ID and reference mismatch'
      redirect_to root_url
    end
  end

  def update
    flash[:success] = 'Response was successfully updated.' if @response.update_attributes(params[:responce])
    respond_with @response
  end

  def destroy
    flash[:success] = 'Response was deleted.' if @response.destroy
    respond_with @response
  end

  private

    def find_responses
      @response = Response.find(params[:id])
    end
end
