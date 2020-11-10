module Gentem
  module Resources
    class Payment < RestfulResource
      public :list, :create, :read

      def initialize(appointment_id)
        @appointment_id = appointment_id
      end

      private

      attr_reader :appointment_id

      def resource_base
        "appointments/#{appointment_id}/patient_payments/"
      end
    end
  end
end
