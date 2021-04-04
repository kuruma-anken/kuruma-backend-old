defmodule KurumaWeb.Api.Schema do
  use Absinthe.Schema

  alias KurumaWeb.Api.Middleware.RestrictAccess
  import_types(KurumaWeb.Api.Types.Users)
  import_types(Absinthe.Type.Custom)
  import_types(Absinthe.Plug.Types)

  import_types(KurumaWeb.Api.Types.Sessions)
  import_types(KurumaWeb.Api.Types.JSON)
  import_types(KurumaWeb.Api.Types.Vehicles)
  import_types(KurumaWeb.Api.Types.Pagination)
  import_types(KurumaWeb.Api.Types.Uploads)

  query do
    import_fields(:user_queries)
    import_fields(:vehicle_queries)
  end

  mutation do
    import_fields(:session_mutations)
    import_fields(:upload_mutations)
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
