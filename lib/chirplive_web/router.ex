defmodule ChirpliveWeb.Router do
  use ChirpliveWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {ChirpliveWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", ChirpliveWeb do
    pipe_through [:browser, :protected]

    live("/posts/new", PostLive.Index, :new)
    live("/posts/:id/edit", PostLive.Index, :edit)
    live("/posts/:id/show/edit", PostLive.Show, :edit)
  end

  scope "/", ChirpliveWeb do
    pipe_through [:browser, :protected]

    live("/", PageLive, :index)

    live("/posts", PostLive.Index, :index)
    live("/posts/:id", PostLive.Show, :show)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChirpliveWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)
      live_dashboard("/dashboard", metrics: ChirpliveWeb.Telemetry)
    end
  end
end
