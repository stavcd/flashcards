class ReviewsController < ApplicationController

  def create
    @card = Card.find(review_params[:card_id])
    if @card.check_translation(review_params[:input_text])
      @card.update(accuracy: @card.accuracy, attempt: @card.attempt)
      flash[:notice] = 'Правильный перевод'
    else
      @card.update(accuracy: @card.accuracy, attempt: @card.attempt)
      flash[:notice] = 'Неправильный перевод'
    end
    redirect_to root_path
  end

  private
  def review_params
    params.permit(:card_id, :input_text, :review_date, :accuracy, :attempt)
  end
end
