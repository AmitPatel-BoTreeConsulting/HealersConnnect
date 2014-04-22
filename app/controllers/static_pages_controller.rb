class StaticPagesController < ApplicationController
  def new_center

  end

  def registration

  end

  def home
    if current_user
      render :dashboard
    else
      @workshops = Workshop.all
      render layout: 'home'
    end
  end
end
