defmodule Backend.Logic.Dance do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name]}
  schema "dance" do
    field :name, :string

    timestamps()
  end

  def changeset(dance, attrs) do
    dance
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
