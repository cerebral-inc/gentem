RSpec.describe Gentem::Resources::Patient do
  before do
    ::Gentem.configure do |config|
      config.environment = :sandbox
    end
  end

  context 'list patients - first result' do
    let(:params) { { page: 1, page_size: 20 } }
    let(:attributes) { {
      id: "497f6eca-6276-4993-bfeb-53cbbbba6f08",
      create_date: "2019-08-24T14:15:22Z",
      last_update_date: "2019-08-24T14:15:22Z",
      dob: "2000-08-24",
      first_name: "Matz",
      last_name: "Matsumoto",
      gender: "Male" }
    }

    subject { Gentem::Resources::Patient.new.list(params).data.first }

    before do
      response_body = [attributes].to_json

      stub_request(:get, %r{api\/patients}).
        to_return(
          body: response_body,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it { is_expected.to include( attributes ) }
  end

  context 'create a patient' do
    let(:attributes) { {
      dob: "2000-08-24",
      first_name: "Matz",
      last_name: "Matsumoto",
      gender: "Male" }
    }

    subject { Gentem::Resources::Patient.new.create(attributes).data }

    before do
      response_body = attributes.merge(id: "497f6eca-6276-4993-bfeb-53cbbbba6f08").
                        to_json

      stub_request(:post, %r{api\/patients}).
        to_return(
          body: response_body,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it { is_expected.to have_key(:id) }
    it { is_expected.to include(attributes) }
  end

  context 'read a patient' do
    let(:attributes) { {
      id: "497f6eca-6276-4993-bfeb-53cbbbba6f08",
      create_date: "2019-08-24T14:15:22Z",
      last_update_date: "2019-08-24T14:15:22Z",
      dob: "2000-08-24",
      first_name: "Matz",
      last_name: "Matsumoto",
      gender: "Male" }
    }

    subject { Gentem::Resources::Patient.new.read(attributes[:id]).data }

    before do
      response_body = attributes.to_json

      stub_request(:get, %r{api\/patients\/#{attributes[:id]}}).
        to_return(
          body: response_body,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it { is_expected.to include(attributes) }
  end

  context 'update partial a patient' do
    let(:id) { "497f6eca-6276-4993-bfeb-53cbbbba6f08" }

    let(:attributes) { {
      first_name: "Marty",
      last_name: "Mcfly" }
    }

    subject { Gentem::Resources::Patient.new.update(id, attributes).data }

    before do
      response_body = attributes.to_json

      stub_request(:patch, %r{api\/patients\/#{attributes[:id]}}).
        to_return(
          body: response_body,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it { is_expected.to include(attributes) }
  end

end
