module Gentem
  module Resources
    class Document < RestfulResource
      class FileError < StandardError; end
      
      public :list, :read

      def initialize(appointment_id)
        @appointment_id = appointment_id
      end
      
      def create(file)
        raise FileError.new('Must include an file to create a document') unless file
        raise FileError.new('File must be a file to creaate a document') unless file.respond_to?(:path) && file.respond_to?(:read)

        post(resource_base, { document: file, multipart: true })
      end

      private

      attr_reader :appointment_id

      def resource_base
        "appointments/#{appointment_id}/documents/"
      end
    end
  end
end
