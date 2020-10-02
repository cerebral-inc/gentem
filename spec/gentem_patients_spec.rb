RSpec.describe Gentem::Patients do

  it "has a list method" do
    allow_any_instance_of(Gentem::Client).to receive(:access_token).
      and_return('token')

    allow_any_instance_of(Gentem::Patients).to receive(:get).
      and_return(
        instance_double(Gentem::Response,
                         code: 200,
                         headers: {},
                         body: '{"count"=>0, "next"=>nil, "previous"=>nil, "results"=>[]}',
                         data: {"count"=>0, "next"=>nil, "previous"=>nil, "results"=>[]}.with_indifferent_access)
      )

    patients = Gentem::Patients.new
    response = patients.list

    expect(response.data).to be_a(Hash)
    expect(response.data[:count]).to eq(0)
    expect(response.data[:next]).to be_nil
    expect(response.data[:results]).to be_empty
  end

end
