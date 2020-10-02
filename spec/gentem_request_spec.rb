RSpec.describe Gentem::Request do

  it "has a ping method that returns string healthy when operational" do
    allow(Gentem::Client).to receive(:fetch_access_token).
      and_return('token')

    allow_any_instance_of(Gentem::Request).to receive(:build_url).
      and_return('https://integration.gentem.co/ping')

    allow(Gentem::Request).to receive(:get).
      and_return(
        instance_double(HTTParty::Response,
                         code: 200,
                         headers: {},
                         body: 'healthy',
                         parsed_response: 'healthy')
      )

    # client = Gentem::Client.new
    # request = Gentem::Request.new({client: client})
    request = Gentem::Request.new
    ping_response = request.ping
    expect(ping_response.data).to include('healthy')
  end

end
