class VideoService
  def self.conn
    Faraday.new(url: 'https://www.googleapis.com', params: { key: ENV['youtube_api_key']})
  end

  def self.search(country)
    response = conn.get('/youtube/v3/search', { 
      type: 'video', 
      channelId: 'UCluQ5yInbeAkkeCndNnUhpw', 
      q: country,
      part: 'snippet',
      maxResults: 1
      })
    JSON.parse(response.body, symbolize_names: true)
  end
end