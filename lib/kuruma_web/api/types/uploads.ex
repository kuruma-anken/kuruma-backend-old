defmodule KurumaWeb.Api.Types.Uploads do
  use Absinthe.Schema.Notation

  alias KurumaWeb.Api.Resolvers.UploadResolvers

  object :vehicle_attachment_result do
    field :success, non_null(:boolean)
    field :errors, :json
    field :data, :vehicle_attachment
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

  input_object :vehicle_attachment_params do
    field(:vehicle_id, non_null(:id))
    field(:url, non_null(:string))
    field(:position, non_null(:integer))
  end

  object :upload_mutations do
    field :generate_presigned_upload_url, non_null(:generate_presigned_upload_url_result) do
      arg(:filename, non_null(:string))
      arg(:prefix, non_null(:string))

      resolve(&UploadResolvers.generate_presigned_upload_url/2)
    end

    field :create_vehicle_attachment, non_null(:vehicle_attachment_result) do
      arg(:params, non_null(:vehicle_attachment_params))
      resolve(&UploadResolvers.create_vehicle_attachment/2)
    end
  end
end
