module Gentem
  module Resources
    class Provider < RestfulResource
      public :list, :create, :read, :update, :partial_update

      def activate(id)
        post(resource_path(id) + 'activate')
      end
    end
  end
end
