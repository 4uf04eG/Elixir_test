defmodule BackendWeb.GroupController do
  use BackendWeb, :controller

  alias Backend.Repo
  alias Backend.Logic
  alias Backend.Logic.Group

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    group = Logic.list_group()
            |> Repo.preload(coach: [:dance])
    render(conn, "index.json", group: group)
  end

  def create(conn, %{"group" => group_params}) do
    with {:ok, %Group{} = group} <- Logic.create_group(group_params) do
      group = group
              |> Repo.preload(coach: [:dance])
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.group_path(conn, :show, group))
      |> render("show.json", group: group)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Logic.get_group!(id)
            |> Repo.preload(coach: [:dance])
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Logic.get_group!(id)
            |> Repo.preload(coach: [:dance])

    with {:ok, %Group{} = group} <- Logic.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Logic.get_group!(id)
            |> Repo.preload(coach: [:dance])

    with {:ok, %Group{}} <- Logic.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end
end
