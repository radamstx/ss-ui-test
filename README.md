# Ss::Ui::Test

This gem's purpose is for demonstrating knowledge of ui testing for an Interview Code Challenge

Author: Robert Adams <r.adams.tx@gmail.com>

## Usage

You will need Ruby 2.5.1 installed. I recommend using rbenv for a Ruby environment manager.
You will need Bundler version at least 1.16 installed.

    $ gem install bundler -v 1.16.1

### Install Dependencies

To install dependencies, from within the project's root, you will need to run:

    $ bundle install

### Start Docker Container

You will need to install docker to be able to start up the Chrome docker image.
See: https://www.docker.com

To start up chrome docker container for testing, from within the project's root, 
you will need to run:

    $ ./bin/chrome.sh

#### Troubleshooting

You may have the default port, 5900, in use. You'll know because the chrome container fails to 
start up. If this occurs, set `VNC_PORT` to an available port.

### Running Tests

#### Command line

NOTE: This will require having the rake gem installed. I'm currenly using 12.3.0. If you need
to install it:

    $ gem install rake

To run tests, you may either, from the command line, within the project's root, run:

    $ rake spec

#### IDE
    
Or, create a run configuration in the IDE of your choice (i.e. RubyMine), and select
RSpec as the test runner and Bundler as being used to package the project.

### Watching Tests

You may watch the tests from any vnc viewer by directing your vnc viewer to: `localhost:5900`,
or if you had to override `VNC_PORT`, `localhost:VNC_PORT`. The password you will need to enter is
"secret".

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ss-ui-test'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ss-ui-test

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/radamstx/ss-ui-test.
