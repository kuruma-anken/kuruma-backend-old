defmodule KurumaWeb.Api.Schema do
  use Absinthe.Schema

  alias KurumaWeb.Api.Middleware.RestrictAccess
  import_types(KurumaWeb.Api.Types.Users)
  import_types(Absinthe.Type.Custom)
  import_types(KurumaWeb.Api.Types.Sessions)
  import_types(KurumaWeb.Api.Types.JSON)

  query do
    import_fields(:user_queries)

    field :hello, :string do
      resolve(fn _, _ -> {:ok, "Hello, world!"} end)
    end
  end

  mutation do
    import_fields(:session_mutations)
  end

  def middleware(middleware, %{identifier: :current_user}, %{identifier: :query}) do
    middleware
  end

  def middleware(middleware, %{identifier: :sign_in}, %{identifier: :mutation}) do
    middleware
  end

  def middleware(middleware, _field, %Absinthe.Type.Object{identifier: :mutation}) do
    [RestrictAccess | middleware] ++ [KurumaWeb.Api.Middleware.TransformErrors]
  end

  def middleware(middleware, _field, %Absinthe.Type.Object{identifier: :query}) do
    [RestrictAccess | middleware]
  end

  def middleware(middleware, _, _) do
    middleware
  end
end
