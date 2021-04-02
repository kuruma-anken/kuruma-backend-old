defmodule Kuruma.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :registration, :string, null: false
      add :manufacturing_year, :integer, null: false
      add :car_model_id, references(:car_models, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:vehicles, [:car_model_id])
    create unique_index(:vehicles, [:registration])
  end
end
