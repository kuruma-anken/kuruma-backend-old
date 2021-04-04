defmodule Kuruma.Uploads do
  alias Kuruma.Attachments.VehicleAttachment

  def get_all_config, do: Application.get_env(:kuruma, __MODULE__)
  def public_host, do: get_all_config() |> Keyword.get(:public_host)

  def generate_presigned_url_for_upload(filename, prefix) do
    mime = MIME.from_path(filename)
    extension = MIME.extensions(mime) |> List.first()
    query_params = [{"Content-Type", mime}]
    presign_options = [query_params: query_params]
    target_filename = "/#{prefix}/#{UUID.uuid4()}.#{extension}"
    config = ExAws.Config.new(:s3)

    {:ok, upload_url} =
      ExAws.S3.presigned_url(config, :put, config.bucket, target_filename, presign_options)

    public_url = "https://#{public_host()}#{target_filename}"

    %{public_url: public_url, upload_url: upload_url}
  end
end
