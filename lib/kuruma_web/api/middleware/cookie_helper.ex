defmodule KurumaWeb.Api.CookieHelper do
  @behaviour Absinthe.Middleware

  def init(default), do: default

  def call(%{value: %{data: %{access_token: token}}} = resolution, _config)
      when is_binary(token) do
    update_context(resolution, :set_cookie, token)
  end

  def call(%{value: %{user_signed_out: true}} = resolution, _) do
    update_context(resolution, :set_cookie, nil)
  end

  def call(res, _), do: res

  defp update_context(resolution, key, value) do
    Map.update!(resolution, :context, fn ctx ->
      Map.put(ctx, key, value)
    end)
  end

  def maybe_put_cookie(conn, %Absinthe.Blueprint{} = blueprint) do
    case blueprint.execution.context do
      %{set_cookie: nil} ->
        Plug.Conn.delete_resp_cookie(conn, "access_token")

      %{set_cookie: token} ->
        Plug.Conn.put_resp_cookie(conn, "access_token", token)

      _ ->
        conn
    end
  end

  def maybe_put_cookie(conn, _) do
    conn
  end
end
