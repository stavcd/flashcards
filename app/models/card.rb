class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :validate_text
  before_create do
    self.review_date = self.review_date + 3.day
  end

  def validate_text
    if word(original_text)==word(translated_text)
      self.errors.add(:original_text, 'Оригинальный текст не должен быть равен тексту перевода')
      self.errors.add(:translated_text, 'Текст перевода не должен быть равен  оригинальному тексту')
    end
  end

  def word(word_param)
    word_param.squish.mb_chars.downcase.to_s
  end

end
