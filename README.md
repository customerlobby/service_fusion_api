# ServiceFusionApi

A Ruby wrapper for the Service Fusion REST API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'service_fusion_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install service_fusion_api

## Usage

### Configuration

Before you can make calls to ServiceFusionApi you must configure the library with a valid OAuth access token.

There are two ways to configure the  gem. You can pass a hash of configuration options when you create
a client, or you can use a configure block.

Using an OAuth access token:
```ruby
client = ServiceFusionApi.client(access_token: "YOUR_ACCESS_TOKEN_HERE")
```

Using OAuth access token
```ruby
ServiceFusionApi.configure do |config|
  config.access_token = 'ACCESS_TOKEN'
end
```

Create ServiceFusionApi client
```ruby
client = ServiceFusionApi.client
```

### Get customers

get all the customers
```ruby
client.customers
```
get specific customer details
```ruby
client.customer('id')
```
Use offset for pagination
 ```ruby
client.customers(page: 1)
```
filter customers by date
```ruby
client.customers('last_serviced_date[:gte]': '2019-01-20')
```

### Get transactions

get all the transactions
```ruby
client.transactions
```
get specific transaction details
```ruby
client.transaction('id')
```
User offset for pagination
```ruby
client.transactions(offset: 1)
```
filter transactions by date
```ruby
client.transactions('end_date[:gte]': '2019-01-20')
```

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
