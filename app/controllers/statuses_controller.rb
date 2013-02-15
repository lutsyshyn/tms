class StatusesController < ApplicationController

  respond_to :html, :json
  before_filter :find_status, only: [:show, :edit, :update, :destroy]

  def index
    @statuses = Status.all
    respond_with @statuses
  end

  def show
    respond_with @status
  end

  def new
    @status = Status.new
    @menus = Menu.all
    respond_with @status
  end

  def edit
    @menus = Menu.all
    respond_with @status
  end

  def create
    @status = Status.new(params[:status])

    flash[:success] = 'Status was successfully created.' if @status.save
    respond_with @status, location: statuses_path
  end

  def update
    flash[:success] = 'Status was successfully updated.' if @status.update_attributes(params[:status])
    respond_with @status, location: statuses_path
  end

  def destroy
    flash[:success] = 'Status was deleted.' if @status.destroy
    respond_with @status
  end

  private
    def find_status
      @status = Status.find(params[:id])
    end
end
