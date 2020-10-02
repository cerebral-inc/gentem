module Gentem

  ##
  # Gentem Response class
  #
  # Encapsulates a parsed json response from Gentem's API with methods
  # for things like HTTP status codes, etc.
  #

  class Response

    attr_reader :body
    attr_reader :code
    attr_reader :message
    attr_reader :headers
    attr_reader :parsed_response

    def initialize(response)
      @body = response.body
      @code = response.code
      @headers = response.headers
      @parsed_response = response.parsed_response
      return if error?
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
    end

  end

end
