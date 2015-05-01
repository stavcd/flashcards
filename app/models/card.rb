class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_are_not_equal
  before_create :set_default_review_date
  scope :random_cards_to_check, -> { Card.order('random()').where('review_date<=?', DateTime.now).first() }

  def set_default_review_date
    self.review_date = self.review_date + 3.day
  end

  def checking_card_text_errors?(translated_text, input_text)
    prepare_text(translated_text) == prepare_text(input_text) ? true : false
  end

  protected

  def prepare_text(text_param)
    text_param.squish.mb_chars.downcase.to_s
  end

  def text_are_not_equal
    if prepare_text(original_text) == prepare_text(translated_text)
      errors.add(:original_text, 'Оригинальный текст не должен быть равен тексту перевода')
      errors.add(:translated_text, 'Текст перевода не должен быть равен оригинальному тексту')
    end
  end

end
