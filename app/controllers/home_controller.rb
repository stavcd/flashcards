class HomeController < ApplicationController
  before_action :find_random_card, only: [:index]

  def index

  end

  private

  def find_random_card
    @card = Card.random_cards_to_check
  end

end
