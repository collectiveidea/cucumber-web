require 'cucumber/web'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each{|f| require f }

RSpec.configure do |config|
  config.after do
    Cucumber::Web.instance_variable_set(:@paths_proxy, nil)
    Cucumber::Web.instance_variable_set(:@selectors_proxy, nil)
  end
end
