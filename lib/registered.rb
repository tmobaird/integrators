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
      description: "Interaction with the restful api",
      client: Clients::RestfulApiClient,
      actions: [:objects, :object, :create_object]
    }
  ]
end
