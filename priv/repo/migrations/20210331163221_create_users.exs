defmodule Kuruma.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "create extension if not exists citext with schema public"

    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :citext, null: false
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
