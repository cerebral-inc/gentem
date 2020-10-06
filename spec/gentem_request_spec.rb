RSpec.describe Gentem::Request do
  before do
    ::Gentem.configure do |config|
      config.environment = :sandbox
    end

    stub_request(:post, /oauth.gentem.co/).
      to_return(
        body: { access_token: 'token' }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  describe '.ping?' do
    before do
      stub_request(:get, /ntegration.gentem.co/).
        to_return(
          body: 'Ping OK',
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    its(:ping?) { is_expected.to be_truthy }
  end
end
