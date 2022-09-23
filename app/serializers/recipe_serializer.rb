class RecipeSerializer
  include JSONAPI::Serializer
  attributes :title, :image_url, :description, :categories, :carbohydrates, :calories, :is_trendy?

  has_many :comments

end