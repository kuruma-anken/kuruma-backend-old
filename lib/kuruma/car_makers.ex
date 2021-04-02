defmodule Kuruma.CarMakers do
  @moduledoc """
  The CarMakers context.
  """

  import Ecto.Query, warn: false
  alias Kuruma.Repo

  alias Kuruma.CarMakers.CarMaker

  @doc """
  Returns the list of car_makers.

  ## Examples

      iex> list_car_makers()
      [%CarMaker{}, ...]

  """
  def list_car_makers do
    Repo.all(CarMaker)
  end

  @doc """
  Gets a single car_maker.

  Raises `Ecto.NoResultsError` if the Car maker does not exist.

  ## Examples

      iex> get_car_maker!(123)
      %CarMaker{}

      iex> get_car_maker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_car_maker!(id), do: Repo.get!(CarMaker, id)

  @doc """
  Creates a car_maker.

  ## Examples

      iex> create_car_maker(%{field: value})
      {:ok, %CarMaker{}}

      iex> create_car_maker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_car_maker(attrs \\ %{}) do
    %CarMaker{}
    |> CarMaker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a car_maker.

  ## Examples

      iex> update_car_maker(car_maker, %{field: new_value})
      {:ok, %CarMaker{}}

      iex> update_car_maker(car_maker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_car_maker(%CarMaker{} = car_maker, attrs) do
    car_maker
    |> CarMaker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a car_maker.

  ## Examples

      iex> delete_car_maker(car_maker)
      {:ok, %CarMaker{}}

      iex> delete_car_maker(car_maker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_car_maker(%CarMaker{} = car_maker) do
    Repo.delete(car_maker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking car_maker changes.

  ## Examples

      iex> change_car_maker(car_maker)
      %Ecto.Changeset{data: %CarMaker{}}

  """
  def change_car_maker(%CarMaker{} = car_maker, attrs \\ %{}) do
    CarMaker.changeset(car_maker, attrs)
  end
end
