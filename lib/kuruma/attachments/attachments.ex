defmodule Kuruma.Attachments do
  @moduledoc """
  The Attachments context.
  """

  import Ecto.Query, warn: false
  alias Kuruma.Repo

  alias Kuruma.Attachments.VehicleAttachment

  @doc """
  Returns the list of vehicle_attachments.

  ## Examples

      iex> list_vehicle_attachments()
      [%VehicleAttachment{}, ...]

  """
  def list_vehicle_attachments do
    Repo.all(VehicleAttachment)
  end

  @doc """
  Gets a single vehicle_attachment.

  Raises `Ecto.NoResultsError` if the Vehicle attachment does not exist.

  ## Examples

      iex> get_vehicle_attachment!(123)
      %VehicleAttachment{}

      iex> get_vehicle_attachment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vehicle_attachment!(id), do: Repo.get!(VehicleAttachment, id)

  @doc """
  Creates a vehicle_attachment.

  ## Examples

      iex> create_vehicle_attachment(%{field: value})
      {:ok, %VehicleAttachment{}}

      iex> create_vehicle_attachment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vehicle_attachment(attrs \\ %{}) do
    %VehicleAttachment{}
    |> VehicleAttachment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vehicle_attachment.

  ## Examples

      iex> update_vehicle_attachment(vehicle_attachment, %{field: new_value})
      {:ok, %VehicleAttachment{}}

      iex> update_vehicle_attachment(vehicle_attachment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vehicle_attachment(%VehicleAttachment{} = vehicle_attachment, attrs) do
    vehicle_attachment
    |> VehicleAttachment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vehicle_attachment.

  ## Examples

      iex> delete_vehicle_attachment(vehicle_attachment)
      {:ok, %VehicleAttachment{}}

      iex> delete_vehicle_attachment(vehicle_attachment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vehicle_attachment(%VehicleAttachment{} = vehicle_attachment) do
    Repo.delete(vehicle_attachment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vehicle_attachment changes.

  ## Examples

      iex> change_vehicle_attachment(vehicle_attachment)
      %Ecto.Changeset{data: %VehicleAttachment{}}

  """
  def change_vehicle_attachment(%VehicleAttachment{} = vehicle_attachment, attrs \\ %{}) do
    VehicleAttachment.changeset(vehicle_attachment, attrs)
  end
end
