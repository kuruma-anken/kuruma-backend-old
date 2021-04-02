defmodule Kuruma.Repo do
  use Ecto.Repo,
    otp_app: :kuruma,
    adapter: Ecto.Adapters.Postgres

  use Scrivener
end
