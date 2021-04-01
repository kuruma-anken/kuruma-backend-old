defmodule KurumaWeb.Router do
  use KurumaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug KurumaWeb.Plugs.FetchUser
  end

  scope "/api" do
    pipe_through :api

    post "/graphql", Absinthe.Plug,
      schema: KurumaWeb.Api.Schema,
      before_send: {KurumaWeb.Api.CookieHelper, :maybe_put_cookie}

    get "/graphql", Absinthe.Plug.GraphiQL,
      schema: KurumaWeb.Api.Schema,
      interface: :playground
  end

  scope "/", KurumaWeb do
    pipe_through :browser

    get "/*route", PageController, :index
  end
end
