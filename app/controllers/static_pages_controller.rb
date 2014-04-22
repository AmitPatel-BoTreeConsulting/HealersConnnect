class StaticPagesController < ApplicationController
  def new_center

  end

  def registration

  end

  def home
    @workshops = Workshop.all
    render layout: 'home'
  end
end
