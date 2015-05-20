class ChangeAddDeckIdToCards < ActiveRecord::Migration
  def change
    remove_column :cards, :decks_id
    add_column :cards, :deck_id, :integer
  end
end
