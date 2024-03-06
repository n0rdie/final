class YoutubePoro
    attr_reader :title,
                :youtube_video_id
  
    def initialize(data)
        @title = data.first[:snippet][:title]
        @youtube_video_id = data.first[:id][:videoId]
    end
end