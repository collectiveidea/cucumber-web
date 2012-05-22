module Cucumber
  module Web
    module Paths
      class Proxy < ::Array
        def define(pattern, path = nil, &block)
          self << [pattern, path || block]
        end
      end

      def paths(&block)
        block_given? ? paths_proxy.instance_eval(&block) : paths_proxy
      end

      private

      def paths_proxy
        @paths_proxy ||= Proxy.new
      end
    end
  end
end
