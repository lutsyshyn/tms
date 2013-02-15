class TicketsController < ApplicationController

  respond_to :html, :json

  skip_before_filter :authenticate_user!, only: [:new, :create, :show, :search]

  before_filter :find_ticket, only: [:show, :edit, :update, :destroy, :take_ownership, :disown]
  before_filter :search_match, only: :search

  def index
    if params[:menu]
      @tickets = Ticket.menu(params[:menu]).paginate(page: params[:page])
    else
      @tickets = Ticket.paginate(page: params[:page])
    end

    respond_with @tickets
  end

  def search
    if user_signed_in?
      @tickets = Ticket.search(params[:search].strip).paginate(page: params[:page])
      respond_with @tickets do |format|
        format.html {render 'index'}
      end
    else
      flash[:error] = "Ticket not found"
      redirect_to root_url
    end
  end

  def show

    @response = @ticket.responses.build
    @response.status_id = @ticket.status_id
    @response.user_id = current_user.id if user_signed_in?

    respond_with @ticket

  end

  def new
    @ticket = Ticket.new
  end

  def edit
    respond_with @ticket
  end

  def create
    @ticket = Ticket.new(params[:ticket])

    if @ticket.save
      flash[:success] = 'Ticket was successfully created.'
      CustomerMailer.ticket_submitted(@ticket).deliver if Rails.env == 'production'
    end

    respond_with @ticket
  end

  def update
    flash[:success] = 'Ticket was successfully updated.' if @ticket.update_attributes(params[:ticket])
    respond_with @ticket
  end

  def destroy
    flash[:success] = 'Ticket was deleted.' if @ticket.destroy

    respond_with @ticket
  end

  def take_ownership
    if @ticket.update_attributes(user_id: current_user.id)
      flash[:success] = 'Now you own the ticket'
      CustomerMailer.ticket_read(@ticket).deliver if Rails.env == 'production'
    end
    respond_with @ticket do |format|
      format.html { redirect_to @ticket }
    end
  end

  def disown
    flash[:success] = 'You disowned the ticket' if @ticket.update_attributes(user_id: nil)
    respond_with @ticket do |format|
      format.html { redirect_to tickets_path }
    end
  end

  private

    def find_ticket
      @ticket = Ticket.find_by_reference(params[:id])
      raise ActiveRecord::RecordNotFound unless @ticket
    end

    def search_match
      query = params[:search].strip.upcase if params[:search].present?
      if  /\A[A-Z]{3}[-]\d{6}\z/ =~ query
        redirect_to ticket_url(query)
      end
    end
end
