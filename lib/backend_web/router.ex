defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :browser do
    plug Corsica, origins: "*", allow_credentials: true
    plug :accepts, ["html"]
  end

#  scope "/:locale", BackendWeb do
#    pipe_through :api
#  end

  pipeline :api do
    plug Corsica, origins: "*", allow_credentials: true
    plug :accepts, ["json"]
#    plug SetLocale, gettext: BackendWeb.Gettext, default_locale: "en"
  end

  scope "/api", BackendWeb do
    pipe_through :api
    resources "/dance", DanceController, except: [:new, :edit]
    resources "/coach", CoachController, except: [:new, :edit]
    resources "/group", GroupController, except: [:new, :edit]
    resources "/participant", ParticipantController, except: [:new, :edit]
    resources "/user", UserController, except: [:new, :edit, :create]
  end

  scope "/auth", BackendWeb do
    post "/register", UserController, :create
    post "/sign_in", SessionsController, :create
    delete "/sign_out", SessionsController, :delete
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/", BackendWeb do
      pipe_through [:fetch_session, :protect_from_forgery, :browser]

      live_dashboard "/dashboard", metrics: Telemetry
    end
  end
end
