RSpec.describe Gentem::Resources::ServiceLine do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { "appointments/:appointment_id/service_lines/" }

  it_behaves_like 'a read action'
  it_behaves_like 'a list action'
  it_behaves_like 'a create action'
  it_behaves_like 'a replace action'
  it_behaves_like 'an update action'
  it_behaves_like 'a destroy action'

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