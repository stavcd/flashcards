class AddAttemptAndAccuracyForCard < ActiveRecord::Migration
  def change
    add_column :cards, :attempt, :integer, default: 0
    add_column :cards, :accuracy, :integer, default: 0
  end
end
