defmodule Kuruma.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "create extension if not exists citext with schema public"

    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :citext
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
