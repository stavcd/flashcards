class AddDeckIdToCards < ActiveRecord::Migration
  def change
   add_reference :cards, :decks, index: true
  end
end
