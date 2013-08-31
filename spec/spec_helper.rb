require "bundler"
Bundler.require :default, :development

require "hilbert"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    # Disable the `should` sytax...
    c.syntax = :expect
  end
end

