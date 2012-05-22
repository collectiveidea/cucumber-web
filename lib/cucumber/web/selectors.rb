module Cucumber
  module Web
    module Selectors
      class Proxy < ::Array
        def define(pattern, selector = nil, &block)
          self << [pattern, selector || block]
        end
      end

      def selectors(&block)
        block_given? ? selectors_proxy.instance_eval(&block) : selectors_proxy
      end

      private

      def selectors_proxy
        @selectors_proxy ||= Proxy.new
      end
    end
  end
end
