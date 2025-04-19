require "json"

module Integrator
  module Clients
    class RestfulApiClient
      include HTTParty

      URL = "https://api.restful-api.dev/objects"
      HEADERS = {:Accept => "application/json", "Content-Type" => "application/json"}

      class << self
        def objects
          response = HTTParty.get(URL, headers: HEADERS)
          response.map do |o|
            Presenters::RestfulApi::Object.new(o["id"], o["name"], o["data"] || {})
          end
        end

        def object(id)
          response = HTTParty.get(URL + "/#{id}", headers: HEADERS)
          raise "Fetch failed: #{response.code}" if response.code != 200
          raise "Fetch Failed: #{response["error"]}" if response.key?("error")
          Presenters::RestfulApi::Object.new(response["id"], response["name"], response["data"])
        end

        def create_object(name, data)
          response = HTTParty.post(URL, headers: HEADERS, body: {name: name, data: data}.to_json)
          if response.success?
            puts "Successfully Created Object"
          else
            raise "Create Failed: #{response.code} - #{response["error"]}"
          end
          Presenters::RestfulApi::Object.new(response["id"], response["name"], response["data"])
        end

        def update_object(id, name, data)
          response = HTTParty.put(URL + "/#{id}", headers: HEADERS, body: {name: name, data: data}.to_json)
          if response.success?
            puts "Successfully Created Object"
          else
            raise "Create Failed: #{response.code} - #{response["error"]}"
          end
          Presenters::RestfulApi::Object.new(response["id"], response["name"], response["data"])
        end

        def update_name(id, name)
        end

        def delete_object(id)
        end
      end
    end
  end
end
