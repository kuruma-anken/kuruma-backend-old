defmodule KurumaWeb.Api.Resolvers.UploadResolvers do
  alias Kuruma.Uploads
  alias Kuruma.Images

  def generate_presigned_upload_url(%{filename: filename, prefix: prefix}, _) do
    result = Uploads.generate_presigned_url_for_upload(filename, prefix)
    {:ok, %{success: true, data: result}}
  end

  def create_vehicle_attachment(args, _) do
    with {:ok, image} <- Images.create_vehicle_image(args) do
      {:ok, %{success: true, data: image}}
    end
  end
end
