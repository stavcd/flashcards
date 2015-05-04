FactoryGirl.define do
  factory :card do
    original_text 'hello'
    translated_text 'привет'
    review_date  (DateTime.current.to_date)
  end

end
