require 'rails_helper'

describe Card do

  it { should belong_to :user }

  let!(:user) { create(:user) }
  context 'checking attributes and review' do


    before do
      @card = user.cards.create(original_text: 'hello', translated_text: 'Привет',
                                review_date: DateTime.current.to_date)
    end
    describe 'card has valid attributes' do

      it 'validates card has  user_id' do
        expect(@card.user.id).to eq user.id
      end

      it 'validates original_text' do
        expect(@card.original_text).to eq('hello')
      end

      it 'validates translated text' do
        expect(@card.translated_text).to eq('Привет')
      end
    end

    describe 'card has different texts' do

      card = Card.create(original_text: 'hello', translated_text: ' HelLo ',
                         review_date: DateTime.current)

      it 'validates text_are_not_equal' do
        expect(card).to_not be_valid
      end
    end

    describe 'check translation for first attempt' do
      before do
        @card.attempt = 0
        @card.check_translation('привет')
      end
      it 'check changes review date to 12 hours' do
        expect(@card.review_date).to eq((DateTime.current+12.hours))
      end
      it 'caheck attempt value' do
        expect(@card.attempt).to eq 1
      end
    end

    describe 'check translation for second attempt' do

      before do
        @card.attempt = 1
        @card.check_translation('привет')
      end

      it 'check changes review date to 3 day' do
        expect(@card.review_date).to eq((DateTime.current+3.days))
      end
      it 'caheck attempt value' do
        expect(@card.attempt).to eq 2
      end
    end

    describe 'check translation for third attempt' do

      before do
        @card.attempt = 2
        @card.check_translation('привет')
      end

      it 'check changes review date to 14 day' do
        expect(@card.review_date).to eq((DateTime.current+7.days))
      end

      it 'caheck attempt value' do
        expect(@card.attempt).to eq 3
      end
    end

    describe 'check translation for four attempt' do

      before do
        @card.attempt = 3
        @card.check_translation('привет')
      end

      it 'check changes review date to 14 day' do
        expect(@card.review_date).to eq((DateTime.now + 14.days))
      end

      it 'caheck attempt value' do
        expect(@card.attempt).to eq 4
      end
    end

    describe 'check translation for five attempt' do

      before do
        @card.attempt = 4
        @card.check_translation('привет')
      end

      it 'check changes review date to 30 day' do
        expect(@card.review_date).to eq((DateTime.current+30.days))
      end

      it 'caheck attempt value' do
        expect(@card.attempt).to eq 5
      end
    end

    describe 'check translation for three bad attempt ' do

      before do
        @card.accuracy = -3
        @card.check_translation('привет')
      end

      it 'check changes review date 12 hour ' do
        expect(@card.review_date).to eq((DateTime.current+12.hours))
      end

      it 'check accuracy value' do
        expect(@card.accuracy).to eq 0
      end

    end
  end

  context 'check scope' do
    describe 'scope for_review has a certain size ' do

      before do
        3.times do
          user.cards.create(original_text: 'hello', translated_text: 'Привет',
                            review_date: DateTime.now)
        end
      end

      it 'check scope for_review size' do
        expect(Card.for_review.size).to eq 3
      end
    end
  end
end

