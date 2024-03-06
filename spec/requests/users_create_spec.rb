require "rails_helper"

RSpec.describe "Api::V1::users", type: :request do
    it "can create new user [HAPPY]" do
        original_user_count = User.all.count

        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(201)
        json_response = JSON.parse(response.body)
        expect(User.all.count).to eq(original_user_count+1)

        expect(User.last.name).to eq('Odell')
        expect(User.last.email).to eq('goodboy@ruffruff.com')
        expect(User.last.password_digest).to_not eq(nil)
        expect(User.last.password_digest.length).to_not eq(0)
        expect(User.last.api_key).to_not eq(nil)
        expect(User.last.api_key.length).to_not eq(0)

        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['attributes']['name']).to eq('Odell')
        expect(json_response['data']['attributes']['email']).to eq('goodboy@ruffruff.com')
        expect(json_response['data']['attributes']['password_digest']).to eq(nil)
        expect(json_response['data']['attributes']['api_key']).to_not eq(nil)
        expect(json_response['data']['attributes']['api_key']).to_not eq(0)
    end

    it "can create new user [SAD] - non matching passwords" do
        original_user_count = User.all.count

        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "badpassword"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:bad_request)
        expect(User.all.count).to eq(original_user_count)
    end

    it "can create new user [SAD] - ununique email" do
        original_user_count = User.all.count
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)
        expect(User.all.count).to eq(original_user_count+1)
        
        original_user_count = User.all.count
        input_body = {
            "name": "Minecraft Steve",
            "email": "goodboy@ruffruff.com",
            "password": "goodpassword",
            "password_confirmation": "goodpassword"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:bad_request)
        expect(User.all.count).to eq(original_user_count)
    end
end