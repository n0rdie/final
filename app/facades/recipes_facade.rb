class RecipesFacade

  def self.country_search(country)
    service = RecipesService.new
    json = service.recipes(country)

    @recipes = []
    json[:hits].each do |x|
      @recipes.append(RecipePoro.new(x[:recipe], country))
    end
    
    @recipes
  end
end