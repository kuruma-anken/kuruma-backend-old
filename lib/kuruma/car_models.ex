defmodule Kuruma.CarModels do
  @moduledoc """
  The CarModels context.
  """

  import Ecto.Query, warn: false
  alias Kuruma.Repo

  alias Kuruma.CarModels.CarModel

  @doc """
  Returns the list of car_models.

  ## Examples

      iex> list_car_models()
      [%CarModel{}, ...]

  """
  def list_car_models do
    Repo.all(CarModel)
  end

  @doc """
  Gets a single car_model.

  Raises `Ecto.NoResultsError` if the Car model does not exist.

  ## Examples

      iex> get_car_model!(123)
      %CarModel{}

      iex> get_car_model!(456)
      ** (Ecto.NoResultsError)

  """
  def get_car_model!(id), do: Repo.get!(CarModel, id)

  @doc """
  Creates a car_model.

  ## Examples

      iex> create_car_model(%{field: value})
      {:ok, %CarModel{}}

      iex> create_car_model(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_car_model(attrs \\ %{}) do
    %CarModel{}
    |> CarModel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a car_model.

  ## Examples

      iex> update_car_model(car_model, %{field: new_value})
      {:ok, %CarModel{}}

      iex> update_car_model(car_model, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_car_model(%CarModel{} = car_model, attrs) do
    car_model
    |> CarModel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a car_model.

  ## Examples

      iex> delete_car_model(car_model)
      {:ok, %CarModel{}}

      iex> delete_car_model(car_model)
      {:error, %Ecto.Changeset{}}

  """
  def delete_car_model(%CarModel{} = car_model) do
    Repo.delete(car_model)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking car_model changes.

  ## Examples

      iex> change_car_model(car_model)
      %Ecto.Changeset{data: %CarModel{}}

  """
  def change_car_model(%CarModel{} = car_model, attrs \\ %{}) do
    CarModel.changeset(car_model, attrs)
  end
end
