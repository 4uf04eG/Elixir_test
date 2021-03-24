defmodule Backend.Logic.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:image_path, :last_name, :points, :group]}
  schema "participant" do
    field :image_path, :string
    field :last_name, :string
    field :points, :integer
    belongs_to :group, Backend.Logic.Group

    timestamps()
  end

  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:last_name, :image_path, :points])
    |> validate_required([:last_name, :points])
  end
end
