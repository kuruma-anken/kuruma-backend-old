defmodule Kuruma.CarMakers.CarMaker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "car_makers" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(car_maker, attrs) do
    car_maker
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
