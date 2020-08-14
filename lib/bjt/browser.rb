require 'launchy'

module Bjt
  class Browser
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def open
      Launchy.open(url) do |exception|
        puts "Attempted to open '#{url}' and failed because #{exception}"
      end
    end
  end
end
