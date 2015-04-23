class HomeController < ApplicationController
  def index
  end
  def show
   @card= Card.all
  end

end
