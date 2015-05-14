class HomeController < ApplicationController

  def index
    @card = current_user.cards.for_review.first
  end
end
