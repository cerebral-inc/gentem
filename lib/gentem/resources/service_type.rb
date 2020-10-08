module Gentem
  module Resources
    class ServiceType < RestfulResource
      public :list, :read

      protected

      def resource_base
        'eligibility/service_type'
      end
    end
  end
end
