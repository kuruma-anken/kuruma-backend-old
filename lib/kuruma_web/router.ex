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
  end

  scope "/api" do
    post "/graphql", Absinthe.Plug, schema: KurumaWeb.Api.Schema
    get "/graphql", Absinthe.Plug.GraphiQL, schema: KurumaWeb.Api.Schema, interface: :playground
  end

  scope "/", KurumaWeb do
    pipe_through :browser

    get "/*route", PageController, :index
  end
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: KurumaWeb.Telemetry
    end
  end
end
