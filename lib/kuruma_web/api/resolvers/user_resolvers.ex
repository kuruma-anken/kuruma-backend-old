defmodule KyoryuuWeb.Api.Queries.Users do
  use Absinthe.Schema.Notation
  alias KurumaWeb.Api.Resolvers.Users

  object :user_queries do
    field :current_user, :user do
      resolve(fn _, _, %{context: %{current_user: user}} ->
        {:ok, user}
      end)
    end
  end

  object :session_mutations do
    field :sign_in, non_null(:sign_in_response) do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&SessionResolvers.staff_login/2)
      middleware(&SessionResolvers.sign_tokens/2)
      middleware(CookieHelper)
    end
  end
end
