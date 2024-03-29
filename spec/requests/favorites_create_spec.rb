require "rails_helper"

RSpec.describe "Api::V1::users", type: :request do
    it "can create new favorite [HAPPY]" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        original_favorite_count = Favorite.all.count
        input_body = {
            "api_key": User.last.api_key,
            "country": "thailand",
            "recipe_link": "https://www.tastingtable.com/",
            "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(201)
        json_response = JSON.parse(response.body)
        expect(Favorite.all.count).to eq(original_favorite_count+1)

        expect(Favorite.last.user_id).to eq(User.last.id)
        expect(Favorite.last.user).to eq(User.last)
        expect(Favorite.last.country).to eq('thailand')
        expect(Favorite.last.recipe_link).to eq('https://www.tastingtable.com/')
        expect(Favorite.last.recipe_title).to eq('Crab Fried Rice (Khaao Pad Bpu)')

        expect(User.last.favorites.last).to eq(Favorite.last)

        expect(json_response['success']).to eq('Favorite added successfully')
    end

    it "can create new favorite [SAD] - bad api_key" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        original_favorite_count = Favorite.all.count

        input_body = {
            "country": "thailand",
            "recipe_link": "https://www.tastingtable.com/",
            "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(Favorite.all.count).to eq(original_favorite_count)
        expect(json_response['failed']).to eq('API Key not found')

        input_body = {
            "api_key": '',
            "country": "thailand",
            "recipe_link": "https://www.tastingtable.com/",
            "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(Favorite.all.count).to eq(original_favorite_count)
        expect(json_response['failed']).to eq('API Key not found')

        input_body = {
            "api_key": 'e8ng0en9bs',
            "country": "thailand",
            "recipe_link": "https://www.tastingtable.com/",
            "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(Favorite.all.count).to eq(original_favorite_count)
        expect(json_response['failed']).to eq('API Key not found')
    end

    it "can create new favorite [SAD] - missing input" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        original_favorite_count = Favorite.all.count

        input_body = {
            "api_key": User.last.api_key,
            "recipe_link": "https://www.tastingtable.com/",
            "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(Favorite.all.count).to eq(original_favorite_count)
        expect(json_response['country'].first).to eq("can't be blank")

        input_body = {
            "api_key": User.last.api_key,
            "country": "thailand",
            "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(Favorite.all.count).to eq(original_favorite_count)
        expect(json_response['recipe_link'].first).to eq("can't be blank")

        input_body = {
            "api_key": User.last.api_key,
            "country": "thailand",
            "recipe_link": "https://www.tastingtable.com/",
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(Favorite.all.count).to eq(original_favorite_count)
        expect(json_response['recipe_title'].first).to eq("can't be blank")
    end
end