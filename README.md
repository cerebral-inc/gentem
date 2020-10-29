# Gentem

A ruby gem for the Gentem API.

Gentem API documentation: https://api.gentem.com/public/developer/documentation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gentem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gentem

## Usage

First configure the environment and credentials.

In a rails app, this might go in `config/initializers/gentem.rb` for example.

```ruby
Gentem.configure do |config|
  config.environment = Rails.env.production? ? :production : :sandbox
  config.client_id = ENV['GENTEM_CLIENT_ID']
  config.client_secret = ENV['GENTEM_CLIENT_SECRET']
  config.persist_token = lambda do |value|
    Rails.cache.write("gentem_access_token", value)
  end
  config.persisted_token = lambda do
    Rails.cache.read("gentem_access_token")
  end
end
```

Access tokens are valid for 3600 seconds (60 minutes) as of this writing. You will need to obtain a new access token if the previous one has expired.

Test the API by hitting the /ping endpoint (continued from above example):

```ruby
Gentem::Request.new.ping?
# => true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cerebral-inc/gentem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
