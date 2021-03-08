defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Logic
  alias Backend.Logic.User

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    user = Logic.list_user()
           |> Repo.preload(:tokens)
    render(conn, "index.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Logic.create_user(user_params) do
      user = user
             |> Repo.preload(:tokens)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Logic.get_user!(id)
           |> Repo.preload(:tokens)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Logic.get_user!(id)
           |> Repo.preload(:tokens)

    with {:ok, %User{} = user} <- Logic.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Logic.get_user!(id)
           |> Repo.preload(:tokens)

    with {:ok, %User{}} <- Logic.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
