defmodule KurumaWeb.Api.Resolvers.UploadResolvers do
  alias Kuruma.Uploads
  alias Kuruma.Attachments

  def generate_presigned_upload_url(%{filename: filename, prefix: prefix}, _) do
    result = Uploads.generate_presigned_url_for_upload(filename, prefix)
    {:ok, %{success: true, data: result}}
  end

  def upload_product_variant_image(_, %{vehicle_id: vehicle_id, image: image}, _) do
    handle_image_upload(vehicle_id, image)
  end

  defp handle_image_upload(vehicle_id, image) do
    with {:ok, image} <-
           Attachments.create_vehicle_attachment(%{vehicle_id: vehicle_id}, image) do
      {:ok, %{success: true, data: image}}
    end
  end
end
