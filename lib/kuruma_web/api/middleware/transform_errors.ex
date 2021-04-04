defmodule KurumaWeb.Api.Middleware.TransformErrors do
  @behaviour Absinthe.Middleware

  import Absinthe.Utils
  alias KurumaWeb.ErrorHelpers

  def call(res, _) do
    with %{errors: [error]} <- res do
      %{res | errors: [], value: handle_error(error)}
    end
  end

  def handle_error(%Ecto.Changeset{} = changeset) do
    %{success: false, errors: transform_errors(changeset)}
  end

  def handle_error(errors) when is_map(errors) do
    %{success: false, errors: errors}
  end

  def handle_error(str) when is_binary(str) do
    %{success: false, errors: %{"message" => str}}
  end

  def transform_errors(changeset) do
    changeset
    |> remove_replace_content_changesets()
    |> Ecto.Changeset.traverse_errors(&ErrorHelpers.translate_error/1)
    |> normalize_map()
  end

  defp remove_replace_content_changesets(changeset) do
    case Map.get(changeset, :changes) do
      changes = %{content: content} when is_list(content) ->
        new_content = for %{action: :insert} = slice <- content, do: slice
        changes = %{changes | content: new_content}
        %{changeset | changes: changes}

      _ ->
        changeset
    end
  end

  defp format_nested_map(map) do
    Enum.reduce(
      map,
      %{},
      fn {key, [error]}, acc ->
        case String.split(to_string(key), ".") do
          [key] ->
            Map.put(acc, key, error)

          [top, nested] ->
            Map.update(acc, top, %{nested => error}, &Map.put(&1, nested, error))
        end
      end
    )
  end

  defp normalize_error(list) when is_list(list) do
    case Enum.all?(list, &is_binary/1) do
      true ->
        Enum.join(list, " ")

      false ->
        case Enum.all?(list, &is_map/1) do
          true ->
            Enum.with_index(list)
            |> Map.new(fn {map, index} -> {index, format_nested_map(map)} end)

          _ ->
            nil
        end
    end
  end

  defp normalize_error(map) when is_map(map) do
    normalize_map(map)
  end

  defp normalize_map(map) do
    Map.new(map, fn {key, value} -> {format_key(key), normalize_error(value)} end)
  end

  defp format_key(key) do
    key
    |> to_string
    |> camelize(lower: true)
  end
end
