require 'active_support/core_ext/module'

module Gentem

  class Request
    include HTTParty

    delegate :access_token, to: :authentication

    def get(path)
      perform_checks(path)
      url = build_url(path)
      response = send_authenticated(:get, url)
      Response.new(response)
    end

    def post(path, data)
      perform_checks(path)
      url = build_url(path)
      response = send_authenticated(__method__, url, data)
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
      response = self.class.public_send(
        method, url, { headers: headers, body: data.to_json }
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

    def build_path_with_params(path, params)
      [path, '/?', params.to_query].join
    end

    def build_url(path)
      ['https://', api_domain, '/api/', path].join
    end

    def headers
      { Authorization: access_token,
        'Content-Type': 'application/json' }
    end

    def perform_checks(path)
      if access_token.blank?
        raise ::Gentem::AccessTokenNotPresentError, "Gentem access token not present"
      end

      # path must:
      # * not be blank
      # * contain a path besides just "/"
      if path.blank? || path.gsub('/', '').empty?
        raise ::Gentem::InvalidApiUrlError "Gentem path passed appears invalid: #{path}"
      end
    end

  end

end
