module Integrator
  module Presenters
    module DogApi
      class Breed
        attr_reader :id, :name, :description, :max_life, :min_life, :hypoallergenic

        def initialize(data)
          @id = data[:id]
          @name = data[:name]
          @description = data[:description]
          @max_life = data[:max_life]
          @min_life = data[:min_life]
          @hypoallergenic = data[:hypoallergenic]
        end

        def output
          %(Breed: #{@name} (#{@id})
#{@description}

Lifespan: #{@min_life} - #{@max_life}
Hypoallergenic: #{@hypoallergenic ? "Yes" : "No"})
        end
      end
    end
  end
end
