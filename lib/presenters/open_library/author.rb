require "erb"

module Integrator
  module Presenters
    module OpenLibrary
      class Author
        attr_reader :name, :birth_date, :top_subjects, :ratings_average, :ratings_count

        def initialize(data)
          @name = data[:name]
          @birth_date = data[:birth_date]
          @top_subjects = data[:top_subjects]
          @ratings_average = data[:ratings_average]
          @ratings_count = data[:ratings_count]
        end

        def output
          template_file = File.join(File.dirname(__FILE__), "author.text.erb")
          template = ERB.new(File.read(template_file), trim_mode: "<>")
          template.result(binding)
        end
      end
    end
  end
end
