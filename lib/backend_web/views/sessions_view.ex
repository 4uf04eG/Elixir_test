defmodule BackendWeb.SessionsView do
  use BackendWeb, :view

  def render("show.json", token) do
    token.token
  end
end