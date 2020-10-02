module Gentem

  class Patients < Request
    attr_accessor :client

    def initialize(opts = {})
      super(opts)
    end

    def list
      get('/api/patients/')
    end

    def create(attributes)
      raise "not implemented"
    end

    def read(id)
      raise "not implemented"
    end

    # may not need to implement this one
    # def update(attributes)
    #   raise "not implemented"
    # end

    def partial_update(attributes)
      raise "not implemented"
    end

  end

end