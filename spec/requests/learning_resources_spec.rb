require "rails_helper"

RSpec.describe "Api::V1::learning_resources", type: :request do
    it "can pull youtube and unsplash" do
        laos_youtube_json = File.read("spec/fixtures/laos_youtube.json")
        stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.youtube[:key]}&part=snippet&q=laos").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: laos_youtube_json, headers: {})

        laos_unsplash_json = File.read("spec/fixtures/laos_unsplash.json")
        stub_request(:get, "https://api.unsplash.com/search/photos/?client_id=#{Rails.application.credentials.unsplash[:access_key]}&query=laos").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: laos_unsplash_json, headers: {})

        get "/api/v1/learning_resources?country=laos", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['data']['id']).to eq('null')
        expect(json_response['data']['type']).to eq('learning_resources')
        expect(json_response['data']['attributes']['country']).to eq('laos')
        expect(json_response['data']['attributes']['video']['title']).to eq('A Super Quick History of Laos')
        expect(json_response['data']['attributes']['video']['youtube_video_id']).to eq('uw8hjVqxMXw')
        expect(json_response['data']['attributes']['images'].count).to eq(10)
        expect(json_response['data']['attributes']['images'].first['alt_tag']).to eq('body of water during sunset')
        expect(json_response['data']['attributes']['images'].first['url']).to eq('https://images.unsplash.com/photo-1553856622-d1b352e9a211?ixid=M3w1NzU1NTZ8MHwxfHNlYXJjaHwxMHx8bGFvc3xlbnwwfHx8fDE3MDk2OTkyMDR8MA&ixlib=rb-4.0.3')
    end

    it "can pull youtube and unsplash [SAD] - illogical input" do
        crazy_youtube = File.read("spec/fixtures/crazy_youtube.json")
        stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.youtube[:key]}&part=snippet&q=039275280noegrberg0t286ynoege4h02").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: crazy_youtube, headers: {})

        crazy_unsplash = File.read("spec/fixtures/crazy_unsplash.json")
        stub_request(:get, "https://api.unsplash.com/search/photos/?client_id=#{Rails.application.credentials.unsplash[:access_key]}&query=039275280noegrberg0t286ynoege4h02").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: crazy_unsplash, headers: {})

        get "/api/v1/learning_resources?country=039275280noegrberg0t286ynoege4h02", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['data']['id']).to eq('null')
        expect(json_response['data']['type']).to eq('learning_resources')
        expect(json_response['data']['attributes']['country']).to eq('039275280noegrberg0t286ynoege4h02')
        expect(json_response['data']['attributes']['video']).to eq({})
        expect(json_response['data']['attributes']['images']).to eq([])
        expect(json_response['data']['attributes']['images'].count).to eq(0)
    end

    it "can pull youtube and unsplash [SAD] - no input" do
        random_laos = File.read("spec/fixtures/random_laos.json")
        stub_request(:get, "https://restcountries.com/v3.1/all?fields=name").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: random_laos, headers: {})

        laos_youtube_json = File.read("spec/fixtures/laos_youtube.json")
         stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.youtube[:key]}&part=snippet&q=laos").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.9.0'
            }).
          to_return(status: 200, body: laos_youtube_json, headers: {})
 
        laos_unsplash_json = File.read("spec/fixtures/laos_unsplash.json")
         stub_request(:get, "https://api.unsplash.com/search/photos/?client_id=#{Rails.application.credentials.unsplash[:access_key]}&query=laos").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.9.0'
            }).
          to_return(status: 200, body: laos_unsplash_json, headers: {})

        get "/api/v1/learning_resources", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['data']['id']).to eq('null')
        expect(json_response['data']['type']).to eq('learning_resources')
        expect(json_response['data']['attributes']['country']).to eq('laos')
        expect(json_response['data']['attributes']['video']['title']).to eq('A Super Quick History of Laos')
        expect(json_response['data']['attributes']['video']['youtube_video_id']).to eq('uw8hjVqxMXw')
        expect(json_response['data']['attributes']['images'].count).to eq(10)
        expect(json_response['data']['attributes']['images'].first['alt_tag']).to eq('body of water during sunset')
        expect(json_response['data']['attributes']['images'].first['url']).to eq('https://images.unsplash.com/photo-1553856622-d1b352e9a211?ixid=M3w1NzU1NTZ8MHwxfHNlYXJjaHwxMHx8bGFvc3xlbnwwfHx8fDE3MDk2OTkyMDR8MA&ixlib=rb-4.0.3')
    end
end