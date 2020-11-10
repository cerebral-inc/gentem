RSpec.shared_examples_for 'a replace action' do
  include_context 'with authentication'

  let(:attributes) do
    {
      id: "some_id",
      field: 'value'
    }
  end

  subject(:response) do
    described_class.new(*arguments).replace(attributes[:id], attributes)
  end

  before do
    request_path = Regexp.new(
      Regexp.escape("api/#{resource_base_path}/#{attributes[:id]}")
    )

    stub_request(:put, request_path).
      with(body: attributes).
      to_return(
        body: attributes.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  its(:code) { is_expected.to eq(200) }
  its(:data) { is_expected.to include(attributes) }
end
