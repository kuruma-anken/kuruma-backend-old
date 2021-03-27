defmodule KurumaWeb.PageController do
  use KurumaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
