defmodule KurumaWeb.Api.Middleware.FormatPage do
  @behaviour Absinthe.Middleware

  def call(%{value: %Scrivener.Page{} = page} = res, _) do
    %{
      entries: data,
      page_number: page_number,
      page_size: page_size,
      total_pages: total_pages,
      total_entries: total_entries
    } = page

    new_value = %{
      data: data,
      page_info: %{
        page: page_number,
        page_size: page_size,
        total_pages: total_pages,
        total_entries: total_entries
      }
    }

    %{res | value: new_value}
  end

  def call(res, _) do
    res
  end
end
