defmodule KurumaWeb.Api.Types.Users do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)

    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  object :user_queries do
    field :current_user, :user do
      resolve(fn _, %{context: %{current_user: user}} -> {:ok, user} end)
    end
  end
end
