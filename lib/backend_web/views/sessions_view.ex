defmodule BackendWeb.SessionsView do
  use BackendWeb, :view

  def render("show.json", token) do
    token.token
  end

  def render("user.json", %{user: user}) do
    %{
      first_name: user.first_name,
      last_name: user.last_name,
      middle_name: user.middle_name,
      email: user.email,
      login: user.login,
      password: user.password}
  end
end