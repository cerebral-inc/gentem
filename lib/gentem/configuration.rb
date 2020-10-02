module Gentem
  ##
  # Gentem Configuration class
  #

  class Configuration

    # [String] Environment to use - 'production' or 'sandbox'
    attr_accessor :environment
    # [String] OAuth Client ID (obtain from the Gentem portal)
    attr_accessor :client_id
    # [String] Oauth Client Secret (obtain from the Gentem portal)
    attr_accessor :client_secret

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

  end

end