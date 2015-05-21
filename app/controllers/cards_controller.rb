class CardsController < ApplicationController
  before_action :load_card, only: [:edit, :update, :destroy, :crop_image]
  before_action :load_deck

  def index
    @cards = @deck.cards.all
  end

  def new
    @card = @deck.cards.new
  end

  def create
    respond_with(@card = @deck.cards.create(card_params.merge(user_id: current_user.id))) do |format|
      format.html { redirect_to new_deck_card_path } if @card.save
    end
  end

  def update
    if @card.update(card_params)
      redirect_to deck_cards_path, notice: 'Карта успешно обновленна'
    else
      redirect_to edit_deck_card_path(@deck, @card.id)
    end
  end

  def destroy
    if @card.destroy
      redirect_to deck_cards_path
    end
  end

  def crop_image
    if request.put?
      @card.crop_image!(params[:card][:image_crop_data])
      redirect_to deck_cards_path
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
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image)
  end
end
