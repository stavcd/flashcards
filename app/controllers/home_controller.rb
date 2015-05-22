class HomeController < ApplicationController

  def index
    @card = current_user.cards_for_review.first
  end
end
