RSpec.describe Gentem::Resources::IcdCode do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { 'icd_codes' }
  let(:arguments) { [] }

  it_behaves_like 'a list action'
end
