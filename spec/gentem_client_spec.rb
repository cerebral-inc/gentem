RSpec.describe Gentem::Client do

  it "has a .co base oauth domain for the sandbox" do
    Gentem.configure do |config|
      config.environment = :sandbox
    end
    expect(Gentem::Client.oauth_domain).to include('oauth.gentem.co')
  end

  it "has a .com base oauth domain for production" do
    Gentem.configure do |config|
      config.environment = :production
    end
    expect(Gentem::Client.oauth_domain).to include('oauth.gentem.com')
  end

  it "has gets an access token" do
    allow(Gentem::Client).to receive(:fetch_access_token).
      and_return('eyJraWQ...UKGrFDLYg')

    client = Gentem::Client.new
    expect(client.fetch_access_token).to include('eyJraWQ')
  end

end
