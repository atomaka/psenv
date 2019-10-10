# psenv-test

Used for testing the psenv-rails gem to validate.

## Usage

* Generate new parameter store variable in AWS
  * `/psenv/test/API_KEY` with value "api_key_value"
* `PARAMETER_STORE_PATH=/psenv/test bundle exec rails test`

## New Versions

To test new versions of the gem, you can install the psenv-rails gem locally and
reference it:

1. Clone psenv and complete work
    1. Likely updating Railtie requirements
1. Update psenv lib/psenv/version.rb
    1. Example version name: `0.5.16-local`
1. Run `bundle exec rake install` in psenv directory
1. Note new gem version installed locally
    1. Example gem version: `0.5.16.pre.local`
1. Open psenv-test project
1. Update Gemfile with test version
    1. `gem 'psenv-rails', '0.5.16.pre.local'`
    1. `bundle install`
1. `PARAMETER_STORE_PATH=/psenv/test bundle exec rails test`
