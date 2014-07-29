module YouTubeHelper
  require 'google/api_client'

  YOUTUBE_DEVELOPER_KEY = ENV["YOUTUBE_KEY"]
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def get_service
    client = Google::APIClient.new(
    :key => YOUTUBE_DEVELOPER_KEY,
    :authorization => nil,
    :application_name => $PROGRAM_NAME,
    :application_version => '1.0.0'
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    return client, youtube
  end

  def find(song)
    client, youtube = get_service
    begin
      search_response = client.execute!(
      :api_method => youtube.search.list,
      :parameters => {
        :part => 'snippet',
        :q => song + " karaoke lyrics"
      }
      )

      videos = []

      search_response.data.items.each do |search_result|
        case search_result.id.kind
        when 'youtube#video'
          videos << { :title => search_result.snippet.title,
            :ytid => search_result.id.videoId }
          end
        end

      rescue Google::APIClient::TransmissionError => e
        puts e.result.body
      end

      return videos.first
    end

    def add_song(song)
    end

  end
