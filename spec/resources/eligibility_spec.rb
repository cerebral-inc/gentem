RSpec.describe Gentem::Resources::Eligibility do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { 'eligibility/inquire' }
  let(:arguments) { [] }

  it_behaves_like 'a create action'
end
