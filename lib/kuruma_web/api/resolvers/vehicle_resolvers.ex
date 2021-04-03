defmodule KurumaWeb.Api.Resolvers.VehicleResolvers do
  alias Kuruma.Vehicles

  def paginate_vehicles(args, _) do
    {:ok, Vehicles.paginate_vehicles(args)}
  end

  def get_vehicle(%{id: id}, _) do
    {:ok, Vehicles.get_vehicle!(id)}
  end
end
