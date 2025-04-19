require "erb"

module Integrator
  module Presenters
    module Openai
      class ChatResponse
        attr_reader :response, :status, :model, :usage, :text
        def initialize(response)
          @response = response
          parse_response
        end

        def output
          template = ERB.new(File.read(File.join(File.dirname(__FILE__), "chat_response.text.erb")))
          template.result(binding)
        end

        private

        def parse_response
          content = @response["output"].find { |output| output["type"] == "message" }["content"]
          @status = @response["status"]
          @model = @response["model"]
          @usage = @response["usage"]
          @text = content.find { |content| content["type"] == "output_text" }["text"]
        rescue => e
          puts "Something went wrong parsing response #{@response}. #{e.message}"
        end
      end
    end
  end
end
