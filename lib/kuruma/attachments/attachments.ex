defmodule Kuruma.Attachments do
  @moduledoc """
  The Attachments context.
  """

  import Ecto.Query, warn: false
  alias Kuruma.Repo
  alias Kuruma.ImageUploader

  alias Kuruma.Attachments.VehicleAttachment

  def list_vehicle_attachments do
    Repo.all(VehicleAttachment)
  end

  def create_vehicle_attachment(attrs, image) do
    with {:ok, url} <- ImageUploader.store_with_uuid(image) do
      %VehicleAttachment{url: url}
      |> VehicleAttachment.changeset(attrs)
      |> Repo.insert()
    end
  end

  def get_vehicle_attachment!(id), do: Repo.get!(VehicleAttachment, id)

  def update_vehicle_attachment(%VehicleAttachment{} = vehicle_attachment, attrs) do
    vehicle_attachment
    |> VehicleAttachment.changeset(attrs)
    |> Repo.update()
  end

  def delete_vehicle_attachment(%VehicleAttachment{} = vehicle_attachment) do
    Repo.delete(vehicle_attachment)
  end

  def change_vehicle_attachment(%VehicleAttachment{} = vehicle_attachment, attrs \\ %{}) do
    VehicleAttachment.changeset(vehicle_attachment, attrs)
  end
end
