class DecksController < ApplicationController
  before_action :load_deck, only: [:destroy, :set_current, :edit, :update]

  def index
    @deck = current_user.decks.all
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      redirect_to decks_path, notice: 'Новая колода создана'
    else
      render 'new'
    end
  end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path
    else
      redirect_to decks_path, notice: 'Ошибка обновления'
    end
  end

  def set_current

    if current_user.update!(current_deck_id: @deck.id)
      puts current_user.inspect
      redirect_to decks_path, notice: 'Установлена текущая колода'
    else
      redirect_to decks_path, notice: 'Произошла ошибка'
    end
  end

  def destroy
    if @deck.destroy
      redirect_to decks_path, notice: 'Колода удалена'
    end
  end

  private

  def load_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end
end
