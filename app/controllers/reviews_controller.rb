class ReviewsController < ApplicationController

  def create
    @card = current_user.cards.find(review_params[:card_id])
    review_word = @card.check_translation(review_params[:input_text])
    if review_word[:success]
      redirect_to root_path, notice: "Правильный перевод, допущено\n
                                     #{ review_word[:typos_count] } опечаток"
    else
      redirect_to root_path, notice: "Неправильно.В слове ..#{ @card.translated_text }.\n
                                      Вы допустили #{ review_word[:typos_count] } ошибок"
    end
  end

  private
  def review_params
    params.permit(:card_id, :input_text, :review_date)
  end
end
