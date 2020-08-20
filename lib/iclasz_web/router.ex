defmodule IclaszWeb.Router do
  use IclaszWeb, :router
  alias Iclasz.Plugs.Gatekeeper

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {IclaszWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug(Gatekeeper)
  end

  scope "/", IclaszWeb do
    pipe_through :browser
    get "/", LandingController, :index
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
  end

  scope "/dashboard", IclaszWeb do
    pipe_through [:browser, :authenticated]
    get "/", DashboardController, :index
  end

  scope "/classroom", IclaszWeb do
    pipe_through [:browser, :authenticated]
    resources "/", ClassroomController
  end

  scope "/auth", IclaszWeb do
    pipe_through([:browser])

    get "/login", AuthController, :new
    get "/:provider/callback", AuthController, :callback
    post "/identity/callback", AuthController, :identity_callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", IclaszWeb do
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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: IclaszWeb.Telemetry
    end
  end
end
