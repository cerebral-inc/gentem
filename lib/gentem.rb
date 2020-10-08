# order matters
require "gentem/authentication"
require "gentem/configuration"
require "gentem/request"
require "gentem/restful_resource"
require "gentem/response"
require "gentem/version"

Dir['lib/gentem/resources/*.rb'].each { |f| require f.gsub(/^lib\//, '') }

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
