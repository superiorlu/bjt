module Bjt
  class Fetcher
    class NotFoundPackageError < StandardError; end

    attr_reader :package

    def initialize(package)
      @package = package
    end

    def info
      @info ||= begin
        bundle_info = Bundler.rubygems.all_specs.detect { |spec| spec.name == package }
        raise NotFoundPackageError, package unless bundle_info

        {}.tap do |i|
          i[:name] = bundle_info.name
          i[:version] = bundle_info.version.to_s
          i[:homepage] = bundle_info.homepage
          i[:gem_path] = bundle_info.full_gem_path
          i[:source_code_uri] = bundle_info.metadata['source_code_uri'] || bundle_info.homepage
          i[:release_uri] = release_url(bundle_info.metadata['source_code_uri'], bundle_info.homepage)
          i[:source] = source_with(bundle_info.source).empty? ? 'https://rubygems.org' : source_with(bundle_info.source)
          i[:package_url] = package_with(i[:source])
        end
      end
    end

    private

    def source_with(source)
      @source ||= if source.is_a?(Bundler::Source::Rubygems)
                    source.remotes.last.to_s
                  elsif source.is_a?(Bundler::Source::Git)
                    source.uri
                  else
                    'https://rubygems.org'
                  end
    end

    def package_with(source)
      return source if source.end_with?('.git')

      source.end_with?('/') ? format('%sgems/%s', source, package) : format('%s/gems/%s', source, package)
    end

    def release_url(source, homepage)
      if source?(homepage)
        format('%s/releases', homepage)
      elsif source?(source)
        format('%s/releases', source)
      else
        homepage
      end
    end

    def source?(url)
      url =~ /github.com/ || url =~ /gitlab.com/
    end
  end
end
