require 'pry'
require 'nokogiri'
require 'open-uri'

class CalendlyWebhooks::Scraper

    def get_page(url)
    Nokogiri::HTML(open(url))
    end

    def get_endpoint_url(url)
    request_info = get_page(url).css("div.docs-header h1").text.split(/\B(?=[A-Z])/)
    @type = request_info[0]
    @documentation = request_info[1]
    end

    def create_request
    Request.new("placeholder","placeholder", "placeholder", @type, @documentation)
    end
end
