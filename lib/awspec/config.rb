require 'singleton'

require 'awspec/error'

module Awspec
  class Config
    include Singleton

    def initialize
      @config = {
        client_backoff: 0.0,
        client_backoff_limit: 30.0,
        client_iteration: 1
        client_options: {
          #credentials: ENV['assume_role_arn'].nil? ? nil : role_credentials = Aws::AssumeRoleCredentials.new(role_arn: ENV['assume_role_arn'],role_session_name: "session"),
          #credentials: role_credentials,
          http_proxy: ENV['http_proxy'] || ENV['https_proxy'] || nil
        }
      }
    end

    def client_backoff(backoff)
      @config[:client_backoff] = backoff
    end

    def client_backoff_limit(backoff_limit)
      @config[:client_backoff_limit] = backoff_limit
    end

    def client_iteration(iteration)
      @config[:client_iteration] = iteration
    end

    def client_options(options)
      @config[:client_options] = options
    end

    def [](key)
      @config.fetch(key)
    end

    def method_missing(method_name, *_args)
      raise UnknownConfiguration, "'#{method_name}' is not a valid configuration for Awspec."
    end
  end

  def self.configure
    yield(Config.instance)
  end
end
