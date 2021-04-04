defmodule Kuruma.ImageUploader do
  use Arc.Definition

  alias Kuruma.Attachments.VehicleAttachment
  alias Kuruma.Uploads

  @versions [
    :tile_half,
    :tile_half_webp,
    :tile,
    :tile_2x,
    :tile_webp,
    :tile_webp_2x,
    :original
  ]
  @acl :public_read
  @storage_dir "vehicle_attachments"

  def transform(:original, _), do: :noaction

  def transform(size, _) when size in @versions do
    {:convert,
     fn input, output ->
       "#{input} -quality #{quality(size)} -thumbnail #{dimensions(size)}^ -gravity center +profile \"*\" -extent #{
         dimensions(size)
       } -define webp:lossless=true #{format(size)}:#{output}"
     end, format(size)}
  end

  defp dimensions(:tile), do: "450x450"
  defp dimensions(:tile_half), do: "225x225"
  defp dimensions(:tile_half_webp), do: "225x225"
  defp dimensions(:tile_webp), do: "450x450"
  defp dimensions(:tile_2x), do: "900x900"
  defp dimensions(:tile_webp_2x), do: "900x900"

  defp format(:tile), do: :jpeg
  defp format(:tile_half), do: :jpeg
  defp format(:tile_2x), do: :jpeg
  defp format(_), do: :webp

  defp quality(:tile), do: 80
  defp quality(_), do: 50

  def filename(:original, {_file, id}) do
    "#{id}"
  end

  def filename(version, {_file, id}) do
    "#{id}_#{version}"
  end

  def image_url(url, size \\ :tile)

  def image_url(nil, _), do: nil

  def image_url(%VehicleAttachment{url: url}, size) do
    image_url(url, size)
  end

  def image_url(url, size) when is_binary(url) do
    "https://#{host()}/#{@storage_dir}/#{url}_#{size}.#{format(size)}"
  end

  def resolve_full_url(%VehicleAttachment{url: url}, %{size: size}, _) do
    {:ok, image_url(url, size)}
  end

  def resolve_full_url(%VehicleAttachment{url: url}, _, _) do
    {:ok, image_url(url)}
  end

  def store_with_uuid(image, random_url) when is_binary(random_url) do
    store({image, random_url})
    {:ok, random_url}
  end

  def store_with_uuid(image) do
    store_with_uuid(image, Ecto.UUID.generate())
  end

  def storage_dir(_, _), do: @storage_dir

  def s3_object_headers(_version, {file, _scope}) do
    [content_type: MIME.from_path(file.file_name), cache_control: "max-age=#{86400 * 30}"]
  end

  def bucket_name, do: Application.get_env(:ex_aws, :s3) |> Keyword.get(:bucket)
  def host, do: Uploads.public_host()
  def region, do: Application.get_env(:ex_aws, :s3) |> Keyword.get(:region)
end
