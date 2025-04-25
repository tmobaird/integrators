module Integrator
  REGISTERED = [
    {
      name: "dog",
      description: "Get information about all the doggos!",
      client: Clients::DogApiClient,
      actions: [:breeds, :breed]
    },
    {
      name: "library",
      description: "Get information about your favorite books!",
      client: Clients::OpenLibraryClient,
      actions: [:authors]
    },
    {
      name: "restful",
      description: "Interaction with the restful API",
      client: Clients::RestfulApiClient,
      actions: [:objects, :object, :create_object, :update_object, :update_name, :delete_object]
    },
    {
      name: "openai",
      description: "Interact with the OpenAI APIs",
      client: Clients::OpenAiClient,
      actions: [:chat]
    },
    {
      name: "goog-analytics",
      description: "Interact with the Google Analytics APIs",
      client: Clients::GoogleAnalyticsClient,
      actions: [:metric]
    },
    {
      name: "github",
      description: "Interact with the Github API",
      client: Clients::GithubClient,
      actions: [:contributions]
    }
  ]
end
