defmodule KurumaWeb.UploadController do
  use KurumaWeb, :controller
  alias Kuruma.Attachments
  alias KurumaWeb.Api.Middleware.TransformErrors

  def create(conn, %{
        "attachment" => %Plug.Upload{} = file,
        "vehicle_id" => vehicle_id,
        "attachment_type" => type
      }) do
    case Attachments.create_vehicle_attachment(
           %{vehicle_id: vehicle_id, attachment_type: type},
           file
         ) do
      {:ok, attachment} ->
        conn
        |> put_status(200)
        |> json(%{"data" => Map.from_struct(attachment) |> Map.delete(:__meta__)})

      {:error, changeset} ->
        errors = TransformErrors.transform_errors(changeset)

        conn
        |> put_status(422)
        |> json(%{"errors" => errors})
    end
  end
end
