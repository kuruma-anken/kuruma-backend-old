defmodule KurumaWeb.ApiCase do
  @moduledoc """
  Test suite template module for GraphQL queries and mutation.
  `use` this module in all test suites where you want to run
  queries against the actual API. In unit tests that do not
  need to perform GraphQL requests, please `use Kuruma.DataCase` instead.

  Includes helpers for querying the GraphQL API while bypassing the
  application router. Factories are also included.
  """

  use ExUnit.CaseTemplate

  using(opts) do
    schema = Keyword.get(opts, :schema, KurumaWeb.Api.Schema)
    api_path = Keyword.get(opts, :api_path, "/phx/graphql")
    async = Keyword.get(opts, :async, true)

    quote do
      @__schema__ unquote(schema)
      @__api_path__ unquote(api_path)
      @endpoint KurumaWeb.Endpoint

      alias Kuruma.Repo

      use ExUnit.Case, async: unquote(async)

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import KurumaWeb.ConnCase
      import Kuruma.DataCase
      import Kuruma.Factory
      import KurumaWeb.ApiCase
      import Phoenix.ConnTest

      def run_query(document, variables, context \\ %{}) do
        opts = [variables: normalize_variables(variables), context: context]

        case Absinthe.run!(document, @__schema__, opts) do
          %{data: data} when not is_nil(data) ->
            data

          %{errors: errors} when not is_nil(errors) ->
            {:error, errors}

          other ->
            other
        end
      end

      def query(document, variables \\ %{}) do
        run_query(document, variables)
      end

      def mutate(document, variables \\ %{}) do
        run_query(document, variables)
      end

      def query(document, user, variables) do
        query_with_user(document, user, variables)
      end

      def query_with_user(document, user, variables) do
        run_query(document, variables, %{current_user: user})
      end

      def mutate_with_user(document, user, variables) do
        query_with_user(document, user, variables)
      end

      def query_over_router(conn, query, variables \\ %{}) do
        conn
        |> Plug.Conn.put_req_header("content-type", "application/json")
        |> post(@__api_path__, Jason.encode!(%{query: query, variables: variables}))
      end

      setup tags do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Kuruma.Repo)

        Absinthe.Test.prime(@__schema__)

        unless tags[:async] do
          Ecto.Adapters.SQL.Sandbox.mode(Kuruma.Repo, {:shared, self()})
        end

        [conn: Phoenix.ConnTest.build_conn()]
      end
    end
  end

  def normalize_variables([]), do: []

  def normalize_variables([id | _tail] = list) when is_binary(id) or is_integer(id), do: list

  def normalize_variables([head | _tail] = list) when is_map(head) do
    Enum.map(list, &normalize_variables/1)
  end

  def normalize_variables(variables) when is_map(variables) or is_list(variables) do
    Map.new(variables, fn {key, val} -> {camelize_key(key), normalize_variables(val)} end)
  end

  def normalize_variables(atom) when is_atom(atom) and atom not in [true, false, nil],
    do: to_string(atom) |> String.upcase()

  def normalize_variables(other), do: other

  def camelize_key(key) do
    to_string(key)
    |> Absinthe.Utils.camelize(lower: true)
  end

  def get_ids(actual) do
    Enum.map(actual, fn
      %{"id" => id} when is_binary(id) -> String.to_integer(id)
      %{id: id} when is_integer(id) -> id
    end)
    |> Enum.sort()
  end
end
