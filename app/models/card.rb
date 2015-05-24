class Card < ActiveRecord::Base
  attr_reader :image_crop_data
  belongs_to :deck
  belongs_to :user
  validates :original_text, :translated_text, :review_date, :user_id, presence: true, on: [:create, :update]
  validate :text_are_not_equal
  # before_create :set_default_review_date
  scope :for_review, -> { where('review_date <= ?', DateTime.now).order('random()') }

  mount_uploader :image, ImageUploader

  def check_translation(input_text)
    if prepare_text(translated_text) == prepare_text(input_text) && self.accuracy <= -3
      self.accuracy = 0
      date_for_review(self.attempt = 1)
      true
    elsif prepare_text(translated_text) == prepare_text(input_text)
      date_for_review(self.attempt = + 1)
      true
    else
      self.attempt += 1
      self.accuracy -= 1
      false
    end
  end

  def crop_image!(c)
    c.each { |x, y| c[x] = y.to_i }
    @image_crop_data = c
    image.recreate_versions!
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

def date_for_review(attempt)
  case attempt
    when 1
      self.update_attributes(review_date: (DateTime.current+12.hour))
    when 2
      self.update_attributes(review_date: (DateTime.current+3.day).to_date)
    when 3
      self.update_attributes(review_date: (DateTime.current+7.day).to_date)
    when 4
      self.update_attributes(review_date: (DateTime.current+14.day).to_date)
    when 5
      self.update_attributes(review_date: (DateTime.current+30.day).to_date)
    else
      self.attempt = 0
      self.accuracy = 0
  end

end