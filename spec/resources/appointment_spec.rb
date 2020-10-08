RSpec.describe Gentem::Resources::Appointment do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { 'appointments' }

  it_behaves_like 'a read action'
  it_behaves_like 'a list action'
  it_behaves_like 'a create action'
end
