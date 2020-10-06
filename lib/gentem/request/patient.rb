require 'active_support/core_ext/module'

module Gentem

  class Patient < Request

    def list(params)
      path = build_path_with_params('patients', params)
      get(path)
    end

    def create(data)
      post('patients', data)
    end

    def read(id)
      get(patient_path(id))
    end

    def update(id, data)
      put(patient_path(id), data)
    end

    def partial_update(id, data)
      patch(patient_path(id), data)
    end

    protected

    def patient_path(id)
      "patients/#{id}/"
    end

  end

end
