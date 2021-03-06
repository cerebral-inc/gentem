# order matters
require "gentem/authentication"
require "gentem/configuration"
require "gentem/request"
require "gentem/restful_resource"
require "gentem/response"
require "gentem/version"

resources_path = File.expand_path('gentem/resources/*.rb', File.dirname(__FILE__))
Dir[resources_path].each { |f| require f[/\/lib\/(.+)\.rb$/, 1] }

require 'active_support/core_ext/hash'

module Gentem

  class AuthError < StandardError; end
  class AccessTokenNotPresentError < StandardError; end
  class InvalidApiUrlError < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

end
