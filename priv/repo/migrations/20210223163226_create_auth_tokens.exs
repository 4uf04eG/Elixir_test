defmodule Backend.Repo.Migrations.CreateAuthTokens do
  use Ecto.Migration

  def change do
    create table(:auth_tokens) do
      add :token, :text
      add :revoked, :boolean, default: false, null: false
      add :revoked_at, :utc_datetime
      add :user_login, references(:user, column: :login, on_delete: :nothing, type: :string)

      timestamps()
    end

    create unique_index(:auth_tokens, [:token])
    create index(:auth_tokens, [:user_login])
  end
end
