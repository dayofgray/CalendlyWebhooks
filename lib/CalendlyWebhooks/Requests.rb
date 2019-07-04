require 'net/http'
require 'uri'

uri = URI.parse("https://calendly.com/api/v1/hooks")
request = Net::HTTP::Post.new(uri)
request["X-Token"] = "BEAMNEOOODNKWWUA62534YDIUIBYENM7"
request.set_form_data(
  "events[]" => "invitee.created",
  "url" => "http://webhook.site/3901aae0-f1cb-4bc2-b2e4-7d6460772926",
)

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

# response.code
# response.body