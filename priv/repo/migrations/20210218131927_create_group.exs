defmodule Backend.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:group) do
      add :name, :string
      add :creation_date, :date
      add :coach_id, references(:coach, on_delete: :nothing)

      timestamps()
    end

    create index(:group, [:coach_id])
  end
end
