module Gentem
  ##
  # Gentem Configuration class
  #

  class Configuration

    # [String] Environment to use - 'production' or 'sandbox'
    attr_reader :environment
    # [String] OAuth Client ID (obtain from the Gentem portal)
    attr_accessor :client_id
    # [String] Oauth Client Secret (obtain from the Gentem portal)
    attr_accessor :client_secret
    # [Block] Method to fetch a persisted OAuth token
    attr_reader :persisted_token
    # [Block] Method to save a new OAuth token
    attr_reader :persist_token

    def initialize
      # default to sandbox environment
      @environment = :sandbox
    end

    def production?
      environment == :production
    end

    def sandbox?
      environment == :sandbox
    end

    def environment=(environment = :sandbox)
      @environment = environment.to_sym
    end

    def persisted_token=(&block)
      @persisted_token = block if block_given? && block.arity == 0
    end

    def persist_token=(&block)
      @persist_token = block if block_given? && block.arity == 1
    end

  end

end
