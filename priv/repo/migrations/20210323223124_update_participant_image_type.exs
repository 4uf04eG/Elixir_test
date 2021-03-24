defmodule Backend.Repo.Migrations.UpdateParticipantImageType do
  use Ecto.Migration

  def change do
    alter table(:participant) do
      modify :image_path, :text
    end
  end
end
