defmodule KurumaWeb.Api.Types.Vehicles do
  use Absinthe.Schema.Notation
  alias Kuruma.Uploads
  alias KurumaWeb.Api.Middleware.FormatPage
  alias KurumaWeb.Api.Middleware.LazyPreload
  alias KurumaWeb.Api.Resolvers.VehicleResolvers
  alias Kuruma.ImageUploader

  enum :attachment_type do
    value(:image)
    value(:document)
  end

  enum :image_size do
    value(:tiny)
    value(:tiny_2x)
    value(:tiny_webp)
    value(:tile)
    value(:tile_2x)
    value(:tile_webp)
    value(:tile_webp_2x)
    value(:original)
  end

  object :vehicle_attachment do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :attachment_type, non_null(:attachment_type)

    field :public_url, non_null(:string) do
      arg(:size, :image_size)
      resolve(&ImageUploader.resolve_full_url/3)
    end
  end

  object :vehicle do
    field :id, non_null(:id)
    field :manufacturing_year, non_null(:integer)
    field :registration, non_null(:string)
    field :car_model_id, non_null(:id)
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)

    field :attachments, non_null(list_of(non_null(:vehicle_attachment))) do
      middleware(LazyPreload, :attachments)
    end

    field :car_model, non_null(:car_model) do
      middleware(LazyPreload, :car_model)
    end
  end

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

    field :get_vehicle, :vehicle do
      arg(:id, non_null(:id))
      resolve(&VehicleResolvers.get_vehicle/2)
    end
  end
end
