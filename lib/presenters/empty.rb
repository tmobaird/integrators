module Integrator
  module Presenters
    class Empty
      def initialize(data)
        @data = data
      end

      def output
        @data.to_s
      end
    end
  end
end
