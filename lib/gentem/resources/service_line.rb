module Gentem
  module Resources
    class ServiceLine < RestfulRequest
      public :list, :create, :read, :replace, :update, :destroy

      def initialize(appointment_id)
        @appointment_id
      end

      def resource_base
        "appointments/#{@appointment_id}/service_lines/"
      end
    end
  end
end