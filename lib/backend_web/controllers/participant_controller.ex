defmodule BackendWeb.ParticipantController do
  use BackendWeb, :controller

  alias Backend.Logic
  alias Backend.Logic.Participant

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    participant = Logic.list_participant()
                  |> Repo.preload(:group)
    render(conn, "index.json", participant: participant)
  end

  def create(conn, %{"participant" => participant_params}) do
    with {:ok, %Participant{} = participant} <- Logic.create_participant(participant_params) do
      participant = participant
                    |> Repo.preload(:group)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.participant_path(conn, :show, participant))
      |> render("show.json", participant: participant)
    end
  end

  def show(conn, %{"id" => id}) do
    participant = Logic.get_participant!(id)
                  |> Repo.preload(:group)
    render(conn, "show.json", participant: participant)
  end

  def update(conn, %{"id" => id, "participant" => participant_params}) do
    participant = Logic.get_participant!(id)
                  |> Repo.preload(:group)

    with {:ok, %Participant{} = participant} <- Logic.update_participant(participant, participant_params) do
      render(conn, "show.json", participant: participant)
    end
  end

  def delete(conn, %{"id" => id}) do
    participant = Logic.get_participant!(id)
                  |> Repo.preload(:group)

    with {:ok, %Participant{}} <- Logic.delete_participant(participant) do
      send_resp(conn, :no_content, "")
    end
  end
end
