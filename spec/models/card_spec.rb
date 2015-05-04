require 'rails_helper'

RSpec.describe Card do

  let(:card) { create(:card) }
  describe 'card has valid attributes' do

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

  describe 'card has different texts' do

    card = Card.create(original_text: 'hello', translated_text: ' HelLo ',
                       review_date: DateTime.current)

    it 'validates text_are_not_equal' do
      expect(card).to_not be_valid
    end
  end

  describe 'check translation' do

    before { card.check_translation('привет') }

    it 'check changes review date' do
      expect(card.review_date).to eq((DateTime.current+3.days).to_date)
    end
  end

  describe 'scope for_review has a certain size ' do

    before do
      3.times do
        Card.create(original_text: 'hello', translated_text: 'Привет', review_date: '01.05.2015')
      end
    end

    it 'check scope for_review size' do
      expect(Card.for_review.size).to eq 3
    end
  end
end
