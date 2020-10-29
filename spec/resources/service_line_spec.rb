RSpec.describe Gentem::Resources::ServiceLine do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { "appointments/:appointment_id/service_lines/" }

  context 'Create A Service Line' do

    let(:appointment_id) { 'stringamajig' }

    let(:attributes) { {
      test: "Test" }
    }

    subject(:response) { Gentem::Resources::ServiceLine.new(appointment_id).create(attributes) }

    before do
      response_body = attributes.merge(id: "497f6eca-6276-4993-bfeb-53cbbbba6f08").to_json

      stub_request(:post, %r{/api\/appointments\/#{appointment_id}\/service_lines/}).
        to_return(
          body: response_body,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    its(:code) { is_expected.to eq(200) }
  end
end