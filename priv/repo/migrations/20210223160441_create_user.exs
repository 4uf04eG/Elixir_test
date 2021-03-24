defmodule Backend.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user, primary_key: false) do
      add :first_name, :string
      add :last_name, :string
      add :middle_name, :string
      add :email, :string
      add :login, :string, primary_key: true
      add :password, :string

      timestamps()
    end

  end
end
