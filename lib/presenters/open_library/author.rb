require "debug"
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
          %(Name: #{@name}
Date of Birth: #{@birth_date}
Average Review: #{@ratings_average} / 5 #{"⭐️" * @ratings_average.floor}
No. of Reviews:  #{@ratings_count}
Top Subjects:
#{@top_subjects.map { |s| "- #{s}" }.join("\n")})
        end
      end
    end
  end
end
