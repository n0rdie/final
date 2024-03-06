require "rails_helper"

RSpec.describe "Api::V1::users", type: :request do
    it "can get favorites of user [HAPPY]" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        input_body = {
            "api_key": User.last.api_key,
            "country": "thailand",
            "recipe_link": "https://www.tastingtable.com/",
            "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        input_body = {
            "api_key": User.last.api_key,
            "country": "america",
            "recipe_link": "https://www.mcdonalds.com/",
            "recipe_title": "Big Mac"
        }
        post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        get "/api/v1/favorites?api_key=#{User.last.api_key}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)

        expect(json_response['data'].count).to eq(2)
        expect(json_response['data'].last['attributes']['recipe_title']).to eq('Big Mac')

        expect(json_response['data'].first['id']).to_not eq(nil)
        expect(json_response['data'].first['type']).to eq('favorite')
        expect(json_response['data'].first['attributes'].count).to eq(4)
        expect(json_response['data'].first['attributes']['recipe_title']).to eq('Crab Fried Rice (Khaao Pad Bpu)')
        expect(json_response['data'].first['attributes']['recipe_link']).to eq('https://www.tastingtable.com/')
        expect(json_response['data'].first['attributes']['country']).to eq('thailand')
        expect(json_response['data'].first['attributes']['created_at']).to_not eq(nil)
    end

    it "can get favorites of user [SAD] - no favorites" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        get "/api/v1/favorites?api_key=#{User.last.api_key}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)

        expect(json_response['data'].count).to eq(0)
        expect(json_response['data']).to eq([])
    end

    it "can get favorites of user [SAD] - bad api_key" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        get "/api/v1/favorites?api_key=bad_key", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(json_response['failed']).to eq('API Key not found')

        get "/api/v1/favorites?api_key=", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(json_response['failed']).to eq('API Key not found')

        get "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(400)
        json_response = JSON.parse(response.body)
        expect(json_response['failed']).to eq('API Key not found')
    end
end