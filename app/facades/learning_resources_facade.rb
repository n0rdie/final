class LearningResourcesFacade

    def self.country_search(country)
        youtube_service = YoutubeService.new
        youtube_json = youtube_service.search(country)
        youtube = YoutubePoro.new(youtube_json)

        unsplash_service = UnsplashService.new
        unsplash_json = unsplash_service.search(country)[:results]

        unsplash = []
        10.times do |i|
            unsplash.append(UnsplashPoro.new(unsplash_json[i-1]))
        end

        {'country': country, 'video': youtube, 'images': unsplash}
    end
end