require "mongoid_shortener/engine"

module MongoidShortener
  # The prefix_url for generated shortened url
  mattr_accessor :prefix_url, :root_url, :prefix_len, :key_length
  @@root_url = "http://localhost:3000"
  @@prefix_url = "http://localhost:3000/~"
  @@prefix_len = 1
  @@key_length = 5

  def self.generate url
    ShortenedUrl.generate url
  end
end
