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

    def list(params = {})
      path = path_with_params(resource_base, params)
      get(path)
    end

    # return the list of records from all pages, not the actual response
    def list_all(params = {})
      params_with_pagination =
        params.
        delete_if { |k, v| k.to_s.start_with?('page') }. # delete all previous pagination params
        merge(page_size: 1000) # set the maximum page size

      first_oage = get(params_with_pagination)

      results = first_page['results']
      (first_page['count'].to_i / 1000).times do |offset|
        page_data = get(params_with_pagination.merge(page: offest + 2))
        results += page_data['results']
      end

      results
    end

    def create(data)
      post(resource_base, data)
    end

    def read(id)
      get(resource_path(id))
    end

    def destroy(id)
      delete(resource_path(id))
    end

    def replace(id, data)
      put(resource_path(id), data)
    end

    def update(id, data)
      patch(resource_path(id), data)
    end

    def resource_base
      self.class.name.demodulize.underscore.pluralize
    end

    def resource_path(id)
      "#{resource_base}/#{id}/"
    end

    def path_with_params(path, params)
      [path, '/?', params.to_query].join
    end

  end

end
