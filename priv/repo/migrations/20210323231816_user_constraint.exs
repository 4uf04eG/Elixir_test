defmodule Backend.Repo.Migrations.UserConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:user, [:login])

  end
end
