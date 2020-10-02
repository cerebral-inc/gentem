require 'base64'
require 'httparty'

module Gentem

  ##
  # Gentem Client class
  #
  # Primarily used to differentiate between production vs sandbox environments.
  #

  class Client

    # [String] Oauth access token for accessing the Gentem API
    @@access_token = nil

    # [String] Oauth access token for accessing the Gentem API
    attr_accessor :access_token

    ##
    # Creates a new client which can be used to access the Gentem API.
    # 
    # Usage:
    #
    #   Get a fresh access token:
    #
    # client = Gentem::Client.new
    # access_token = client.fetch_access_token
    # client.access_token
    #  # => 'eyJraWQiOiJGZ ... hJnB7sQ'
    #
    # # The access token is now set as a class variable on the Client now too:
    # Gentem::Client.access_token
    #  # => 'eyJraWQiOiJGZ ... hJnB7sQ'
    #

    def initialize(opts = {})
      @access_token = opts[:access_token]
      @@access_token = access_token
    end

    ##
    # Gets a new access token from the Gentem OAuth provider
    #

    def fetch_access_token
      @access_token = self.class.fetch_access_token
    end

    def request
      Request.new(self)
    end

    ##
    # OAuth domain to use (based on environment setting)
    #

    def self.oauth_domain
      case Gentem.configuration.environment
      when :production
        'oauth.gentem.com'
      when :sandbox
        'oauth.gentem.co'
      end
    end

    def self.api_domain
      case Gentem.configuration.environment
      when :production
        'integration.gentem.com'
      when :sandbox
        'integration.gentem.co'
      end
    end

    def access_token
      @access_token || @@access_token
    end

    def self.fetch_access_token
      response = ::HTTParty.post(self.class.oauth_grant_url, { headers: oauth_headers })
      if response&.parsed_response.nil?
        raise GentemAuthError, "There was a problem obtaining a Gentem access token from: #{oauth_grant_url}"
      end
      if response.parsed_response['access_token']
        @@access_token = response.parsed_response['access_token']
        return @@access_token
      end
      # todo: error handling?
    end

    def self.credentials
      [Gentem.configuration.client_id, Gentem.configuration.client_secret].join(':')
    end

    def self.credentials_base64_encoded
      Base64.strict_encode64(self.class.credentials)
    end

    def self.oauth_grant_url
      "https://#{self.class.oauth_domain}/oauth2/token?grant_type=client_credentials"
    end

    def self.oauth_headers
      { 'Authorization' => "Basic #{self.class.credentials_base64_encoded}",
        'Content-Type' => 'application/x-www-form-urlencoded' }
    end

  end
end