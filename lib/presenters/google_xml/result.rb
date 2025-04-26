module Integrator
  module Presenters
    module GoogleXml
      class Result
        def initialize(response)
          @response = response
        end

        def output
          compile(@response)
        end

        private

        def compile(obj, deep = 0)
          str = ""
          if obj.respond_to?(:keys)
            obj.keys.each do |key|
              str += "#{"  " * deep}#{key}: #{obj[key].respond_to?(:keys) ? "\n" : ""}#{compile(obj[key], deep + 1)}"
            end
          else
            str += obj + "\n"
          end
          str
        end
      end
    end
  end
end
