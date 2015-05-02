class ReviewController < ApplicationController

  def review_card
    @card = Card.find(review_params[:id])
    if @card.checking_card_text_errors?(@card.translated_text, review_params[:input_text])
      flash[:notice] = 'Правильный перевод'
      redirect_to root_path
    else
      flash[:notice] = 'Неправильный перевод'
      redirect_to root_path
    end
  end

  private
  def review_params
    params.permit(:id, :input_text)
  end
end