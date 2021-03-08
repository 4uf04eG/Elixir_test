defmodule BackendWeb.GroupView do
  use BackendWeb, :view
  alias BackendWeb.GroupView

  def render("index.json", %{group: group}) do
    %{data: render_many(group, GroupView, "group.json"), count: length(group)}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{
      id: group.id,
      creation_date: group.creation_date,
      name: group.name,
      coach: group.coach
    }
  end
end
