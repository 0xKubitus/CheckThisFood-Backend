require 'dotenv'
require 'net/http'
require 'json'


Comment.destroy_all
Recipe.destroy_all
User.destroy_all


################################################################
# RECUPERER DES RECETTES SUR API EDAMAM POUR PEUPLER NOTRE BDD 
# 1ere etape: creer un array avec des noms de recettes:
recipes_names = ['carbonara', 'poulet roti', 'Nutella Brownies', 'Chicken Ceasar Salad', 'raclette', 'Crumble Pomme Mangue', 'bouillabaisse', 'Bacon, Egg, and Toast Cups', 'cereal', 'yogurt']
trendy_recipes = ['Nutella Brownies',]

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
  # Pour plus facilement lire les resultats:
    # result['recipe'].each do |j|
    #   puts j
    # end

    label = result['recipe']['label']
    # puts label # SHOULD BE A COMMENT
    thumbnail = result['recipe']['image']
    ingredientLines = result['recipe']['ingredientLines']
    carbs = result['recipe']['totalNutrients']['CHOCDF']['quantity']
    kcal = result['recipe']['totalNutrients']['ENERC_KCAL']['quantity']
    mealType = result['recipe']['mealType'] 
  
# 3eme etape: faire un Recipe.create() sur le premier resultat de chaque fetch.
  recipes = Recipe.create(
    title: label,
    description: ingredientLines,
    categories: mealType,
    carbohydrates: carbs,
    calories: kcal,
    image_url: thumbnail
  )  
  end
end # fin du "recipes_names.each"
puts '=================================================================='
puts 'Recettes cr????es'
puts '=================================================================='

################################################################
# creation de fake utilisateurs :
30.times do 
  |i|
  User.create(email:"test#{i}@test.com", encrypted_password:'Azerty!23', created_at: Time.now, updated_at: Time.now)
end
puts '=================================================================='
puts 'Users cr????s'
puts '=================================================================='


# creation de fake commentaires :
30.times do 
  |i|
  Comment.create!(content:"commentaire#{i}", user_id:rand(1..20), recipe_id:Recipe.all.sample.id, created_at: Time.now, updated_at: Time.now)
end
puts '=================================================================='
puts 'Commentaires cr????s'
puts '=================================================================='


20.times do 
  |i|
  recipe = Recipe.where(id: Recipe.all.sample.id)
  recipe.update!(is_trendy?: true) 
end
puts '=================================================================='
puts 'Recettes trendy ajout??es!'
puts '=================================================================='












################################################

# ANCIENNES RECETTES HARDCODEES A LA MAIN :
# recipes = Recipe.create!([
#     { title: "Lasagnes ?? la bolognaise", description: "Faire revenir gousses hach??es d'ail et les oignons ??minc??s dans un peu d'huile d'olive.", carbohydrates: rand(20..60), calories: rand(1..13), image_url: 'https://images.pexels.com/photos/4079520/pexels-photo-4079520.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'},
#     { "title": "Chili con carne", "description": "M??langer le chili, le cumin, le concentr?? de tomates, et incorporer le tout au boeuf. Ajouter les haricots, le bouillon, du sel et du poivre", "carbohydrates": rand(20..60), "calories": rand(1..13), image_url: 'https://images.pexels.com/photos/5737377/pexels-photo-5737377.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'},  
#     { "title": "Tomates farcies", "description": "Couper le haut des tomates et les ??vider. Poivrer et saler l'int??rieur. Mettre la farce ?? l'int??rieur et remettre les chapeaux.", "carbohydrates": rand(20..60), "calories": rand(1..13), image_url: 'https://images.pexels.com/photos/96616/pexels-photo-96616.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'},  
#     { "title": "Rougail saucisse", "description": "Coupez les saucisses en troncons de 1,5 cm puis faites les revenir avec les oignons. Au bout de 5 mn, ajoutez les tomates coup??es en petits morceaux et les aromates (le piment en morceaux).", "carbohydrates": rand(20..60), "calories": rand(1..13), image_url: 'https://images.pexels.com/photos/812868/pexels-photo-812868.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'},  
#     { "title": "Risotto aux champignons
#     ", "description": "S??parer les champignons en deux (pr??f??rer des c??pes) : une partie servira ?? ??laborer le bouillon et cuira avec le riz. L'autre partie sera po??l?? au dernier moment pour la pr??sentation et mettre en avant le champignon tout en conservant une texture ferme. Emincer un petit peu d'ail, d'??chalote et de persil s??par??ment et r??server.", "carbohydrates": rand(20..60), "calories": rand(1..13), image_url: 'https://images.pexels.com/photos/5638527/pexels-photo-5638527.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'}, 
#     ]);