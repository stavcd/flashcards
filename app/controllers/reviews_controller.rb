class ReviewsController < ApplicationController

  def create
    @card = current_user.cards.find(review_params[:card_id])
    if @card.check_translation(review_params[:input_text]) == :success
      flash[:notice] = "Правильный перевод"
    else
      review_text = @card.translated_text
      errors_count = @card.check_translation(review_params[:input_text])[:typos_count]
      flash[:notice] = "В  слове ..#{review_text}.. Вы допустили #{errors_count} ошибок"
    end
    redirect_to root_path
  end

  private
  def review_params
    params.permit(:card_id, :input_text, :review_date)
  end
end
