class HomeController < ApplicationController
  def index
    @card = Card.reviewing_card
  end
end
