module Integrator
  module Clients
    class GoogleXmlClient
      include HTTParty

      URL = "https://mocktarget.apigee.net/xml"
      HEADERS = {Accept: "application/xml"}

      class << self
        def xml
          response = HTTParty.get(URL, headers: HEADERS)
          raise_unless_success(response)
          Presenters::GoogleXml::Result.new(response)
        end
      end
    end
  end
end
