class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_are_not_equal
  before_create :set_default_review_date

  def text_are_not_equal
    if prepare_text(original_text) == prepare_text(translated_text)
      errors.add(:original_text, 'Оригинальный текст не должен быть равен тексту перевода')
      errors.add(:translated_text, 'Текст перевода не должен быть равен оригинальному тексту')
    end
  end

  def prepare_text(text_param)
    text_param.squish.mb_chars.downcase.to_s
  end

  def set_default_review_date
    self.review_date = self.review_date + 3.day
  end

end
