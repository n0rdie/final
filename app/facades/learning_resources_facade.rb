class LearningResourcesFacade

    def self.country_search(country)
        youtube_service = YoutubeService.new
        youtube_json = youtube_service.search(country)
        youtube = {}
        if youtube_json[:items].count > 0
            youtube = YoutubePoro.new(youtube_json[:items])
        end

        unsplash_service = UnsplashService.new
        unsplash_json = unsplash_service.search(country)[:results]

        unsplash = []
        if unsplash_json.count > 9
            10.times do |i|
                unsplash.append(UnsplashPoro.new(unsplash_json[i-1]))
            end
        end

        {'country': country, 'video': youtube, 'images': unsplash}
    end
end