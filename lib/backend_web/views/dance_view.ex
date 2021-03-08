defmodule BackendWeb.DanceView do
  use BackendWeb, :view
  alias BackendWeb.DanceView

  def render("index.json", %{dance: dance}) do
    %{data: render_many(dance, DanceView, "dance.json"), count: length(dance)}
  end

  def render("show.json", %{dance: dance}) do
    %{data: render_one(dance, DanceView, "dance.json")}
  end

  def render("dance.json", %{dance: dance}) do
    %{
      id: dance.id,
      name: dance.name
    }
  end
end
