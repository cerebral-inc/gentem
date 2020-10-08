RSpec.describe Gentem::Resources::Provider do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { 'providers' }

  it_behaves_like 'a read action'
  it_behaves_like 'a list action'
  it_behaves_like 'a create action'
  it_behaves_like 'a replace action'
  it_behaves_like 'an update action'

  context '.activate' do
    let(:provider_id) { 'some_id' }

    subject(:response) { described_class.new.activate(provider_id) }

    before do
      request_path = /api\/providers\/#{provider_id}\/activate/

      stub_request(:post, request_path)
    end

    its(:code) { is_expected.to eq(200) }
    its(:data) { is_expected.to be_blank }
  end
end
