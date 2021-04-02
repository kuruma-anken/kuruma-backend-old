defmodule Kuruma.CarModels.CarModel do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(name car_maker_id)a

  schema "car_models" do
    field :name, :string
    belongs_to :car_maker, Kuruma.CarMakers.CarMaker
    has_many :vehicles, Kuruma.Vehicles.Vehicle

    timestamps()
  end

  @doc false
  def changeset(car_model, attrs) do
    car_model
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
