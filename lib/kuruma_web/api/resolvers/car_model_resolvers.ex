defmodule KurumaWeb.Api.Resolvers.CarModelResolvers do
  alias Kuruma.CarModels
  alias Kuruma.CarMakers

  def list_car_models(%{car_maker_id: car_maker_id}, _) do
    {:ok, CarModels.list_car_models_by_car_maker(car_maker_id)}
  end

  def list_car_makers(_, _) do
    {:ok, CarMakers.list_car_makers()}
  end
end
