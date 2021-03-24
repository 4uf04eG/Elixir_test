defmodule Backend.Repo.Migrations.CreateParticipant do
  use Ecto.Migration

  def change do
    create table(:participant) do
      add :last_name, :string
      add :image_path, :string
      add :points, :integer
      add :group_id, references(:group, on_delete: :nothing)

      timestamps()
    end

    create index(:participant, [:group_id])
  end
end
