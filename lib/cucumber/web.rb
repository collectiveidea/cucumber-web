require 'cucumber/web/paths'
require 'cucumber/web/selectors'
require 'cucumber/web/steps'

module Cucumber
  module Web
    extend Paths
    extend Selectors
    extend Steps
  end
end
