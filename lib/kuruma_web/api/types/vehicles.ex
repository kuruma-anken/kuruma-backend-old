defmodule KurumaWeb.Api.Types.Vehicles do
  use Absinthe.Schema.Notation
  alias KurumaWeb.Api.Middleware.FormatPage
  alias KurumaWeb.Api.Middleware.LazyPreload
  alias KurumaWeb.Api.Resolvers.VehicleResolvers

  object :vehicle do
    field :id, non_null(:id)
    field :manufacturing_year, non_null(:integer)
    field :registration, non_null(:string)
    field :car_model_id, non_null(:id)
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  object :car_model do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :car_maker, non_null(:car_maker)
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  object :car_maker do
    field :id, non_null(:id)
    field :name, non_null(:string)

    field :car_models, non_null(list_of(non_null(:car_model))) do
      middleware(LazyPreload, :car_models)
    end

    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  object :vehicle_page do
    field :data, non_null(list_of(non_null(:vehicle)))
    field :page_info, non_null(:page_info)
  end

  object :vehicle_queries do
    field :paginate_vehicles, non_null(:vehicle_page) do
      arg(:page, non_null(:integer), default_value: 1)
      resolve(&VehicleResolvers.paginate_vehicles/2)
      middleware(FormatPage)
    end
  end
end
