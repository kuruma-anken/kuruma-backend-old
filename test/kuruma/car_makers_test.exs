defmodule Kuruma.CarMakersTest do
  use Kuruma.DataCase

  alias Kuruma.CarMakers

  describe "car_makers" do
    alias Kuruma.CarMakers.CarMaker

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def car_maker_fixture(attrs \\ %{}) do
      {:ok, car_maker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CarMakers.create_car_maker()

      car_maker
    end

    test "list_car_makers/0 returns all car_makers" do
      car_maker = car_maker_fixture()
      assert CarMakers.list_car_makers() == [car_maker]
    end

    test "get_car_maker!/1 returns the car_maker with given id" do
      car_maker = car_maker_fixture()
      assert CarMakers.get_car_maker!(car_maker.id) == car_maker
    end

    test "create_car_maker/1 with valid data creates a car_maker" do
      assert {:ok, %CarMaker{} = car_maker} = CarMakers.create_car_maker(@valid_attrs)
      assert car_maker.name == "some name"
    end

    test "create_car_maker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CarMakers.create_car_maker(@invalid_attrs)
    end

    test "update_car_maker/2 with valid data updates the car_maker" do
      car_maker = car_maker_fixture()
      assert {:ok, %CarMaker{} = car_maker} = CarMakers.update_car_maker(car_maker, @update_attrs)
      assert car_maker.name == "some updated name"
    end

    test "update_car_maker/2 with invalid data returns error changeset" do
      car_maker = car_maker_fixture()
      assert {:error, %Ecto.Changeset{}} = CarMakers.update_car_maker(car_maker, @invalid_attrs)
      assert car_maker == CarMakers.get_car_maker!(car_maker.id)
    end

    test "delete_car_maker/1 deletes the car_maker" do
      car_maker = car_maker_fixture()
      assert {:ok, %CarMaker{}} = CarMakers.delete_car_maker(car_maker)
      assert_raise Ecto.NoResultsError, fn -> CarMakers.get_car_maker!(car_maker.id) end
    end

    test "change_car_maker/1 returns a car_maker changeset" do
      car_maker = car_maker_fixture()
      assert %Ecto.Changeset{} = CarMakers.change_car_maker(car_maker)
    end
  end
end
