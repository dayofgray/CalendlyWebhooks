require 'net/http'
require 'uri'
require 'pry'
require 'nokogiri'

require_relative "./CalendlyWebhooks/version"
require_relative "./CalendlyWebhooks/CLI"
require_relative "./CalendlyWebhooks/Request"
require_relative "./CalendlyWebhooks/Scraper"
#require "CalendlyWebhooks/CLI"

module CalendlyWebhooks
  class Error < StandardError; end
  # Your code goes here...
end
