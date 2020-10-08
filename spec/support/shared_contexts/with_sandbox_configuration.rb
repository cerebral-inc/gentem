RSpec.shared_context 'with sandbox configuration' do
  before do
    ::Gentem.configure do |config|
      config.environment = :sandbox
    end
  end
end
