defmodule Kuruma.ImagesTest do
  use Kuruma.DataCase

  alias Kuruma.Images

  describe "vehicle_images" do
    alias Kuruma.Images.VehicleImage

    @valid_attrs %{position: 42, url: "some url"}
    @update_attrs %{position: 43, url: "some updated url"}
    @invalid_attrs %{position: nil, url: nil}

    def vehicle_image_fixture(attrs \\ %{}) do
      {:ok, vehicle_image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Images.create_vehicle_image()

      vehicle_image
    end

    test "list_vehicle_images/0 returns all vehicle_images" do
      vehicle_image = vehicle_image_fixture()
      assert Images.list_vehicle_images() == [vehicle_image]
    end

    test "get_vehicle_image!/1 returns the vehicle_image with given id" do
      vehicle_image = vehicle_image_fixture()
      assert Images.get_vehicle_image!(vehicle_image.id) == vehicle_image
    end

    test "create_vehicle_image/1 with valid data creates a vehicle_image" do
      assert {:ok, %VehicleImage{} = vehicle_image} = Images.create_vehicle_image(@valid_attrs)
      assert vehicle_image.position == 42
      assert vehicle_image.url == "some url"
    end

    test "create_vehicle_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Images.create_vehicle_image(@invalid_attrs)
    end

    test "update_vehicle_image/2 with valid data updates the vehicle_image" do
      vehicle_image = vehicle_image_fixture()
      assert {:ok, %VehicleImage{} = vehicle_image} = Images.update_vehicle_image(vehicle_image, @update_attrs)
      assert vehicle_image.position == 43
      assert vehicle_image.url == "some updated url"
    end

    test "update_vehicle_image/2 with invalid data returns error changeset" do
      vehicle_image = vehicle_image_fixture()
      assert {:error, %Ecto.Changeset{}} = Images.update_vehicle_image(vehicle_image, @invalid_attrs)
      assert vehicle_image == Images.get_vehicle_image!(vehicle_image.id)
    end

    test "delete_vehicle_image/1 deletes the vehicle_image" do
      vehicle_image = vehicle_image_fixture()
      assert {:ok, %VehicleImage{}} = Images.delete_vehicle_image(vehicle_image)
      assert_raise Ecto.NoResultsError, fn -> Images.get_vehicle_image!(vehicle_image.id) end
    end

    test "change_vehicle_image/1 returns a vehicle_image changeset" do
      vehicle_image = vehicle_image_fixture()
      assert %Ecto.Changeset{} = Images.change_vehicle_image(vehicle_image)
    end
  end
end
