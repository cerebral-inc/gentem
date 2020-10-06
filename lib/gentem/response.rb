module Gentem

  ##
  # Gentem Response class
  #
  # Encapsulates a parsed json response from Gentem's API with methods
  # for things like HTTP status codes, etc.
  #

  class Response

    attr_reader :response
    delegate :body, :code, :message, :headers, :parsed_response, to: :response

    def initialize(response)
      @response = response
    end

    def success?
      [200, 201].include?(code)
    end

    def error?
      !success?
    end

    ##
    # Parsed response (e.g. Hash version of json received back)
    #

    def data
      parsed_response
    rescue JSON::ParserError
      # if the server sends an invalid response
      body
    end

  end

end
