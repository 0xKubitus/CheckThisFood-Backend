require 'rest-client'

def best_news_secret_key
  ENV["THE_BEST_NEWS_API_KEY"]
end


api_data = { key: best_news_secret_key }
news = RestClient.get("https://newsapi.org/v2/top-headlines?q=coronavirus&apiKey=#{api_data[:key]}")
news_array = JSON.parse(news)#["articles"]

puts news_array
  
  # news_array.each do |s|
  #   Recipe.create(title: s["title"])
  #   puts 'recette creee'
  # end

