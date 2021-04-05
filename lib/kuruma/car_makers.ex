defmodule Kuruma.CarMakers do
  @moduledoc """
  The CarMakers context.
  """

  import Ecto.Query, warn: false
  alias Kuruma.Repo

  alias Kuruma.CarMakers.CarMaker

  def list_car_makers do
    CarMaker
    |> order_by([c], c.name)
    |> Repo.all()
  end

  def get_car_maker!(id), do: Repo.get!(CarMaker, id)

  def create_car_maker(attrs \\ %{}) do
    %CarMaker{}
    |> CarMaker.changeset(attrs)
    |> Repo.insert()
  end

  def update_car_maker(%CarMaker{} = car_maker, attrs) do
    car_maker
    |> CarMaker.changeset(attrs)
    |> Repo.update()
  end

  def delete_car_maker(%CarMaker{} = car_maker) do
    Repo.delete(car_maker)
  end

  def change_car_maker(%CarMaker{} = car_maker, attrs \\ %{}) do
    CarMaker.changeset(car_maker, attrs)
  end
end
