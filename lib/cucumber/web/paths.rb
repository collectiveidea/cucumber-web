module Cucumber
  module Web
    module Paths
      class Proxy < ::Array
        def define(pattern, path = nil, &block)
          unshift([pattern, path || block])
        end
      end

      def paths(&block)
        block_given? ? paths_proxy.instance_eval(&block) : paths_proxy
      end

      def path(page_name)
        paths.detect do |pattern, path|
          return path if pattern === page_name
        end
      end

      private

      def paths_proxy
        @paths_proxy ||= Proxy.new
      end
    end
  end
end
