defmodule KurumaWeb.Api.Types.Uploads do
  use Absinthe.Schema.Notation

  alias KurumaWeb.Api.Resolvers.UploadResolvers

  object :upload_mutations do
    field :generate_presigned_upload_url, non_null(:generate_presigned_upload_url_result) do
      resolve(&UploadResolvers.generate_presigned_upload_url/2)
    end
  end
end
