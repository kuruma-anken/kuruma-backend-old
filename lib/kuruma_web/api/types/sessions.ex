defmodule KurumaWeb.Api.Types.Sessions do
  use Absinthe.Schema.Notation
  alias KurumaWeb.Api.Resolvers.SessionResolvers

  object :session_mutation_response do
    field :success, non_null(:boolean)
    field :errors, :json
    field :data, :session_data
  end

  object :session_data do
    field :access_token, non_null(:string)
    field :user, non_null(:user)
  end

  object :session_mutations do
    field :sign_in, non_null(:session_mutation_response) do
      arg(:employee_no, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&SessionResolvers.sign_in/2)
      middleware(FomosWeb.Api.CookieHelper)
    end

    field :sign_out, non_null(:session_mutation_response) do
      resolve(&SessionResolvers.sign_out/2)
      middleware(FomosWeb.Api.CookieHelper)
    end
  end
end
