defmodule BackendWeb.SessionsController do
  use BackendWeb, :controller
  alias Backend.Logic.User

  def index(conn, _params) do
    case User.get_current(conn) do
      user ->
        conn
        |> put_status(:ok)
        |> render("user.json", user: user)
      {:error, reason} ->
        conn
        |> send_resp(401, reason)
    end
  end

  def create(conn, %{"login" => login, "password" => password}) do
    case User.sign_in(login, password) do
      {:ok, auth_token} ->
        conn
        |> put_status(:ok)
        |> render("show.json", token: auth_token)
      {:error, reason} ->
        conn
        |> send_resp(401, reason)
    end
  end

  def update(conn, _) do
    case Backend.Authenticator.update_token(conn) do
      {:ok, auth_token} ->
        conn
        |> put_status(:ok)
        |> render("show.json", token: auth_token)
      {:error, reason} ->
        conn
        |> send_resp(401, "")
    end
  end

  def delete(conn, _) do
    case User.sign_out(conn) do
      {:error, _} ->
        conn
        |> send_resp(400, '')
      {:ok, _} ->
        conn
        |> send_resp(204, '')
    end
  end
end
