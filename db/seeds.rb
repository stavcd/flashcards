# ruby encoding: utf-8

require 'open-uri'
require 'nokogiri'

Card.delete_all

url = "https://quizlet.com/45155485/flash-cards"

doc = Nokogiri::HTML(open(url))
doc.css('div.text').each do |word|
  original_text = word.css('span.lang-en').text
  translated_text = word.css('span.lang-ru').text
  Card.create!(original_text: original_text, translated_text: translated_text, review_date: DateTime.now)
end