defmodule Kuruma.Repo.Migrations.CreateVehicleAttachments do
  use Ecto.Migration

  def change do
    Kuruma.Images.VehicleAttachment.AttachmentType.create_type()

    create table(:vehicle_attachments) do
      add :url, :string, null: false
      add :vehicle_id, references(:vehicles, on_delete: :nothing)
      add :position, :integer, null: false
      add :attachment_type, :vehicle_attachment_type, null: false

      timestamps()
    end

    create unique_index(:vehicle_attachments, [:vehicle_id, :position, :attachment_type], where: "position is not null")

    create index(:vehicle_attachments, [:vehicle_id])
  end
end
