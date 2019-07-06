require 'pry'
require 'nokogiri'
require 'open-uri'

class CalendlyWebhooks::Scraper

    def get_page(url)
    Nokogiri::HTML(open(url))
    end

    def get_request_info(url)
    request_info = get_page(url).css("div.docs-header h1").text.split(/\B(?=[A-Z])/)
    end

end
