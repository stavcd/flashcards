class ReviewsController < ApplicationController

  def create
    @card = current_user.cards.find(review_params[:card_id])
    success = @card.check_translation(review_params[:input_text])[:success]
    typos_count = @card.check_translation(review_params[:input_text])[:typos_count]
    if success
      flash[:notice] = "Правильный перевод, допущено #{typos_count} опечаток"
      redirect_to root_path
    else
      flash[:notice] = "Неправильно.В слове ..#{ @card.translated_text }. Вы допустили #{typos_count} ошибок"
      redirect_to root_path
    end
  end

  private
  def review_params
    params.permit(:card_id, :input_text, :review_date)
  end
end
