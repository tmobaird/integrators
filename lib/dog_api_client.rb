require "httparty"

module Integrator
  class DogApiClient
    include HTTParty

    URL = "https://dogapi.dog/api/v2/breeds"

    class << self
      def breeds(page: 1)
        response = fetch_breeds(page)
        response.fetch("data", []).map do |breed|
          to_breed(breed)
        end
      end

      def breed(id)
        response = fetch_breed(id)
        to_breed(response["data"])
      end

      def headers
        {Accept: "application/json"}
      end

      def fetch_breeds(page)
        HTTParty.get(URL, headers: headers, query: {"page[number]" => page})
      end

      def fetch_breed(id)
        HTTParty.get("#{URL}/#{id}", headers: headers)
      end

      def to_breed(dog_data)
        Presenters::DogApi::Breed.new(
          {

            id: dog_data["id"],
            name: dog_data.dig("attributes", "name"),
            description: dog_data.dig("attributes", "description"),
            max_life: dog_data.dig("attributes", "life", "max"),
            min_life: dog_data.dig("attributes", "life", "min"),
            hypoallergenic: dog_data.dig("attributes", "hypoallergenic")
          }
        )
      end
    end
  end
end
