class Card < ActiveRecord::Base
  attr_reader :image_crop_data
  belongs_to :deck
  belongs_to :user
  validates :original_text, :translated_text, :review_date, :user_id, presence: true, on: [:create, :update]
  validate :text_are_not_equal
  before_create :set_default_review_date
  scope :for_review, -> { where('review_date <= ?', DateTime.now).order('random()') }

  mount_uploader :image, ImageUploader

  def set_default_review_date
    self.review_date = DateTime.now
  end

  def check_translation(input_text)
    equal_text = prepare_text(translated_text) == prepare_text(input_text)
    if equal_text && self.accuracy <= -3
      self.accuracy = 0
      self.attempt = 1
      update_attributes(review_date: (self.review_date + calculate_review_date))
      true
    elsif equal_text && self.accuracy > -3
      update_attributes(attempt: self.attempt += 1, review_date: (self.review_date + calculate_review_date))
      true
    else
      update_attributes(attempt: attempt + 1, accuracy: accuracy - 1)
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


  def calculate_review_date
      case self.attempt
      when 1
        12.hours
      when 2
        3.days
      when 3
        7.days
      when 4
        14.days
      when 5
        30.days
      end
  end
end