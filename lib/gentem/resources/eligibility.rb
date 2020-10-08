module Gentem
  module Resources
    class Eligibility < RestfulResource
      public :create

      protected

      def resource_base
        'eligibility/inquire'
      end
    end
  end
end
