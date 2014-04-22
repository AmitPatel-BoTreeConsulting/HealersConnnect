class WorkshopsController < ApplicationController
  before_filter :workshop_from_params , only: [:show,:edit, :update, :destroy]

  def index
    @workshops =  Workshop.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
  end

  def new
    @workshop = Workshop.new
  end

  def create
    params[:workshop][:workshop_sessions_attributes].each do |workshop|
      if workshop[:date].present?
        workshop[:session_start] = "#{workshop[:date]} #{workshop[:session_start]}".to_datetime
        workshop[:session_end] = "#{workshop[:date]} #{workshop[:session_end]}".to_datetime
      end
    end
    params[:workshop].delete(:date)

    @workshop  = Workshop.new(params[:workshop])
    respond_to do |format|
      if @workshop.save
        format.html {redirect_to workshops_path, notice: t('workshop.message.workshop_created', workshop: @workshop.course.name)}
      else
        format.html {render :new}
      end
    end
  end

  def edit

  end

  def show
  end

  def update
    respond_to do |format|
      if @workshop.update_attributes(params[:workshop])
        format.html {redirect_to workshops_path, notice: t('workshop.message.workshop_updated')}
      else
        format.html {render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      @workshop.destroy
      format.html {redirect_to workshops_path, notice: t('workshop.message.workshop_destroy')}
    end
  end

  private

  def workshop_from_params
    @workshop = Workshop.find(params[:id])
  end
end
