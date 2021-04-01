defmodule KurumaWeb.Api.Middleware.RestrictAccess do
  @behaviour Absinthe.Middleware

  @moduledoc """
  A simple Absinthe middleware to ensure that GraphQL queries or mutations
  are always run by authorized users.
  """

  def init(default), do: default

  def call(%{context: %{current_user: %Kuruma.Users.User{}}} = res, _config) do
    res
  end

  def call(res, _config) do
    %{res | errors: ["You are not signed in."], state: :resolved}
  end
end
