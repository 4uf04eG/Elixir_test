defmodule BackendWeb.ParticipantView do
  use BackendWeb, :view
  alias BackendWeb.ParticipantView

  def render("index.json", %{participant: participant}) do
    %{data: render_many(participant, ParticipantView, "participant.json"), count: length(participant)}
  end

  def render("show.json", %{participant: participant}) do
    %{data: render_one(participant, ParticipantView, "participant.json")}
  end

  def render("participant.json", %{participant: participant}) do
    %{
      id: participant.id,
      image_path: participant.image_path,
      last_name: participant.last_name,
      points: participant.points,
      group: participant.group
    }
  end
end
