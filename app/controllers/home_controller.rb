class HomeController < ApplicationController

  def index
    Card.for_review.each do |card|
      @card=card
    end
  end

end
