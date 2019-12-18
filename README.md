# big_tin_can
This is a ruby gem for the Bigtincan Hub Public API

https://pubapi.bigtincan.com/doc/interactive/#/

## Install
```
gem 'big_tin_can', git: 'https://github.com/gbenedict/big_tin_can.git', branch: 'master'
```

## Requirements
* Ruby 2.3.0 or higher
* httparty

## Usage

```ruby
# retrieve an access token and refresh token
btc_services = BigTinCan::Service.new()
token_response = btc_services.get_access_token(@btc_client_id, @btc_client_secret, @btc_api_key)
access_token = token_response[:access_token]
refresh_token = token_response[:refresh_token]
```

```ruby
# refresh the access token. access tokens expire after 1 hour.
btc_services = BigTinCan::Service.new()
token_response = btc_services.refresh_access_token(@btc_client_id, @btc_client_secret, refresh_token)
access_token = token_response[:access_token]
refresh_token = token_response[:refresh_token]

```

```ruby
# get an array of the groups.
btc_group = BigTinCan::Group.new(access_token)
groups = btc_group.all
results = groups[:data]
```

```ruby
# get the first 100 stories. Options are passed as the last argument of the method. 
# See the official documentation for options.
btc_story = BigTinCan::Story.new(access_token)
stories = btc_story.all({channel_id: channel_id, limit: 100})
results = stories[:data]
```
