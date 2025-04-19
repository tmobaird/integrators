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
    }
  ]
end
