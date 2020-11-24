RSpec.shared_context 'with authentication' do
  let(:correct_access_token) { 'correct_token' }

  before do
    response_body = {
      access_token: correct_access_token,
      expires_in: 3600,
      token_type: 'Bearer'
    }.to_json

    stub_request(:post, /oauth.gentem.co/).
      to_return(
        body: response_body,
        headers: { 'Content-Type' => 'application/json' }
      )
  end
end
