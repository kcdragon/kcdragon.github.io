module Jekyll
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      site.config['env'] = ENV['RACK_ENV'] || 'development'
    end
  end
end
