defmodule KurumaWeb.Plugs.FetchUser do
  @moduledoc """
  Plug middleware to fetch user information from a JWT bearer token
  included in the `Authorization` request header. The token included
  in the request will be decoded and assigned on the `Plug.Conn` struct
  as well as inside GraphQL context.
  """

  @behaviour Plug

  import Plug.Conn
  alias Kuruma.Token
  alias Kuruma.Users

  def init(opts), do: opts

  defp fetch_token_from_cookie(%Plug.Conn{} = conn) do
    case conn.cookies do
      %{"access_token" => token} -> token
      _ -> nil
    end
  end

  defp fetch_token_from_authorization_header(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        token

      _ ->
        nil
    end
  end

  def fetch_token(%Plug.Conn{} = conn) do
    fetch_token_from_cookie(conn) || fetch_token_from_authorization_header(conn)
  end

  def get_user_from_token(blank) when blank in ["", nil], do: nil

  def get_user_from_token(token) do
    case Token.decode_access_token(token) do
      {:ok, %{"sub" => user_id}} ->
        Users.get_user!(user_id)

      _ ->
        nil
    end
  end

  def call(conn, _) do
    user =
      conn
      |> fetch_token
      |> get_user_from_token()

    conn
    |> assign(:current_user, user)
    |> Absinthe.Plug.assign_context(:current_user, user)
  end
end
