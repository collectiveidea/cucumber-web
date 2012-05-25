module Cucumber
  module Web
    module Selectors
      class Proxy < ::Array
        def define(pattern, selector = nil, &block)
          unshift([pattern, selector || block])
        end

        alias_method :selector, :define
      end

      def selectors(&block)
        block_given? ? selectors_proxy.instance_eval(&block) : selectors_proxy
      end

      def selector(locator)
        selectors.detect do |pattern, selector|
          if pattern === locator
            if selector.is_a?(Proc)
              if pattern.is_a?(Regexp) && path.arity == 1
                match = pattern.match(locator)
                return selector.call(match)
              else
                return selector.call
              end
            else
              return selector
            end
          end
        end
      end

      private

      def selectors_proxy
        @selectors_proxy ||= Proxy.new
      end
    end
  end
end
