require 'open-uri'
require 'nokogiri'

BASE_URL = 'https://docs.ruby-lang.org/ja/latest/library/'

def search_and_print_content(query)
  document = Nokogiri::HTML(URI.open(BASE_URL))

  link = document.css('a').find { |a| a.text.include?(query) }

  if link
    absolute_link = URI.join(BASE_URL, link['href']).to_s
    content = URI.open(absolute_link).read

    # Select lines that contain Japanese characters
    japanese_lines = content.lines.select { |line| line =~ /\p{Han}|\p{Hiragana}|\p{Katakana}/ }

    puts japanese_lines.join

  else
    puts "No matching link found for query: #{query}"
  end
end

query = ARGV[0]
search_and_print_content(query) if query
