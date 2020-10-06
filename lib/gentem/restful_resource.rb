module Gentem

  ##
  # Gentem RestfulResource class
  #
  # Resource classes should inherit from this class. Defines core methods like list, create, read, update
  # that can then be used by the subclasses by making the applicable methods available.
  #
  # For non-standard naming convention routes, subclasses should override the "resource_base" method.
  #
  # Example:
  #
  # class ServiceLine < RestfulRequest
  #   def initialize(appointment_id)
  #     @appointment_id
  #   end
  #
  #   def resource_base
  #     "appointments/#{@appointment_id}/service_lines/"
  #   end
  # end
  #

  class RestfulResource < Request

    protected

    def list(params)
      path = path_with_params(resource_base, params)
      get(path)
    end

    def create(data)
      post(resource_base, data)
    end

    def read(id)
      get(resource_path(id))
    end

    def update(id, data)
      put(resource_path(id), data)
    end

    def partial_update(id, data)
      patch(resource_path(id), data)
    end

    def resource_base
      stripped_class = self.class.name.gsub('Gentem::', '').gsub('Resources::', '')
      stripped_class.underscore.pluralize
    end

    def resource_path(id)
      "#{resource_base}/#{id}/"
    end

    def path_with_params(path, params)
      [path, '/?', params.to_query].join
    end

  end

end
