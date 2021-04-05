defmodule KurumaWeb.Api.Types.CarModels do
  use Absinthe.Schema.Notation
  alias KurumaWeb.Api.Resolvers.CarModelResolvers
  alias KurumaWeb.Api.Middleware.LazyPreload

  object :car_model do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :car_maker_id, non_null(:id)

    field :car_maker, non_null(:car_maker) do
      middleware(LazyPreload, :car_maker)
    end

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

  object :car_model_queries do
    field :list_car_models, non_null(list_of(non_null(:car_model))) do
      arg(:car_maker_id, non_null(:id))
      resolve(&CarModelResolvers.list_car_models/2)
    end

    field :list_car_makers, non_null(list_of(non_null(:car_maker))) do
      resolve(&CarModelResolvers.list_car_makers/2)
    end
  end
end
