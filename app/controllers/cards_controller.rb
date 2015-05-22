class CardsController < ApplicationController
  before_action :load_card, only: [:edit, :update, :destroy, :crop_image]
  before_action :load_deck, only: [:index]

  def index
    @cards = @deck.cards.all
  end

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.new(card_params.merge(user_id: current_user.id))
    if @card.save
      redirect_to new_card_path, notice: 'Новая карта успешно создана'
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to deck_cards_path(card_params[:deck_id]), notice: 'Карта успешно обновленна'
    else
      render 'cards/edit'
    end
  end

  def destroy
    if @card.destroy
      redirect_to deck_cards_path(@card.deck_id)
    end
  end

  def crop_image
    if request.put?
      @card.crop_image!(params[:card][:image_crop_data])
      redirect_to deck_cards_path(@card.deck_id)
    end
  end

  private

  def load_card
    @card = current_user.cards.find(params[:id])
  end

  def load_deck
    @deck = current_user.decks.find(params[:deck_id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image, :deck_id)
  end
end
