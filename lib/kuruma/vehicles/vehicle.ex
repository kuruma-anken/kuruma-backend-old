defmodule Kuruma.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(manufacturing_year registration car_model_id)a

  schema "vehicles" do
    field :manufacturing_year, :integer
    field :registration, :string
    belongs_to :car_model, Kuruma.CarModels.CarModel
    has_one :car_maker, through: [:car_model, :car_maker]
    has_many :vehicle_images, Kuruma.Images.VehicleAttachment

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
