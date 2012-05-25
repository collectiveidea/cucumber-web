module Cucumber
  module Web
    module Paths
      class Proxy < ::Array
        def define(pattern, path = nil, &block)
          unshift([pattern, path || block])
        end

        alias_method :path, :define
      end

      def paths(&block)
        block_given? ? paths_proxy.instance_eval(&block) : paths_proxy
      end

      def path(page_name)
        paths.detect do |pattern, path|
          if pattern === page_name
            if path.is_a?(Proc)
              if pattern.is_a?(Regexp) && path.arity == 1
                match = pattern.match(page_name)
                return path.call(match)
              else
                return path.call
              end
            else
              return path
            end
          end
        end
      end

      private

      def paths_proxy
        @paths_proxy ||= Proxy.new
      end
    end
  end
end
