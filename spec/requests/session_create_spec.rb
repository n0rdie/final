require "rails_helper"

RSpec.describe "Api::V1::sessions", type: :request do
    it "can create new session [HAPPY]" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        input_body = {
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
        }
        post "/api/v1/sessions", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['data']['id'].to_i).to eq(User.last.id.to_i)
        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['attributes']['name']).to eq('Odell')
        expect(json_response['data']['attributes']['email']).to eq('goodboy@ruffruff.com')
        expect(json_response['data']['attributes']['password_digest']).to eq(nil)
        expect(json_response['data']['attributes']['api_key']).to_not eq(nil)
        expect(json_response['data']['attributes']['api_key']).to_not eq(0)
    end

    it "can create new session [SAD] - bad email" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        input_body = {
            "email": "badboy@ruffruff.com",
            "password": "treats4lyf",
        }
        post "/api/v1/sessions", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:bad_request)
    end

    it "can create new session [SAD] - bad password" do
        input_body = {
            "name": "Odell",
            "email": "goodboy@ruffruff.com",
            "password": "treats4lyf",
            "password_confirmation": "treats4lyf"
        }
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:success)

        input_body = {
            "email": "goodboy@ruffruff.com",
            "password": "wrong",
        }
        post "/api/v1/sessions", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(input_body)
        expect(response).to have_http_status(:bad_request)
    end
end