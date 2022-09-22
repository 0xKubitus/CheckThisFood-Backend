require 'dotenv'
# require 'uri'
require 'net/http'
require 'json'

# 1ere etape: creer un array avec des noms de recettes:
recipes_names = ['carbonara']#, 'poulet roti', 'Nutella Brownies', 'Chicken Ceasar Salad', 'Crumble Pomme Mangue', 'bouillabaisse']

# 2eme etape: pour chaque nom de recette dans l'array, faire un fetch sur l'API Recipe d'Edamam ;
api_id = ENV["EDEMAM_RECIPES_API_ID"]
api_key = ENV['EDEMAM_RECIPES_API_KEY']

uri_start = 'https://api.edamam.com/api/recipes/v2?type=public&q='
uri_end = "&app_id=" + api_id + "&app_key=" + api_key

recipes_names.each do |recipe|
  recipe = URI.encode(recipe)
  full_string = uri_start + recipe + uri_end
  uri = URI(full_string)

  response = Net::HTTP.get_response(uri)
  # puts '=================================================================='
  # puts response.body if response.is_a?(Net::HTTPSuccess) # SHOULD BE A COMMENT
  # puts '=================================================================='
  results = JSON.parse(response.body)["hits"]

  results.each do |result|
    puts result['recipe']['label']
    
    # rec = i['recipe']
    # puts '=================================================================='
    # puts rec
    # puts '=================================================================='

    # rec.each do |i|
    #   label = i.label
    #   puts '=================================================================='
    #   puts label
    #   puts '=================================================================='
    # end
  
  end



  # result.each do |s|
  #   Story.create(title: s["title"], author: s["author"], content:   s["content"], url: s["url"])
  # end


# 3eme etape: faire un Recipe.create() sur le premier resultat de chaque fetch.
  # recipes = Recipe.create(
  #   title: ,
  #   description: '',
  #   carbohydrates: '',
  #   calories: '',
  #   image_url: ''
  # )

  # puts '=================================================================='
  # puts 'une recette a été créée'
  # puts '=================================================================='

end # fin du "recipes_names.each"




################################################

=begin
Recipe.destroy_all

comments = Comment.create([
  {recipe: Recipe.first,
  content: 'super recette'},

  {
      recipe: Recipe.first,
      content: "j'ai pas aimé"
  }
])
=end

################################################

# RECETTES HARDCODEES :
# recipes = Recipe.create!([
#     { title: "Lasagnes à la bolognaise", description: "Faire revenir gousses hachées d'ail et les oignons émincés dans un peu d'huile d'olive.", carbohydrates: rand(20..60), calories: rand(1..13), image_url: 'https://images.pexels.com/photos/4079520/pexels-photo-4079520.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'},
#     { "title": "Chili con carne", "description": "Mélanger le chili, le cumin, le concentré de tomates, et incorporer le tout au boeuf. Ajouter les haricots, le bouillon, du sel et du poivre", "carbohydrates": rand(20..60), "calories": rand(1..13), image_url: 'https://images.pexels.com/photos/5737377/pexels-photo-5737377.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'},  
#     { "title": "Tomates farcies", "description": "Couper le haut des tomates et les évider. Poivrer et saler l'intérieur. Mettre la farce à l'intérieur et remettre les chapeaux.", "carbohydrates": rand(20..60), "calories": rand(1..13), image_url: 'https://images.pexels.com/photos/96616/pexels-photo-96616.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'},  
#     { "title": "Rougail saucisse", "description": "Coupez les saucisses en troncons de 1,5 cm puis faites les revenir avec les oignons. Au bout de 5 mn, ajoutez les tomates coupées en petits morceaux et les aromates (le piment en morceaux).", "carbohydrates": rand(20..60), "calories": rand(1..13), image_url: 'https://images.pexels.com/photos/812868/pexels-photo-812868.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'},  
#     { "title": "Risotto aux champignons
#     ", "description": "Séparer les champignons en deux (préférer des cèpes) : une partie servira à élaborer le bouillon et cuira avec le riz. L'autre partie sera poêlé au dernier moment pour la présentation et mettre en avant le champignon tout en conservant une texture ferme. Emincer un petit peu d'ail, d'échalote et de persil séparément et réserver.", "carbohydrates": rand(20..60), "calories": rand(1..13), image_url: 'https://images.pexels.com/photos/5638527/pexels-photo-5638527.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'}, 
#     ]);