class MenusController < ApplicationController

  respond_to :html, :json
  before_filter :find_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = Menu.all
    respond_with @menus
  end

  def show
    respond_with @menu
  end

  def new
    @menu = Menu.new
    @statuses = Status.all
    respond_with @menu
  end

  def edit
    @statuses = Status.all
    respond_with @menu
  end

  def create
    @menu = Menu.new(params[:menu])

    flash[:success] = 'Menu created.' if @menu.save
    respond_with @menu, location: menus_path
  end

  def update
    flash[:success] = 'Menu updated.' if @menu.update_attributes(params[:menu])
    respond_with @menu, location: menus_path
  end

  def destroy
    flash[:success] = 'Menu was deleted.' if @menu.destroy
    respond_with @menus
  end

  private
    def find_menu
      @menu = Menu.find(params[:id])
    end
end
