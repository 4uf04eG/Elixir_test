defmodule Backend.Logic.Coach do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:first_name, :last_name, :middle_name, :dance]}
  schema "coach" do
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string
    belongs_to :dance, Backend.Logic.Dance
    has_one :group, Backend.Logic.Group

    timestamps()
  end

  def changeset(coach, attrs) do
    coach
    |> cast(attrs, [:first_name, :middle_name, :last_name, :dance_id])
    |> assoc_constraint(:dance)
    |> validate_required([:first_name, :middle_name, :last_name, :dance_id])
  end
end
