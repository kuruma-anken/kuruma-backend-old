defmodule KurumaWeb.Api.Types.Uploads do
  use Absinthe.Schema.Notation

  alias KurumaWeb.Api.Resolvers.UploadResolvers

  object :vehicle_image_result do
    field :success, non_null(:boolean)
    field :errors, :json
    field :data, :vehicle_image
  end

  object :generate_presigned_upload_url_result do
    field :success, non_null(:boolean)
    field :errors, :json
    field :data, :presigned_url_object
  end

  object :presigned_url_object do
    field :public_url, non_null(:string)
    field :upload_url, non_null(:string)
  end

  input_object :vehicle_image_params do
    field(:vehicle_id, non_null(:id))
    field(:url, non_null(:string))
    field(:position, non_null(:integer))
  end

  object :upload_mutations do
    field :generate_presigned_upload_url, non_null(:generate_presigned_upload_url_result) do
      resolve(&UploadResolvers.generate_presigned_upload_url/2)
    end

    field :create_vehicle_image, non_null(:vehicle_image_result) do
      arg(:params, non_null(:vehicle_image_params))
      resolve(&UploadResolvers.create_vehicle_image/2)
    end
  end
end
