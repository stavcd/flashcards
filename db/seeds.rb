require 'open-uri'
require 'nokogiri'

User.delete_all

user = User.create(email: 'nokogiritest@test.com',password: 'test',
password_confirmation: 'test')

url = "https://quizlet.com/45734332/flash-cards/"

doc = Nokogiri::HTML(open(url), nil, 'utf-8')
doc.css('div.text').each do |word|
  original_text = word.css('span.lang-en').text
  translated_text = word.css('span.lang-ru').text
  user.cards.create! original_text: original_text,
               translated_text: translated_text,
               review_date: DateTime.now

end