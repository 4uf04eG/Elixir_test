defmodule Backend.Repo.Migrations.CreateDance do
  use Ecto.Migration

  def change do
    create table(:dance) do
      add :name, :string

      timestamps()
    end

  end
end
