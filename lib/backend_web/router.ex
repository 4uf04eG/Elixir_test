defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

#  scope "/:locale", BackendWeb do
#    pipe_through :api
#  end

  pipeline :api do
    plug :accepts, ["json"]
#    plug SetLocale, gettext: BackendWeb.Gettext, default_locale: "en"
  end

  pipeline :authenticate do
    plug BackendWeb.Plugs.Authenticate
  end

  scope "/api", BackendWeb do
    pipe_through :api
    pipe_through :authenticate
    resources "/dance", DanceController, except: [:new, :edit]
    resources "/coach", CoachController, except: [:new, :edit]
    resources "/group", GroupController, except: [:new, :edit]
    resources "/participant", ParticipantController, except: [:new, :edit]
    resources "/user", UserController, except: [:new, :edit, :create], param: "login"
  end

  scope "/auth", BackendWeb do
    pipe_through :api
    post "/register", UserController, :create
    post "/update_token", SessionsController, :update
    get "/current_user", SessionsController, :index
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
