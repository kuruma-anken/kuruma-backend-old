defmodule Kuruma.Images do
  @moduledoc """
  The Images context.
  """

  import Ecto.Query, warn: false
  alias Kuruma.Repo

  alias Kuruma.Images.VehicleImage

  @doc """
  Returns the list of vehicle_images.

  ## Examples

      iex> list_vehicle_images()
      [%VehicleImage{}, ...]

  """
  def list_vehicle_images do
    Repo.all(VehicleImage)
  end

  @doc """
  Gets a single vehicle_image.

  Raises `Ecto.NoResultsError` if the Vehicle image does not exist.

  ## Examples

      iex> get_vehicle_image!(123)
      %VehicleImage{}

      iex> get_vehicle_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vehicle_image!(id), do: Repo.get!(VehicleImage, id)

  @doc """
  Creates a vehicle_image.

  ## Examples

      iex> create_vehicle_image(%{field: value})
      {:ok, %VehicleImage{}}

      iex> create_vehicle_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vehicle_image(attrs \\ %{}) do
    %VehicleImage{}
    |> VehicleImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vehicle_image.

  ## Examples

      iex> update_vehicle_image(vehicle_image, %{field: new_value})
      {:ok, %VehicleImage{}}

      iex> update_vehicle_image(vehicle_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vehicle_image(%VehicleImage{} = vehicle_image, attrs) do
    vehicle_image
    |> VehicleImage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vehicle_image.

  ## Examples

      iex> delete_vehicle_image(vehicle_image)
      {:ok, %VehicleImage{}}

      iex> delete_vehicle_image(vehicle_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vehicle_image(%VehicleImage{} = vehicle_image) do
    Repo.delete(vehicle_image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vehicle_image changes.

  ## Examples

      iex> change_vehicle_image(vehicle_image)
      %Ecto.Changeset{data: %VehicleImage{}}

  """
  def change_vehicle_image(%VehicleImage{} = vehicle_image, attrs \\ %{}) do
    VehicleImage.changeset(vehicle_image, attrs)
  end
end
