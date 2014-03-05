class CentersController < ApplicationController
  def new
    @center = Center.new
  end

  def create
    @center = Center.new(params[:center])
    if @center.save
      redirect_to centers_path
    else
      render :new
    end
  end
end
