require 'rails_helper'

RSpec.describe Card, type: :model do

  let(:card) { create(:card) }
  context 'card has valid attributes' do

    it 'validates review date' do
      expect(card.review_date).to eq((DateTime.current + 3.days).to_date)
    end

    it 'validates original_text' do
      expect(card.original_text).to eq('hello')
    end

    it 'validates translated text' do
      expect(card.translated_text).to eq('привет')
    end
  end

  context 'card has different texts' do

    card = Card.new(original_text: 'hello', translated_text: ' HelLo ',
                   review_date: DateTime.current)

    it 'validates text_are_not_equal' do
      expect(card).to_not be_valid
    end
  end

  context 'check translation' do

    before { card.check_translation('привет') }

    it ' check changes review date' do
      expect(card.review_date).to eq((DateTime.current+3.days).to_date)
    end
  end

end

