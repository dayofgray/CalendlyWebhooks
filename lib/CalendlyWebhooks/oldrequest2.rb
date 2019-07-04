# class Request

# attr_accessor :endpoint_url, :token, :webhook_url

require 'net/http'
require 'uri'

def make_request

uri = URI.parse("https://calendly.com/api/v1/hooks")
request = Net::HTTP::Post.new(uri)
request["X-Token"] = "BEAMNEOOODNKWWUA62534YDIUIBYENM7"
request.set_form_data(
  "events[]" => "invitee.created",
  "url" => "http://webhook.site/a14c2a12-85b1-4244-8203-c7d27f6c6320",
  )

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

end
end

# response.code
# response.body