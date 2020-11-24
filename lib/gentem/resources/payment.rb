module Gentem
  module Resources
    class Payment < RestfulResource
      public :list, :create, :read

      private

      def resource_base
        'patient_payments'
      end
    end
  end
end
