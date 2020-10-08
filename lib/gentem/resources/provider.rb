module Gentem
  module Resources
    class Provider < RestfulResource
      public :list, :create, :read, :replace, :update

      def activate(id)
        post(resource_path(id) + 'activate')
      end
    end
  end
end
