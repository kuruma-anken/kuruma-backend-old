defmodule Kuruma.CarModels.CarModel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "car_models" do
    field :name, :string
    field :car_maker_id, :id

    timestamps()
  end

  @doc false
  def changeset(car_model, attrs) do
    car_model
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
