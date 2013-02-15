class DepartmentsController < ApplicationController

  before_filter :find_department, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @departments = Department.all
    respond_with @departments
  end

  def show
    respond_with @department
  end

  def new
    @department = Department.new
    respond_with @department
  end

  def edit
    respond_with @department
  end

  def create
    @department = Department.new(params[:department])

    flash[:success] = 'Department was successfully created.' if @department.save
    respond_with @department, location: departments_path
  end

  def update
    flash[:success] = 'Department was successfully updated.' if @department.update_attributes(params[:department])
    respond_with @department, location: departments_path
  end

  def destroy
    flash[:success] = 'Department was deleted.' if @department.destroy
    respond_with @department
  end

  private
    def find_department
      @department = Department.find(params[:id])
    end
end
