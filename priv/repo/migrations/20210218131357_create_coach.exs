defmodule Backend.Repo.Migrations.CreateCoach do
  use Ecto.Migration

  def change do
    create table(:coach) do
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :dance_id, references(:dance, on_delete: :nothing)

      timestamps()
    end

    create index(:coach, [:dance_id])
  end
end
