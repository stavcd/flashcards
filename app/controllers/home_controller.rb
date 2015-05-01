class HomeController < ApplicationController
  before_action :find_random_card, only: [:index]

  def index

  end

  def checking_card
    @card = Card.find(home_params[:id])
    if @card.checking_card_text_errors?(@card.translated_text, home_params[:input_text])
      flash[:notice] = 'Правильный перевод'
      redirect_to root_path
    else
      flash[:notice] = 'Неправильный перевод'
      redirect_to root_path
    end
  end

  private
  def find_random_card
    @card = Card.random_cards_to_check
  end

  def home_params
    params.permit(:id, :input_text)
  end

end
