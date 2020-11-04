require 'active_support/core_ext/module'

module Gentem

  ##
  # Gentem Request class
  #
  # Represents an authenticated request to the Gentem API.
  #
  # Not used directly. RestfulResource inherits from this and implements the core, common
  # methods used by the API.
  #

  class Request
    include HTTParty
    debug_output

    delegate :access_token, to: :authentication

    def get(path)
      perform_checks(path)
      url = build_url(path)
      response = send_authenticated(__callee__, url)
      Response.new(response)
    end
    alias_method :delete, :get

    def post(path, data = {})
      perform_checks(path)
      url = build_url(path)
      response = send_authenticated(__callee__, url, data)
      Response.new(response)
    end
    alias_method :put, :post
    alias_method :patch, :post

    def ping?
      # there is also a /ping endpoint in the root namespace
      # and it response with "healthy"
      get('ping').data == 'Ping OK'
    rescue
      false
    end

    private

    def send_authenticated(method, url, data = {})
      options = if data[:multipart]
        { headers: headers(data), 
          body: data, # don't covert to json here for multipart because it messes with files.
          multipart: true }
      else
        { headers: headers(data), 
          body: data.to_json }
      end

      response = self.class.public_send(
        method, url, request_attrs
      )

      if response.code == 401
        if response.parsed_response['message'] == 'The incoming token has expired'
          authentication.refresh_access_token!
          send_authenticated(method, url, data)
        else
          raise ::Gentem::AuthError, 'The token is invalid and cannot be refreshed'
        end
      else
        response
      end
    end

    def authentication
      @authentication ||= Gentem::Authentication.new
    end

    def api_domain
      if Gentem.configuration.production?
        'integration.gentem.com'
      else
        'integration.gentem.co'
      end
    end

    def build_url(path)
      ['https://', api_domain, '/api/', path].join
    end

    JSON_CONTENT_TYPE = 'application/json'
    MULTIPART_CONTENT_TYPE = 'multipart/form-data'

    def headers(data = {})
      content_type = data[:multipart] ? MULTIPART_CONTENT_TYPE : JSON_CONTENT_TYPE
      { Authorization: access_token,
        'Content-Type': content_type }
    end

    def perform_checks(path)
      if access_token.blank?
        raise ::Gentem::AccessTokenNotPresentError, "Gentem access token not present"
      end

      # path must:
      # * not be blank
      # * contain a path besides just "/"
      if path.blank? || path.gsub('/', '').empty?
        raise ::Gentem::InvalidApiUrlError "Gentem API path passed appears invalid: #{path}"
      end
    end

  end

end
