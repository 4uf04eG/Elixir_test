defmodule Backend.Logic.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group" do
    field :creation_date, :date
    field :name, :string
    belongs_to :coach, Backend.Logic.Coach

    timestamps()
  end

  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :creation_date, :coach_id])
    |> validate_required([:name, :creation_date, :coach_id])
  end
end
