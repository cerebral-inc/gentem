require 'base64'
require 'httparty'

module Gentem

  ##
  # Gentem Client class
  #
  # Primarily used to differentiate between production vs sandbox environments.
  #

  class Authentication

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

    def access_token
      @access_token ||= persisted_token || fetch_access_token
    end

    def refresh_access_token
      @access_token = fetch_access_token
    end

    protected

    ##
    # OAuth domain to use (based on environment setting)
    #

    def oauth_domain
      if Gentem.configuration.production?
        'oauth.gentem.com'
      else
        'oauth.gentem.co'
      end
    end

    ##
    # Gets a new access token from the Gentem OAuth provider
    #

    def fetch_access_token
      response = ::HTTParty.post(oauth_grant_url, { headers: oauth_headers })
      new_token = response&.parsed_response&.fetch('access_token', nil)

      if new_token.nil?
        raise GentemAuthError, "There was a problem obtaining a Gentem access token from: #{oauth_grant_url}"
      end

      Gentem.configuration.persist_token&.call(new_token)
      new_token

      # todo: error handling?
    end

    def persisted_access_token
      Gentem.configuration.persisted_token&.call
    end

    def credentials
      [Gentem.configuration.client_id, Gentem.configuration.client_secret].join(':')
    end

    def credentials_base64_encoded
      Base64.strict_encode64(credentials)
    end

    def oauth_grant_url
      "https://#{oauth_domain}/oauth2/token?grant_type=client_credentials"
    end

    def oauth_headers
      { 'Authorization' => "Basic #{credentials_base64_encoded}",
        'Content-Type' => 'application/x-www-form-urlencoded' }
    end

  end
end
