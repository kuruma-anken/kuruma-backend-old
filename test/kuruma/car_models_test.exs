defmodule Kuruma.CarModelsTest do
  use Kuruma.DataCase

  alias Kuruma.CarModels

  describe "car_models" do
    alias Kuruma.CarModels.CarModel

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def car_model_fixture(attrs \\ %{}) do
      {:ok, car_model} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CarModels.create_car_model()

      car_model
    end

    test "list_car_models/0 returns all car_models" do
      car_model = car_model_fixture()
      assert CarModels.list_car_models() == [car_model]
    end

    test "get_car_model!/1 returns the car_model with given id" do
      car_model = car_model_fixture()
      assert CarModels.get_car_model!(car_model.id) == car_model
    end

    test "create_car_model/1 with valid data creates a car_model" do
      assert {:ok, %CarModel{} = car_model} = CarModels.create_car_model(@valid_attrs)
      assert car_model.name == "some name"
    end

    test "create_car_model/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CarModels.create_car_model(@invalid_attrs)
    end

    test "update_car_model/2 with valid data updates the car_model" do
      car_model = car_model_fixture()
      assert {:ok, %CarModel{} = car_model} = CarModels.update_car_model(car_model, @update_attrs)
      assert car_model.name == "some updated name"
    end

    test "update_car_model/2 with invalid data returns error changeset" do
      car_model = car_model_fixture()
      assert {:error, %Ecto.Changeset{}} = CarModels.update_car_model(car_model, @invalid_attrs)
      assert car_model == CarModels.get_car_model!(car_model.id)
    end

    test "delete_car_model/1 deletes the car_model" do
      car_model = car_model_fixture()
      assert {:ok, %CarModel{}} = CarModels.delete_car_model(car_model)
      assert_raise Ecto.NoResultsError, fn -> CarModels.get_car_model!(car_model.id) end
    end

    test "change_car_model/1 returns a car_model changeset" do
      car_model = car_model_fixture()
      assert %Ecto.Changeset{} = CarModels.change_car_model(car_model)
    end
  end
end
