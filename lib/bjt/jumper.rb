module Bjt
  class Jumper
    class UnknownEventError < StandardError; end

    attr_reader :event, :package

    def initialize(event, package)
      @event = event
      @package = package
    end

    def jump
      case event
      when :g, :s then Browser.new(info[:source_code_uri]).open
      when :h then Browser.new(info[:homepage]).open
      when :p then Browser.new(info[:package_url]).open
      when :r then Browser.new(info[:release_uri]).open
      when :l then system("open #{info[:gem_path]} ")
      else raise UnknownEventError, package
      end
    rescue Bjt::Fetcher::NotFoundPackageError => e
      puts "[ERROR] not found this package: #{package}, please make sure this package installed"
    rescue Bjt::Jumper::UnknownEventError => e
      puts "[ERROR] unknown event: #{event}, support g s h l r c events"
    rescue StandardError => e
      puts "[ERROR] has error: #{e.message}"
    end

    private

    def info
      @info ||= Bjt::Fetcher.new(package).info
    end
  end
end
