defmodule Backend.Logic do
  @moduledoc """
  The Logic context.
  """

  import Ecto.Query

  alias Backend.Repo
  alias Backend.Logic.Dance

  def list_dance do
    Repo.all(Dance)
  end

  def get_dance!(id), do: Repo.get!(Dance, id)

  def create_dance(attrs \\ %{}) do
    %Dance{}
    |> Dance.changeset(attrs)
    |> Repo.insert()
  end

  def update_dance(%Dance{} = dance, attrs) do
    dance
    |> Dance.changeset(attrs)
    |> Repo.update()
  end

  def delete_dance(%Dance{} = dance) do
    Repo.delete(dance)
  end

  def change_dance(%Dance{} = dance, attrs \\ %{}) do
    Dance.changeset(dance, attrs)
  end

  alias Backend.Logic.Coach

  def list_coach do
    Repo.all Coach
  end

  def get_coach!(id), do: Repo.get!(Coach, id)

  def create_coach(attrs \\ %{}) do
    %Coach{}
    |> Coach.changeset(attrs)
    |> Repo.insert()
  end

  def update_coach(%Coach{} = coach, attrs) do
    coach
    |> Coach.changeset(attrs)
    |> Repo.update()
  end

  def delete_coach(%Coach{} = coach) do
    Repo.delete(coach)
  end

  def change_coach(%Coach{} = coach, attrs \\ %{}) do
    Coach.changeset(coach, attrs)
  end

  alias Backend.Logic.Group

  def list_group do
    Repo.all(Group)
  end

  def get_group!(id), do: Repo.get!(Group, id)

  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end

  alias Backend.Logic.Participant

  def list_participant do
    Repo.all(Participant)
  end

  def get_participant!(id), do: Repo.get!(Participant, id)

  def create_participant(attrs \\ %{}) do
    %Participant{}
    |> Participant.changeset(attrs)
    |> Repo.insert()
  end

  def update_participant(%Participant{} = participant, attrs) do
    participant
    |> Participant.changeset(attrs)
    |> Repo.update()
  end

  def delete_participant(%Participant{} = participant) do
    Repo.delete(participant)
  end


  def change_participant(%Participant{} = participant, attrs \\ %{}) do
    Participant.changeset(participant, attrs)
  end

  alias Backend.Logic.User

  def list_user do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)


  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
