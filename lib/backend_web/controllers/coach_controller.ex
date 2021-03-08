defmodule BackendWeb.CoachController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Logic
  alias Backend.Logic.Coach

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    coach = Logic.list_coach() |> Repo.preload(:dance)
    render(conn, "index.json", coach: coach)
  end

  def create(conn, %{"coach" => coach_params}) do
    with {:ok, %Coach{} = coach} <- Logic.create_coach(coach_params) do
      coach = coach |> Repo.preload(:dance)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.coach_path(conn, :show, coach))
      |> render("show.json", coach: coach)
    end
  end

  def show(conn, %{"id" => id}) do
    coach = Logic.get_coach!(id) |> Repo.preload(:dance)
    render(conn, "show.json", coach: coach)
  end

  def update(conn, %{"id" => id, "coach" => coach_params}) do
    coach = Logic.get_coach!(id) |> Repo.preload(:dance)

    with {:ok, %Coach{} = coach} <- Logic.update_coach(coach, coach_params) do
      render(conn, "show.json", coach: coach)
    end
  end

  def delete(conn, %{"id" => id}) do
    coach = Logic.get_coach!(id) |> Repo.preload(:dance)

    with {:ok, %Coach{}} <- Logic.delete_coach(coach) do
      send_resp(conn, :no_content, "")
    end
  end
end
