require "rails_helper"

RSpec.describe "Api::V1::recipes", type: :request do
    it "can pull recipes from countries [HAPPY]" do
        thailand_json = File.read("spec/fixtures/thailand.json")
        stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{Rails.application.credentials.edamam[:id]}&app_key=#{Rails.application.credentials.edamam[:key]}&q=thailand%7D&type=public").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: thailand_json, headers: {})

        get "/api/v1/recipes?country=thailand", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        
        expect(json_response['data'].count).to eq(20)
        expect(json_response['data'].first['id']).to eq('null')
        expect(json_response['data'].first['type']).to eq('recipe')
        expect(json_response['data'].first['attributes']['title']).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
        expect(json_response['data'].first['attributes']['url']).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
        expect(json_response['data'].first['attributes']['country']).to eq("thailand")
        expect(json_response['data'].first['attributes']['image']).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/611/61165abc1c1c6a185fe5e67167d3e1f0.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEJ%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIHV1YMKs%2BhU6u%2B32n%2BC%2FHV16lG2Uh29yUti9ZsPAnSHfAiBcsrv5j0ioLR5nWp%2BSBA5F1iRfx36Y7TR99NRix0b94CrCBQiY%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDE4NzAxNzE1MDk4NiIM16GQwdAMzSg%2BFFmnKpYFfuVcVRgwvMpYEQS0SSGGWPBnY7jcOk4s2ndQ7TctaDI0IWVP%2FGf%2B6L0jK%2Bx7oMzU2rEW4J8wPE%2BcO2LjGmav0ZFOKGGoFlu3p8HV4Hxn7uHLj%2FyGnScT%2FpX5Qo%2FUEi%2FBAkj0waHJk6Serw81cILt29OwSKYAATs1sMUlMgUAGheY5ClvusOVzHpLnvM7kpJ7vr%2FsBSFn5jHnjnWxsml878xxhln91tHsD3oBvpX9%2F5YD9gD4VwFCZoJBBrnxHAZQ8JBJTFcwIys5tLqBCRwg7HD0zlqteMiB%2Fj1m0Oo5EEzEXuebyELIJW2ryHr6TuK6ljKAd70%2BkwEkv17S8SwnF0uXPbV0dQTIa8B7edEPmOF0WmFkxETMd5f4vjb9WVGdaQ%2FsXA%2F7w4CLcfIC5Brb2K9EeES%2BKkI6cR6IgwvBGNkB1KsYoqm5lEQUG0tAk4Gr2e8EU2FiDH39%2Bup6ShT6V%2Fp6k%2FZOUmU9FJc3VLCfNChCSdq8Q6VuTJLUS9OF7spnHbEv%2B7LoLtBgZXFhCbaVrmLYmZd7GzeFN1wYcaPkNOGtDkQvY2dlEfLjMdxCxeLn4TT4Ocd1oRu8wU%2Bqfy5V6a3tIx35PMYiHJfI%2FfyRURuevx964wv7JeihU4oAugc%2Bq6S4p3ifpvpj7Xr%2Bcsi3odkwCYdyClugMTR5I7SQFS7vbeEiNYQ786U1gUNTxkAwbB91guhuk0d1ObGTH8OlxcfaqhkDeBHsVv3H0Gh8DE89KJaEdERiaE6gDvdreZYZa%2F%2F9jKAHjnJcv7yKlfv%2F1WdyQUHF559Z0WPj2wN7O62oQsKgTUtcR8nYeCyss2dRtrOXCmKUTYolSGEaSZ6ZcJs9ILNZfOc6ftqL77tqEFLRqk%2Bjmr8wgsCerwY6sgEWzqsEg0qrSW5dBS9LeGqdsd2Im38iiPtilz867EznVnTL4EAC%2BoD%2F50y%2Fzbck4H%2FRjHl%2BDL%2FkDc7sChiVU9H2MF1LV0QkHyIdEab1DUhZUZRDn%2FxNIUdpPWyJoOEwxGjktihMRyYVYOAz8%2B8PIgOOX5LvfNpE%2FGAs%2B3mlfcGwokE6bK74Q3l%2BWFVNGu4%2F13%2FmzuqVix7arqIZgIeFK9Ir8wdABPFx4qY3tu1eYvu9Zh7%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240305T235613Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFADKECWVK%2F20240305%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=2e6f6c28de048bf922444a3d260f47f1f0a4646421cb883885196c1bd49eed7f")
    end

    it "can pull recipes from countries [SAD: NO NAME]" do
      random_country_json = File.read("spec/fixtures/random_country.json")
      stub_request(:get, "https://restcountries.com/v3.1/all?fields=name").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: random_country_json, headers: {})

      cyprus_json = File.read("spec/fixtures/cyprus.json")
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{Rails.application.credentials.edamam[:id]}&app_key=#{Rails.application.credentials.edamam[:key]}&q=Cyprus%7D&type=public").
       with(
         headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v2.9.0'
         }).
       to_return(status: 200, body: cyprus_json, headers: {})

      get "/api/v1/recipes", headers: {"CONTENT_TYPE" => "application/json"}
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      
      expect(json_response['data'].count).to eq(20)
      expect(json_response['data'].first['id']).to eq('null')
      expect(json_response['data'].first['type']).to eq('recipe')
      expect(json_response['data'].first['attributes']['title']).to eq("Grilled Halloumi Bruschetta")
      expect(json_response['data'].first['attributes']['url']).to eq("https://alldayidreamaboutfood.com/low-carb-grilled-halloumi-bruschetta")
      expect(json_response['data'].first['attributes']['country']).to eq("Cyprus")
      expect(json_response['data'].first['attributes']['image']).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/b60/b60ea0e0f5904342488d092f94e528a3.png?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEKH%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQDtlS%2FB0mP2dLwXBCWgvXqVZmEOrHRxKn%2FAeihWlNcg%2BwIgDALZL2m2oG%2BrjhJxlGW8CfaSCi8gBkDl%2F%2BzZAknAOAQqwgUImv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDOvHFPiCLfisquB7UiqWBbtm1dEer9cwfqDgLYoUh5jzUWG5pcBgRU8Yfj0ChA7FaYlrTMAh9%2FfI8gqNQvUSoctvsH9WmLANJvKPDf%2BWzDGR5x%2F7r6KkjBUrQE6907%2FZYD74K2eiBZu8Ew2zyXLU9qGyc%2FeB9ZeRhQPReQEsCx4bgkJxmRHiWN7Ri7b6Vx7gpWlUFRgttPJs2UQV9rZfuRX4PkWJpT2oYhqwIee4WaevFbUiQgETCsA6LdQD2jR6cCwaZn9UGHJS7lXlRsOzy4m2p6E5amkaHBYCf7Z7lFJCmGP13o21DAzaPpGLwhxlb2%2BbmCb5RiUDHkdgSo3KcdYHJQtUt1lAkEEAFB6ZFU1rwjoHl840FHggTLUv0zLZDgJaj639gQfyqwhTn8Lg8fPFcE1Wl85FPhU1r76sP5RJxjkTLGuUeTRhAuMDlJEmCT6FFEXiRc%2Flb3tEfG0ttuSnJ27CHDbwYoDAxbN7cKJB9jUC%2BFwa5ZsPlxRXlthLBWp0rPBSwcLmPh3oJAwYIuXcIxa%2BfAuHYqB4WjP989Z54NSJGJg23EQ2D%2BhKEn%2Fh8eMLxzWNgFLhWR%2FQwmiJdY3%2B613%2Buxg2i2oDFfQ5Z7AM%2Bhlx7fThzRP9LRXeuk4vdJqr4Z65G4SAGMqX4aE0dG%2B14Z%2FBw1wWJ9%2BINJvZg%2FdeZ35SSJVjQ9KY%2B14rk6qjt0BVsvtqlfQM9s6k0PxmwEOEv3Pvu5OsQY%2FY829WCb2HoMqetYvLlFlJsS8Lokw9bs31EFUw%2BQZ2CgvURdFoYFJZiAyGiOtGuDUZxIyqHwHyrYAIP%2F%2BLx7QzZbjFaUb0%2FqjBhh1oZ8%2BlAhEUEDBod90eB%2BZPX96CTbG1feU3Gcer3Dnw2RpUYW3oZks4PIRGCP4hR92bMMz0nq8GOrEBD2i5jzxLaXfF8PP%2BWyS4QljfRY9gX5cq2CrmnJTIrh%2B%2FBxW5XM0nWBbEDgrsXtiXKb%2F%2B6F%2FQ7RqnBBvovfcSeI3KcoAAYyQAKYRB1yIz8%2BtnyvJh%2BkIigK2itKM3slurcNP%2Futu8MmdRS%2FtLoZ2oYdX3kORtiU9CtiaEhzk30YJYlvCkD0Z6%2Ba0cJOmtgvQ4v9cDZE13tY8iYjOQ%2Bi0AeDeIUWpXgJvoGhWsrB908u6W&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240306T014326Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=ASIASXCYXIIFBXPADLNY%2F20240306%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=72aecfcca9f9da263b7526a796f24c9c8f88e1b5f100767b42a92e26aa22a469")
  end

  it "can pull recipes from countries [SAD: BLANK INPUT]" do
    recipe_blank_input_json = File.read("spec/fixtures/recipe_blank_input.json")
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{Rails.application.credentials.edamam[:id]}&app_key=#{Rails.application.credentials.edamam[:key]}&q=%7D&type=public").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: recipe_blank_input_json, headers: {})

    get "/api/v1/recipes?country=", headers: {"CONTENT_TYPE" => "application/json"}
    expect(response).to have_http_status(:success)
    json_response = JSON.parse(response.body)
    
    expect(json_response['data']).to eq([])
    expect(json_response['data'].count).to eq(0)
end
end