module Integrator
  module Presenters
    module GoogleAnalytics
      class Metric
        def initialize(response, name, expression)
          @response = response
          @name = name
          @expression = expression
          parse
        end

        def output
          template_file = File.join(File.dirname(__FILE__), "metric.text.erb")
          template = ERB.new(File.read(template_file))
          template.result(binding)
        end

        private

        def parse
          @values = @response["rows"].find { |row| row.key? "metricValues" }["metricValues"].map { |v| v.values.first }
        end
      end
    end
  end
end
