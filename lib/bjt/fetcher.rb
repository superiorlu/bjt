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
          i[:release_uri] = release_uri_with(bundle_info.metadata['source_code_uri'], bundle_info.homepage)
          i[:source] = source_with(bundle_info.source).empty? ? 'https://rubygems.org' : source_with(bundle_info.source)
          i[:package_uri] = package_uri_with(i[:source], i[:version])
          i[:doc_uri] = bundle_info.metadata['documentation_uri'] || doc_uri_with(i[:source], i[:version])
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

    def package_uri_with(source, version)
      return source if source.end_with?('.git')

      package_uri = source.end_with?('/') ? format('%sgems/%s', source, package) : format('%s/gems/%s', source, package)
      package_uri.concat("/versions/#{version}") if version
      package_uri
    end

    def doc_uri_with(source, version)
      return source if source.end_with?('.git') && !github?(source)

      format('https://www.rubydoc.info/gems/%s/%s', package, version)
    end

    def release_uri_with(source, homepage)
      if github_or_gitlab?(homepage)
        format('%s/releases', homepage)
      elsif github_or_gitlab?(source)
        format('%s/releases', source)
      else
        homepage
      end
    end

    def github_or_gitlab?(url)
      github?(url) || gitlab?(url)
    end

    def github?(url)
      url =~ /github.com/
    end

    def gitlab?(url)
      url =~ /gitlab.com/
    end
  end
end
