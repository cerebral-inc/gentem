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
  config.environment = :sandbox
  config.client_id = 'YOUR-CLIENT-ID'
  config.client_secret = 'YOUR-CLIENT-SECRET'
end
```

Instantiate a new Gentem::Client object and obtain an access token:

```ruby
client = Gentem::Client.new
access_token = client.get_access_token
puts client.access_token
```

Access tokens are valid for 3600 seconds (60 minutes) as of this writing. You will need to obtain a new access token if the previous one has expired.

Test the API by hitting the /ping endpoint (continued from above example):

```ruby
client.request.ping
# => "pong"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cerebral-inc/gentem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
