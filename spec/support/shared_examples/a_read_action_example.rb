RSpec.shared_examples_for 'a read action' do
  include_context 'with authentication'

  let(:attributes) do
    {
      id: "some_id",
      field: 'value'
    }
  end

  subject(:response) { described_class.new(*arguments).read(attributes[:id]) }

  before do
    request_path = Regexp.new(
      Regexp.escape("api/#{resource_base_path}/#{attributes[:id]}")
    )

    stub_request(:get, request_path).
      to_return(
        body: attributes.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  its(:code) { is_expected.to eq(200) }
  its(:data) { is_expected.to include(attributes) }
end
