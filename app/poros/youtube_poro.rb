class YoutubePoro
    attr_reader :title,
                :youtube_video_id
  
    def initialize(data)
        @title = data[:items].first[:snippet][:title]
        @youtube_video_id = data[:items].first[:id][:videoId]
    end
end