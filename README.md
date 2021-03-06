# Psenv

Shim to load environment variables from [AWS Systems Manager Parameter Store](https://aws.amazon.com/systems-manager/features/#Parameter_Store) into ENV.

Psenv currently heavily borrows from [Dotenv](https://github.com/bkeepers/dotenv), mainly because I use it in roughly every project so it made sense for the APIs to match.

## Installation

### Rails

Add this line to your application's Gemfile:

```ruby
gem 'psenv-rails'
```

And then execute:

    $ bundle

Set the `PARAMETER_STORE_PATH` environment variable with the AWS Parameter
Store path that you wish to load.

#### Spring preloader

The Spring preloader does not detect environment variable changes as
application changes.  This means that when using Spring, new or changed
environment variables from AWS SSM Parameter Store will not become available
immediately.  This also applies to any change to `PARAMETER_STORE_PATH`.

There are two work-arounds.  You can force Spring to restart by killing it with
`bundle exec spring stop`.

Alternatively, you can update your Spring configuration to reload variables
using Psenv after the process forks. To do this, add the following configuration
to `config/spring.rb`:

```
Spring.after_fork do
  Psenv.load
end
```

### Plain Ruby

Add this line to your application's Gemfile:

```ruby
gem 'psenv'
```

And then execute:

    $ bundle

Set the `PARAMETER_STORE_PATH` environment variable with the AWS Parameter
Store path that you wish to load.

Finally, trigger the loading:

```ruby
require 'psenv'
Psenv.load
```

## Usage

* Create a variable in parameter store using the AWS console or the CLI

```
aws ssm put-parameter \
	--name /psenv/test/API_KEY \
	--value "api_key_value" \
	--type String
```

* Ensure your application has at least the following IAM permissions
	* `ssm:GetParametersByPath` on resource `arn:aws:ssm:::parameter/psenv/test/*`
* Set the `PARAMETER_STORE_PATH` environment variable to `/psenv/test/`

This example will set the `API_KEY` to `api_key_value` and make it available to
your application.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/atomaka/psenv.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
