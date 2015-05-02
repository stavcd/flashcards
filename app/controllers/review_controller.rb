class ReviewController < ApplicationController

  def create
    @card = Card.find(review_params[:card_id])
    if @card.check_translation?(@card.translated_text, review_params[:input_text])
      flash[:notice] = 'Правильный перевод'
    else
      flash[:notice] = 'Неправильный перевод'
    end
    redirect_to root_path
  end

  private
  def review_params
    params.permit(:card_id, :input_text, :review_date)
  end
end
