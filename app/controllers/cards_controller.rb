class CardsController < ApplicationController
  before_action :load_card, only: [:show, :edit, :update, :destroy, :crop_image]

  def index
    @card = current_user.cards.all
  end

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      flash[:notice] = 'Новая карта создана'
      redirect_to new_card_path
    else
      flash[:notice] = 'Ошибка в создании карты'
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      redirect_to edit_card_path(@card.id)
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  def crop_image
    if request.put?
      @card.crop_image!(params[:card][:image_crop_data])
      redirect_to cards_path
    end
  end

  private

  def load_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image)
  end
end
