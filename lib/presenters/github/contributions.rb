module Integrator
  module Presenters
    module Github
      class Contributions
        COLORS = [7, 120, 34, 28]

        def initialize(response, from, to)
          @response = response
          @from = from
          @to = to
        end

        def output
          @contributions_chart = ""
          days.each do |row|
            row.each { |cell| @contributions_chart += colorize(cell) }
            @contributions_chart += "\n"
          end

          template_file = File.join(File.dirname(__FILE__), "contributions.text.erb")
          template = ERB.new(File.read(template_file), trim_mode: "<>")
          template.result(binding)
        end

        private

        def days
          days = Array.new(7) { [] }
          @response.dig("data", "user", "contributionsCollection", "contributionCalendar", "weeks").each do |week|
            if week["contributionDays"].first["weekday"] > 0
              week["contributionDays"].first["weekday"].times do |i|
                days[i].push(nil)
              end
            end
            week["contributionDays"].each do |day|
              days[day["weekday"]].push(day["contributionCount"])
            end
          end
          days
        end

        def color(value)
          case value
          when ..0
            COLORS[0]
          when 1..2
            COLORS[1]
          when 3..5
            COLORS[2]
          else
            COLORS[3]
          end
        end

        def colorize(value)
          "\033[48;5;#{color(value)}m  \033[0m"
        end
      end
    end
  end
end
