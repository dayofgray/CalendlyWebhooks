class CalendlyWebhooks::Request

attr_accessor :endpoint_url, :token, :webhook_url, :type, :documentation

def initialize(endpoint_url, token, webhook_url, type, documentation)
    @endpoint_url = endpoint_url
    @token = token
    @webhook_url = webhook_url
    @type = type
    @documentation = documentation
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