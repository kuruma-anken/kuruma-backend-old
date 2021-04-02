defmodule Kuruma.Repo.Migrations.CreateCarMakers do
  use Ecto.Migration

  def change do
    create table(:car_makers) do
      add :name, :string

      timestamps()
    end

    create unique_index(:car_makers, [:name])
  end
end
