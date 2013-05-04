# Fip

A Ruby gem that wraps Find my iPhone API. At first, only the location discovery feature is implemented

## Installation

Add this line to your application's Gemfile:

    gem 'fip'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fip

## Usage

    require "fip"

    fip = Fip.new("your@appleid.email.com", "yourAppleIDPassword")
    fip.locate

    # {"latitude"=>-3.729970429962879, 
    #   "longitude"=>-38.4906177200629, 
    #   "accuracy"=>65.0, 
    #   "timestamp"=>1367639191501}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
