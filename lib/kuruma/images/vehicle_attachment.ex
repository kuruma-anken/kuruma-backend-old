defmodule Kuruma.Images.VehicleAttachment do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(attachment_type url vehicle_id)a
  @cast @required ++ [:position]

  import EctoEnum

  defenum(AttachmentType, :vehicle_attachment_type, [:image, :document])

  schema "vehicle_images" do
    field :url, :string
    field :vehicle_id, :id
    field :attachment_type, AttachmentType
    field :position, :integer

    timestamps()
  end

  @doc false
  def changeset(vehicle_image, attrs) do
    vehicle_image
    |> cast(attrs, @cast)
    |> validate_required(@required)
    |> unique_constraint([:vehicle_id, :position, :attachment_type])
    |> strip_url()
  end

  def strip_url(changeset) do
    case get_change(changeset, :url) do
      nil ->
        changeset

      url when is_binary(url) ->
        if url =~ ~r/https?:\/\// do
          %{path: path} = URI.parse(url)
          put_change(changeset, :url, path)
        else
          changeset
        end
    end
  end
end
