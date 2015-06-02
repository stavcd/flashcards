class ReviewsController < ApplicationController

  def create
    @card = current_user.cards.find(review_params[:card_id])
    check_result = @card.check_translation(review_params[:input_text])
    if check_result[:success] && check_result[:typos_count] == 0
      redirect_to root_path, notice: "Правильный перевод"
    elsif check_result[:success] && check_result[:typos_count] > 0
      redirect_to root_path, notice: "Правильный перевод, но Вы сделали\n
                           #{ check_result[:typos_count] } опечаток"
    else
      redirect_to root_path, notice: "Неправильно. В слове ..#{ @card.translated_text }.\n
                                      Вы допустили #{ check_result[:typos_count] } ошибок"
    end
  end

  private

  def review_params
    params.permit(:card_id, :input_text, :review_date)
  end
end
