module Gentem

  class Request
    include HTTParty
    attr_accessor :client

    def initialize(opts = {} )
      @client = opts[:client] || Gentem::Client.new
    end

    def get(path)
      perform_checks(path)
      url = build_url(path)
      response = self.class.get(url, { headers: headers })
      Response.new(response)
    end

    def post(path, data)
      perform_checks(path)
      url = build_url(path)
      response = self.class.post(url, { headers: headers,
                                      body: data.to_json })
      Response.new(response)
    end

    def ping
      get('/ping')
    end

    private

    def build_url(path)
      ['https://', client.api_domain, path].join
    end

    def access_token
      @client.access_token || Gentem::Client.access_token || Gentem::Client.fetch_access_token
    end

    def headers
      { Authorization: access_token,
        'Content-Type': 'application/json' }
    end

    def perform_checks(path)
      if client.access_token.nil? || client.access_token.empty?
        raise GentemAccessTokenNotPresentError, "Gentem access token not present"
      end

      # path must:
      # * not be blank
      # * start with a "/"
      # * contain a path besides just "/"
      if path.nil? || path.empty? || (path.slice(0,1) != '/') || path.gsub('/', '').empty?
        raise GentemInvalidApiUrlError "Gentem path passed appears invalid: #{path}"
      end
    end

  end

end