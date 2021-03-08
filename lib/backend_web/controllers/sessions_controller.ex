defmodule BackendWeb.SessionsController do
  use BackendWeb, :controller
  alias Backend.Logic.User

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

  def delete(conn, _) do
    case User.sign_out(conn) do
      {:error, reason} -> conn |> send_resp(400, reason)
      {:ok, _} -> conn |> send_resp(204, "")
    end
  end
end
