require 'singleton'

module Akatus

  def self.configuracao
    Configuracao.instance
  end

  #
  # Private.
  #
  private

  class Configuracao
    include Singleton

    attr_accessor :env, :sandbox, :url_carrinho

    #
    # Private methods.
    #
    private

    def initialize
      if defined? Rails
        path = "#{Rails.root}/config/akatus.yml"
        self.env = Rails.env
      else
        path = "#{Dir.pwd}/config/akatus.yml"
        self.env = ENV['AKATUS_ENV'] || 'development'
      end
      conf = File.exists?(path) ? YAML.load_file(path)[self.env] : {}

      self.sandbox = conf['sandbox'].present? && conf['sandbox'] == true
      self.url_carrinho = self.sandbox ? 'https://dev.akatus.com/carrinho/' : 'https://www.akatus.com/carrinho/'
    end

  end

end