RSpec.shared_examples_for 'a list action' do
  let(:attributes) do
    {
      id: "some_id",
      field: 'value'
    }
  end

  subject(:response) { described_class.new.list }

  before do
    response_body = {
      count: 1,
      results: [attributes]
    }.to_json
    request_path = Regexp.new(
      Regexp.escape("api/#{resource_base_path}")
    )

    stub_request(:get, request_path).
      to_return(
        body: response_body,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  its(:code) { is_expected.to eq(200) }
  its(:data) { is_expected.to be_present }
  it { expect(response.data['count']).to eq(1) }
  it { expect(response.data['results'].first).to include(attributes) }
end
