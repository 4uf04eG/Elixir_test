defmodule BackendWeb.CoachView do
  use BackendWeb, :view
  alias BackendWeb.CoachView

  def render("index.json", %{coach: coach}) do
    %{data: render_many(coach, CoachView, "coach.json"), count: length(coach)}
  end

  def render("show.json", %{coach: coach}) do
    %{data: render_one(coach, CoachView, "coach.json")}
  end

  def render("coach.json", %{coach: coach}) do
    %{
      id: coach.id,
      first_name: coach.first_name,
      last_name: coach.last_name,
      middle_name: coach.middle_name,
      dance: coach.dance
    }
  end
end
