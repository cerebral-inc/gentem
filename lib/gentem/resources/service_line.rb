module Gentem
  module Resources
    class ServiceLine < RestfulResource
      public :list, :create, :read, :replace, :update, :destroy

      def initialize(appointment_id)
        @appointment_id = appointment_id
      end

      private

      attr_reader :appointment_id

      def resource_base
        "appointments/#{appointment_id}/service_lines/"
      end
    end
  end
end