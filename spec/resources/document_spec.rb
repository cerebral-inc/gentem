RSpec.describe Gentem::Resources::Document do
  include_context 'with sandbox configuration'
  
  let(:resource_base_path) { "appointments/:appointment_id/service_lines/" }

  context 'Create A Document' do
    let(:appointment_id) { 'stringamajig' }

    before do
      response_body = {}.to_json      
      stub_request(:post, /oauth.gentem.co/).
        to_return(
          body: { access_token: 'token' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      stub_request(:post, %r{/api\/appointments\/#{appointment_id}\/documents/}).
        to_return(
          body: response_body,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    context "valid" do
      let(:file) {
        File.open(
          File.join(File.dirname(__FILE__), "../support/fixtures/dummy.pdf")
        )
      }

      subject(:response) { Gentem::Resources::Document.new(appointment_id).create(file) }

      its(:code) { is_expected.to eq(200) }
    end
    
    context "invalid file" do
      let(:file) { "File here" }

      it 'raises error' do
        expect { Gentem::Resources::Document.new(appointment_id).create(file) }.to raise_error(Gentem::Resources::Document::FileError)
      end
    end    
  end
end