RSpec.describe Gentem::Resources::ServiceLine do
  include_context 'with sandbox configuration'

  let(:resource_base_path) { "appointments/appointment_id/service_lines/" }
  let(:arguments) { ['appointment_id'] }

  it_behaves_like 'a read action'
  it_behaves_like 'a list action'
  it_behaves_like 'a create action'
  it_behaves_like 'a replace action'
  it_behaves_like 'an update action'
  it_behaves_like 'a destroy action'
end
