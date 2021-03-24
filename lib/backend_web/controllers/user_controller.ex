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

      case User.sign_in(user.login, user_params["password"]) do
        {:ok, auth_token} ->
          conn
          |> put_status(:ok)
          |> render("show.json", token: auth_token)
        {:error, _} ->
          conn
          |> send_resp(401, "")
      end


  end
    conn
    |> send_resp(401, "")
end

def show(conn, %{"id" => id}) do
  user = Logic.get_user!(id)
         |> Repo.preload(:tokens)
  render(conn, "show.json", user: user)
end

def update(conn, %{"login" => login, "user" => user_params}) do
  user = Logic.get_user!(login)
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
