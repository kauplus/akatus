require 'singleton'

module Akatus

  def self.config
    Configuration.instance
  end

  class Configuration
    include Singleton

    attr_accessor :api_key, :email, :env, :sandbox

    def initialize

      @env = environment
      conf = File.exists?(config_file_path) ? YAML.load_file(config_file_path)[@env] : {}

      @sandbox  = conf['sandbox'] == true
      @api_key  = conf['api_key']
      @email    = conf['email']

    end

    def config_file_path
      "#{Dir.pwd}/config/akatus.yml"
    end

    def environment
      ENV['AKATUS_ENV'] || 'development'
    end

    def base_url
      sandbox ? 'https://sandbox.akatus.com/' : 'https://www.akatus.com/'
    end

    def api_url
      base_url + "api/v1/"
    end

  end

end
