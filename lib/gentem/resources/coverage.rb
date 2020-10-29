module Gentem
  module Resources
    class Coverage < RestfulResource
      public :list, :create, :read, :replace, :update

      attr_reader :patient_id
      private :patient_id

      def initialize(patient_id)
        @patient_id = patient_id
      end

      protected

      def resource_base
        "patients/#{patient_id}/insurance_coverages"
      end
    end
  end
end
