module Cucumber
  module Web
    module Steps
      class Proxy < ::Array
        def define(pattern, proc = nil, &block)
          unshift([pattern, proc || block])
        end

        alias_method :step, :define

        %w(Given When Then And But).each do |method|
          alias_method method, :define
        end
      end

      def steps(&block)
        block_given? ? steps_proxy.instance_eval(&block) : steps_proxy
      end

      private

      def steps_proxy
        @steps_proxy ||= Proxy.new
      end
    end
  end
end
