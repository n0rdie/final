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
        expect(User.all.count).to eq(original_user_count+1)

        expect(User.last.name).to eq('Odell')
        expect(User.last.email).to eq('goodboy@ruffruff.com')
        expect(User.last.password_digest).to_not eq(nil)
        expect(User.last.password_digest.length).to_not eq(0)
        expect(User.last.api_key).to_not eq(nil)
        expect(User.last.api_key.length).to_not eq(0)
    end
end