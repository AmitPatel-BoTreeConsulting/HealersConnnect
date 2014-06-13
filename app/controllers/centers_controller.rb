class CentersController < ApplicationController
  load_and_authorize_resource
  before_filter :collect_foundations, only: [:new, :create, :edit, :update]
  before_filter :find_center, only: [:edit, :update]
  def index
  @centers = Center.page(params[:page]).per(Settings.pagination.per_page)
  end
  def new
    @center = Center.new
    unauthorized! if cannot? :new, @center
  end
  def create
    @center = Center.new(params[:center])
    if @center.save
      flash[:notice] = t('center.message.success.center_created', center: @center.name)
      redirect_to centers_path
    else
      render :new
    end
  end
  def update
    if @center.update_attributes(params[:center])
      flash[:notice] = t('center.message.success.center_updated', center: @center.name)
      redirect_to centers_path
    else
      render :edit
    end
  end

  private
    def collect_foundations
      @foundations = Foundation.where(alias: 'YVPHFH')
    end

    def find_center
      @center = Center.find(params[:id])
    end
end
