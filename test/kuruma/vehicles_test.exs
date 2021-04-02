defmodule Kuruma.VehiclesTest do
  use Kuruma.DataCase

  alias Kuruma.Vehicles

  describe "vehicles" do
    alias Kuruma.Vehicles.Vehicle

    @valid_attrs %{manufacturing_year: 42, registration: "some registration"}
    @update_attrs %{manufacturing_year: 43, registration: "some updated registration"}
    @invalid_attrs %{manufacturing_year: nil, registration: nil}

    def vehicle_fixture(attrs \\ %{}) do
      {:ok, vehicle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vehicles.create_vehicle()

      vehicle
    end

    test "list_vehicles/0 returns all vehicles" do
      vehicle = vehicle_fixture()
      assert Vehicles.list_vehicles() == [vehicle]
    end

    test "get_vehicle!/1 returns the vehicle with given id" do
      vehicle = vehicle_fixture()
      assert Vehicles.get_vehicle!(vehicle.id) == vehicle
    end

    test "create_vehicle/1 with valid data creates a vehicle" do
      assert {:ok, %Vehicle{} = vehicle} = Vehicles.create_vehicle(@valid_attrs)
      assert vehicle.manufacturing_year == 42
      assert vehicle.registration == "some registration"
    end

    test "create_vehicle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicles.create_vehicle(@invalid_attrs)
    end

    test "update_vehicle/2 with valid data updates the vehicle" do
      vehicle = vehicle_fixture()
      assert {:ok, %Vehicle{} = vehicle} = Vehicles.update_vehicle(vehicle, @update_attrs)
      assert vehicle.manufacturing_year == 43
      assert vehicle.registration == "some updated registration"
    end

    test "update_vehicle/2 with invalid data returns error changeset" do
      vehicle = vehicle_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicles.update_vehicle(vehicle, @invalid_attrs)
      assert vehicle == Vehicles.get_vehicle!(vehicle.id)
    end

    test "delete_vehicle/1 deletes the vehicle" do
      vehicle = vehicle_fixture()
      assert {:ok, %Vehicle{}} = Vehicles.delete_vehicle(vehicle)
      assert_raise Ecto.NoResultsError, fn -> Vehicles.get_vehicle!(vehicle.id) end
    end

    test "change_vehicle/1 returns a vehicle changeset" do
      vehicle = vehicle_fixture()
      assert %Ecto.Changeset{} = Vehicles.change_vehicle(vehicle)
    end
  end
end
