class RecipeSerializer
  include JSONAPI::Serializer
  attributes :title, :image_url, :description, :categories, :carbohydrates, :calories

  has_many :comments

end