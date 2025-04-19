require "erb"

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
          template_file = File.join(File.dirname(__FILE__), "breed.text.erb")
          template = ERB.new(File.read(template_file))
          template.result(binding)
        end
      end
    end
  end
end
