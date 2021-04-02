defmodule Kuruma.CarModels do
  @moduledoc """
  The CarModels context.
  """

  import Ecto.Query, warn: false
  alias Kuruma.Repo

  alias Kuruma.CarModels.CarModel

  def list_car_models do
    Repo.all(CarModel)
  end

  def get_car_model!(id), do: Repo.get!(CarModel, id)

  def create_car_model(attrs \\ %{}) do
    %CarModel{}
    |> CarModel.changeset(attrs)
    |> Repo.insert()
  end

  def update_car_model(%CarModel{} = car_model, attrs) do
    car_model
    |> CarModel.changeset(attrs)
    |> Repo.update()
  end

  def delete_car_model(%CarModel{} = car_model) do
    Repo.delete(car_model)
  end

  def change_car_model(%CarModel{} = car_model, attrs \\ %{}) do
    CarModel.changeset(car_model, attrs)
  end
end
