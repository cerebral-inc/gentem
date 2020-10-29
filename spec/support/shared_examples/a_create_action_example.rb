RSpec.shared_examples_for 'a create action' do
  let(:attributes) do
    { field: 'value' }
  end

  arguments = described_class.instance_method(:initialize).arity

  if arguments.zero?
    subject(:response) { described_class.new.create(attributes) }
  else
    subject(:response) { described_class.new(*(1..arguments).to_a).create(attributes) }
  end

  before do
    response_body = attributes.merge(id: 'some_id').to_json
    request_path = Regexp.new(
      Regexp.escape("api/#{resource_base_path}")
    )

    stub_request(:post, request_path).
      with(body: attributes).
      to_return(
        status: 201,
        body: response_body,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  its(:code) { is_expected.to eq(201) }
  its(:data) { is_expected.to include(attributes) }
end
