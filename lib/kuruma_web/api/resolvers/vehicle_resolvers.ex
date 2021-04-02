defmodule KurumaWeb.Api.Resolvers.VehicleResolvers do
  alias Kuruma.Vehicles

  def paginate_vehicles(args, _) do
    {:ok, Vehicles.paginate_vehicles(args)}
  end
end
