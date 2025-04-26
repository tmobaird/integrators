module Integrator
  module Clients
    class OpenAiClient
      include HTTParty

      URL = "https://api.openai.com/v1"
      HEADERS = {:Accept => "application/json", "Content-Type" => "application/json", :Authorization => "Bearer #{ENV["OPENAI_API_KEY"]}"}

      class << self
        def chat(prompt)
          response = HTTParty.post(URL + "/responses", headers: HEADERS, body: {model: "o3-mini", input: prompt}.to_json)
          raise_unless_success(response)
          Presenters::Openai::ChatResponse.new(response)
        end
      end
    end
  end
end
