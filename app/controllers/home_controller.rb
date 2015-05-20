class HomeController < ApplicationController

  def index
    @card = current_user.user_deck_card_review
  end
end
