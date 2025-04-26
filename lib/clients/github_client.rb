require "debug"

module Integrator
  module Clients
    class GithubClient
      URL = "https://api.github.com/graphql"
      HEADERS = {:Authorization => "Bearer #{ENV["GITHUB_API_KEY"]}", :Accept => "application/json", "Content-Type" => "application/json"}
      YEAR = 60 * 60 * 24 * 365

      class << self
        def contributions(user, from: Time.now - YEAR, to: Time.now + (60 * 60 * 24))
          query = <<-GRAPHQL
          query {
            user(login: "#{user}") {
              contributionsCollection(from: "#{to_iso(from)}", to: "#{to_iso(to)}") {
                contributionCalendar {
                  weeks {
                    firstDay
                    contributionDays {
                      weekday
                      contributionCount
                    }
                  }
                }
              }
            }
          }
          GRAPHQL
          response = HTTParty.post(URL, headers: HEADERS, body: {query: query}.to_json)
          raise_unless_success(response)
          Presenters::Github::Contributions.new(response, from, to)
        end

        def to_iso(time)
          time.strftime("%Y-%m-%dT%H:%M:%S.%L%z")
        end
      end
    end
  end
end
