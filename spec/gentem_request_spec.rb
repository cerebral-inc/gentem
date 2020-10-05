RSpec.describe Gentem::Request do

  xit "has a ping method that returns string healthy when operational" do
    request = Gentem::Request.new
    ping_response = request.ping
    expect(ping_response.data).to include('healthy')
  end

end
