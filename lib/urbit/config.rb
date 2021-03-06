require 'yaml'

module Urbit
  #  Injected into a Ship to provide configuration
  class Config
    attr_reader :code, :config_file, :host, :port, :name

    DEFAULT_CODE        = 'lidlut-tabwed-pillex-ridrup'.freeze
    DEFAULT_CONFIG_FILE = '_config.yml'.freeze
    DEFAULT_HOST        = 'http://localhost'.freeze
    DEFAULT_PORT        = '8080'.freeze
    DEFAULT_NAME        = '~zod'.freeze

    def initialize(code: nil,  config_file: nil, host: nil, name: nil, port: nil)
      @config_file = config_file || DEFAULT_CONFIG_FILE
      @code = code || loaded_config['code'] || DEFAULT_CODE
      @host = host || loaded_config['host'] || DEFAULT_HOST
      @name = name || loaded_config['ship'] || DEFAULT_NAME
      @port = port || loaded_config['port'] || DEFAULT_PORT
    end

    def api_base_url
      @api_base_url ||= "#{host}:#{port}"
    end

    private

    def loaded_config
      @loaded_config ||= begin
        return {} unless File.exist?(config_file)

        YAML.load_file(config_file)
      end
    end
  end
end
