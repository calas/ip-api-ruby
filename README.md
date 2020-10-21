[![Gem Version](https://badge.fury.io/rb/ip_api.svg)](https://badge.fury.io/rb/ip_api) [![Build Status](https://travis-ci.com/calas/ip-api-ruby.svg?branch=main)](https://travis-ci.com/calas/ip-api-ruby) [![Maintainability](https://api.codeclimate.com/v1/badges/588099ff217ac668999d/maintainability)](https://codeclimate.com/github/calas/ip-api-ruby/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/588099ff217ac668999d/test_coverage)](https://codeclimate.com/github/calas/ip-api-ruby/test_coverage)

# IP API ruby client

This is `ip_api` gem, a ruby client for the IP API from https://ip-api.com. IP-API offers fast and secure IP geolocation data free for non-commercial use. No API key required. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ip_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ip_api

## Usage

The easiest way to use it is by calling the `info` method on the main module


```ruby
require 'ip_api'

IpApi.info('8.8.8.8')
=> {
 "status"=>"success",
 "country"=>"United States",
 "countryCode"=>"US",
 "region"=>"VA",
 "regionName"=>"Virginia",
 "city"=>"Ashburn",
 "zip"=>"20149",
 "lat"=>39.03,
 "lon"=>-77.5,
 "timezone"=>"America/New_York",
 "isp"=>"Google LLC",
 "org"=>"Google Public DNS",
 "as"=>"AS15169 Google LLC",
 "query"=>"8.8.8.8"
}
```

You can also request information for multiple IPs (100 max per request). 


```ruby
require 'ip_api'

IpApi.info(['8.8.8.8', '1.1.1.1'])
=> [
  {
    "status"=>"success",
    "country"=>"United States",
    "countryCode"=>"US",
    "region"=>"VA",
    "regionName"=>"Virginia",
    "city"=>"Ashburn",
    "zip"=>"20149",
    "lat"=>39.03,
    "lon"=>-77.5,
    "timezone"=>"America/New_York",
    "isp"=>"Google LLC",
    "org"=>"Google Public DNS",
    "as"=>"AS15169 Google LLC",
    "query"=>"8.8.8.8"
  },
  {
    "status"=>"success",
    "country"=>"Australia",
    "countryCode"=>"AU",
    "region"=>"QLD",
    "regionName"=>"Queensland",
    "city"=>"South Brisbane",
    "zip"=>"4101",
    "lat"=>-27.4766,
    "lon"=>153.0166,
    "timezone"=>"Australia/Brisbane",
    "isp"=>"Cloudflare, Inc",
    "org"=>"APNIC and Cloudflare DNS Resolver project",
    "as"=>"AS13335 Cloudflare, Inc.",
    "query"=>"1.1.1.1"
  }
]
```

### Response fields

ip-api.com allows specifying response fields, the complete list of possible fields can be found at https://ip-api.com/docs/api:json#fieldsTable

This gem automatically calculates a numeric value for the requested fields to save bandwidth. 

```ruby
IpApi.info('1.1.1.1', fields: ['country', 'proxy', 'hosting'])
=> {
  "country"=>"Australia", 
  "proxy"=>false, 
  "hosting"=>true
}
```

### Localization

Localized city, regionName and country can be requested by setting the `lang` option.

```ruby
IpApi.info('1.1.1.1', lang: 'ru')
=> {
  "status"=>"success",
  "country"=>"Австралия",
  "countryCode"=>"AU",
  "region"=>"QLD",
  "regionName"=>"Штат Квинсленд",
  "city"=>"South Brisbane",
  "zip"=>"4101",
  "lat"=>-27.4766,
  "lon"=>153.0166,
  "timezone"=>"Australia/Brisbane",
  "isp"=>"Cloudflare, Inc",
  "org"=>"APNIC and Cloudflare DNS Resolver project",
  "as"=>"AS13335 Cloudflare, Inc.",
  "query"=>"1.1.1.1"
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ip_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/calas/ip-api-ruby/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the IpApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/calas/ip-api-ruby/blob/main/CODE_OF_CONDUCT.md).
