RSpec.describe Gentem::Resources::ServiceType do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { 'eligibility/service_type' }

  it_behaves_like 'a read action'
  it_behaves_like 'a list action'
end
