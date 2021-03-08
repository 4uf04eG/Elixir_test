defmodule BackendWeb.DanceController do
  use BackendWeb, :controller

  alias Backend.Logic
  alias Backend.Logic.Dance

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    dance = Logic.list_dance()
    render(conn, "index.json", dance: dance)
  end

  def create(conn, %{"dance" => dance_params}) do
    with {:ok, %Dance{} = dance} <- Logic.create_dance(dance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.dance_path(conn, :show, dance))
      |> render("show.json", dance: dance)
    end
  end

  def show(conn, %{"id" => id}) do
    dance = Logic.get_dance!(id)
    render(conn, "show.json", dance: dance)
  end

  def update(conn, %{"id" => id, "dance" => dance_params}) do
    dance = Logic.get_dance!(id)

    with {:ok, %Dance{} = dance} <- Logic.update_dance(dance, dance_params) do
      render(conn, "show.json", dance: dance)
    end
  end

  def delete(conn, %{"id" => id}) do
    dance = Logic.get_dance!(id)

    with {:ok, %Dance{}} <- Logic.delete_dance(dance) do
      send_resp(conn, :no_content, "")
    end
  end
end
