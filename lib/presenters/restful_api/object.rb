module Integrator
  module Presenters
    module RestfulApi
      class Object
        attr_reader :id, :name, :data

        def initialize(id, name, data)
          @id = id
          @name = name
          @data = data
        end

        def output
          %(Name: #{@name} \(id: #{@id}\)
          #{@data.map { |k, v| "- #{k}: #{v}" }.join("\n")})
        end
      end
    end
  end
end
