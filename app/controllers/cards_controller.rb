class CardsController < ApplicationController
  before_action :load_card, only: [:show, :edit, :update, :destroy]


  def index
    @card = Card.all
  end

  def new
    @card = Card.new
  end

  def create

    @card = Card.new(cards_params)
    if @card.save
      flash[:notice] = 'Новая карта создана'
      redirect_to new_card_path
    else
      flash[:notice] = 'Ошибка в создании карты'
      render :new
    end

  end

  def update
    if @card.update(cards_params)
      redirect_to cards_path
    else
      redirect_to edit_card_path(@card.id)
    end

  end

  def show

  end

  def edit

  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def load_card
    @card = Card.find(params[:id])
  end

  def cards_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end

end