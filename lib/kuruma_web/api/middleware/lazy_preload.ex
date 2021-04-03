defmodule KurumaWeb.Api.Middleware.LazyPreload do
  @moduledoc """
  Absinthe middleware to preload Ecto associations only if they have
  been requested.
  """

  @behaviour Absinthe.Middleware

  alias Kuruma.Repo

  def init(_), do: nil

  def call(%{source: source} = res, assoc_name) do
    value =
      case Map.get(source, assoc_name) do
        %Ecto.Association.NotLoaded{__cardinality__: :one} ->
          Repo.one(Ecto.assoc(source, assoc_name))

        %Ecto.Association.NotLoaded{} ->
          Repo.all(Ecto.assoc(source, assoc_name))

        %_module{} = struct ->
          struct

        list when is_list(list) ->
          list
      end

    %{res | value: value, state: :resolved}
  end
end
