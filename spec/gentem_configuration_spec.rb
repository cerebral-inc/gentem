RSpec.describe Gentem::Configuration do

  it "has an environment string" do

    Gentem.configure do |config|
      config.environment = 'sandbox'
    end

    expect(Gentem.configuration.environment).to eq(:sandbox)
  end

end

