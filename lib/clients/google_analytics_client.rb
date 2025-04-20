require "jwt"

module Integrator
  module Clients
    class GoogleAnalyticsClient
      include HTTParty

      URL = "https://analyticsdata.googleapis.com/v1beta/properties/#{ENV["GOOGLE_ANALYTICS_PROPERTY_ID"]}:runReport"
      HEADERS = {:Accept => "application/json", "Content-Type" => "application/json"}

      class << self
        def metric(name: "main", expression: "eventCount/totalUsers", start_date: (Time.now - 60 * 60 * 24 * 7).strftime("%Y-%m-%d"), end_date: Time.now.strftime("%Y-%m-%d"))
          response = HTTParty.post(URL, headers: HEADERS.merge({Authorization: "Bearer #{token}"}), body: {
            date_ranges: [
              {startDate: start_date, endDate: end_date, name: "main"}
            ],
            metrics: [
              {name:, expression:}
            ]
          }.to_json)

          raise "Failed to fetch metrics #{response}" unless response.success?
          Presenters::GoogleAnalytics::Metric.new(response, name, expression)
        end

        def token
          service_account = JSON.parse(File.read(ENV["GOOGLE_OAUTH_CREDENTIALS_FILE_PATH"]))
          private_key = OpenSSL::PKey::RSA.new(service_account["private_key"])
          client_email = service_account["client_email"]
          jwt = JWT.encode({
            iss: client_email,
            scope: "https://www.googleapis.com/auth/analytics",
            aud: "https://oauth2.googleapis.com/token",
            exp: (Time.now + 60 * 20).to_i,
            iat: Time.now.to_i
          }, private_key, "RS256")
          response = HTTParty.post("https://oauth2.googleapis.com/token",
            headers: {"Content-Type" => "application/x-www-form-urlencoded"},
            body: {
              grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
              assertion: jwt
            })

          raise "Failed to fetch oauth token" unless response.success?

          response["access_token"]
        end
      end
    end
  end
end
