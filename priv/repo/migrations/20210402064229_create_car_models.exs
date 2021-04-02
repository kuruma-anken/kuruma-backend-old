defmodule Kuruma.Repo.Migrations.CreateCarModels do
  use Ecto.Migration

  def change do
    create table(:car_models) do
      add :name, :string
      add :car_maker_id, references(:car_makers, on_delete: :delete_all)

      timestamps()
    end

    create index(:car_models, [:car_maker_id])
    create unique_index(:car_models, [:name, :car_maker_id])
  end
end
