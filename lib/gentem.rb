# order matters
require "gentem/client"
require "gentem/configuration"
require "gentem/request"
require "gentem/patients"
require "gentem/response"
require "gentem/version"

require 'active_support/core_ext/hash'

module Gentem

  class GentemAuthError < StandardError; end
  class GentemAccessTokenNotPresentError < StandardError; end
  class GentemInvalidApiUrlError < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

end
