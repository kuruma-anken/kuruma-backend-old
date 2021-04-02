defmodule Kuruma.Vehicles do
  @moduledoc """
  The Vehicles context.
  """

  import Ecto.Query, warn: false
  alias Kuruma.Repo

  alias Kuruma.Vehicles.Vehicle

  def list_vehicles do
    Repo.all(Vehicle)
  end

  def paginate_vehicles(args) do
    Vehicle
    |> Repo.paginate(args)
  end

  def get_vehicle!(id), do: Repo.get!(Vehicle, id)

  def create_vehicle(attrs \\ %{}) do
    %Vehicle{}
    |> Vehicle.changeset(attrs)
    |> Repo.insert()
  end

  def update_vehicle(%Vehicle{} = vehicle, attrs) do
    vehicle
    |> Vehicle.changeset(attrs)
    |> Repo.update()
  end

  def delete_vehicle(%Vehicle{} = vehicle) do
    Repo.delete(vehicle)
  end

  def change_vehicle(%Vehicle{} = vehicle, attrs \\ %{}) do
    Vehicle.changeset(vehicle, attrs)
  end
end
