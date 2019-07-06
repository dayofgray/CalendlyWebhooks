class CalendlyWebhooks::Request

attr_accessor :endpoint_url, :token, :webhook_url, :type, :documentation

@@all = []

def initialize(type, documentation)
    @type = type
    @documentation = documentation
    @@all << self
end

def self.all
  @@all
end

def self.create_from_scraper(url)
  request_info = CalendlyWebhooks::Scraper.new.get_request_info(url)
  CalendlyWebhooks::Request.new(request_info[0], request_info[1])
end

def make_request

uri = URI.parse("#{endpoint_url}")
request = Net::HTTP::Post.new(uri)
request["X-Token"] = "#{token}"
request.set_form_data(
  "events[]" => "invitee.created",
  "url" => "#{webhook_url}",
  )

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end
end
end