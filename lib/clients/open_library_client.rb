module Integrator
  module Clients
    class OpenLibraryClient
      include HTTParty

      URL = "https://openlibrary.org"

      class << self
        def authors(q = nil)
          query = {}
          query[:q] = q if q
          response = HTTParty.get("#{URL}/search/authors.json", query: query)
          response["docs"].map do |doc|
            Presenters::OpenLibrary::Author.new({
              name: doc["name"],
              birth_date: doc["birth_date"],
              top_subjects: doc.fetch("top_subjects", []),
              ratings_average: doc["ratings_average"],
              ratings_count: doc["ratings_count"]
            })
          end
        end
      end
    end
  end
end
