class InstructorsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  #before_filter :required_access,  only: [:index, :new, :create, :edit, :update, :destroy]
  #before_filter :find_instructor, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(params[:instructor])
    if @instructor.save
      flash[:notice] = t('instructor.message.success.created')
      redirect_to instructors_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @instructor.update_attributes(params[:instructor])
      flash[:notice] = t('instructor.message.success.updated')
      redirect_to instructors_path
    else
      render :edit
    end
  end

  def destroy
    @instructor.destroy
    flash[:notice] = t('instructor.message.success.removed')
    redirect_to instructors_path
  end

  private
  def find_instructor
    @instructor = Instructor.find(params[:id])
  end

end