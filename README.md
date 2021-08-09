# README

# Getting started

Find the following code in /config/application.rb and set `config.username` and `config.password` to your Client ID and API Key from the MX Docs respectively (see [MXPlatformRuby Readme](https://github.com/mxenabled/mx-platform-ruby)):

```
::MXPlatformRuby.configure do |config|
  config.username = 'Client ID'
  config.password = 'API Key'
  config.base_url = 'https://int-api.mx.com' # in production, use 'https://api.mx.com'
end
```

Install bundler and run `bundle install`

TODO: describe db setup
Setup up db
