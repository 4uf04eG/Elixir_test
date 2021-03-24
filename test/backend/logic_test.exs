defmodule Backend.LogicTest do
  use Backend.DataCase

  alias Backend.Logic

  describe "dance" do
    alias Backend.Logic.Dance

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def dance_fixture(attrs \\ %{}) do
      {:ok, dance} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logic.create_dance()

      dance
    end

    test "list_dance/0 returns all dance" do
      dance = dance_fixture()
      assert Logic.list_dance() == [dance]
    end

    test "get_dance!/1 returns the dance with given id" do
      dance = dance_fixture()
      assert Logic.get_dance!(dance.id) == dance
    end

    test "create_dance/1 with valid data creates a dance" do
      assert {:ok, %Dance{} = dance} = Logic.create_dance(@valid_attrs)
      assert dance.name == "some name"
    end

    test "create_dance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logic.create_dance(@invalid_attrs)
    end

    test "update_dance/2 with valid data updates the dance" do
      dance = dance_fixture()
      assert {:ok, %Dance{} = dance} = Logic.update_dance(dance, @update_attrs)
      assert dance.name == "some updated name"
    end

    test "update_dance/2 with invalid data returns error changeset" do
      dance = dance_fixture()
      assert {:error, %Ecto.Changeset{}} = Logic.update_dance(dance, @invalid_attrs)
      assert dance == Logic.get_dance!(dance.id)
    end

    test "delete_dance/1 deletes the dance" do
      dance = dance_fixture()
      assert {:ok, %Dance{}} = Logic.delete_dance(dance)
      assert_raise Ecto.NoResultsError, fn -> Logic.get_dance!(dance.id) end
    end

    test "change_dance/1 returns a dance changeset" do
      dance = dance_fixture()
      assert %Ecto.Changeset{} = Logic.change_dance(dance)
    end
  end

  describe "coach" do
    alias Backend.Logic.Coach

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name", middle_name: "some middle_name"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", middle_name: "some updated middle_name"}
    @invalid_attrs %{first_name: nil, last_name: nil, middle_name: nil}

    def coach_fixture(attrs \\ %{}) do
      {:ok, coach} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logic.create_coach()

      coach
    end

    test "list_coach/0 returns all coach" do
      coach = coach_fixture()
      assert Logic.list_coach() == [coach]
    end

    test "get_coach!/1 returns the coach with given id" do
      coach = coach_fixture()
      assert Logic.get_coach!(coach.id) == coach
    end

    test "create_coach/1 with valid data creates a coach" do
      assert {:ok, %Coach{} = coach} = Logic.create_coach(@valid_attrs)
      assert coach.first_name == "some first_name"
      assert coach.last_name == "some last_name"
      assert coach.middle_name == "some middle_name"
    end

    test "create_coach/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logic.create_coach(@invalid_attrs)
    end

    test "update_coach/2 with valid data updates the coach" do
      coach = coach_fixture()
      assert {:ok, %Coach{} = coach} = Logic.update_coach(coach, @update_attrs)
      assert coach.first_name == "some updated first_name"
      assert coach.last_name == "some updated last_name"
      assert coach.middle_name == "some updated middle_name"
    end

    test "update_coach/2 with invalid data returns error changeset" do
      coach = coach_fixture()
      assert {:error, %Ecto.Changeset{}} = Logic.update_coach(coach, @invalid_attrs)
      assert coach == Logic.get_coach!(coach.id)
    end

    test "delete_coach/1 deletes the coach" do
      coach = coach_fixture()
      assert {:ok, %Coach{}} = Logic.delete_coach(coach)
      assert_raise Ecto.NoResultsError, fn -> Logic.get_coach!(coach.id) end
    end

    test "change_coach/1 returns a coach changeset" do
      coach = coach_fixture()
      assert %Ecto.Changeset{} = Logic.change_coach(coach)
    end
  end

  describe "group" do
    alias Backend.Logic.Group

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logic.create_group()

      group
    end

    test "list_group/0 returns all group" do
      group = group_fixture()
      assert Logic.list_group() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Logic.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Logic.create_group(@valid_attrs)
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logic.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, %Group{} = group} = Logic.update_group(group, @update_attrs)
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Logic.update_group(group, @invalid_attrs)
      assert group == Logic.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Logic.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Logic.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Logic.change_group(group)
    end
  end

  describe "participant" do
    alias Backend.Logic.Participant

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def participant_fixture(attrs \\ %{}) do
      {:ok, participant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logic.create_participant()

      participant
    end

    test "list_participant/0 returns all participant" do
      participant = participant_fixture()
      assert Logic.list_participant() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = participant_fixture()
      assert Logic.get_participant!(participant.id) == participant
    end

    test "create_participant/1 with valid data creates a participant" do
      assert {:ok, %Participant{} = participant} = Logic.create_participant(@valid_attrs)
    end

    test "create_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logic.create_participant(@invalid_attrs)
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{} = participant} = Logic.update_participant(participant, @update_attrs)
    end

    test "update_participant/2 with invalid data returns error changeset" do
      participant = participant_fixture()
      assert {:error, %Ecto.Changeset{}} = Logic.update_participant(participant, @invalid_attrs)
      assert participant == Logic.get_participant!(participant.id)
    end

    test "delete_participant/1 deletes the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{}} = Logic.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Logic.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = participant_fixture()
      assert %Ecto.Changeset{} = Logic.change_participant(participant)
    end
  end

  describe "participant" do
    alias Backend.Logic.Schema.Participant

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", login: "some login", middle_name: "some middle_name", password: "some password"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", login: "some updated login", middle_name: "some updated middle_name", password: "some updated password"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, login: nil, middle_name: nil, password: nil}

    def participant_fixture(attrs \\ %{}) do
      {:ok, participant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logic.create_participant()

      participant
    end

    test "list_participant/0 returns all participant" do
      participant = participant_fixture()
      assert Logic.list_participant() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = participant_fixture()
      assert Logic.get_participant!(participant.id) == participant
    end

    test "create_participant/1 with valid data creates a participant" do
      assert {:ok, %Participant{} = participant} = Logic.create_participant(@valid_attrs)
      assert participant.email == "some email"
      assert participant.first_name == "some first_name"
      assert participant.last_name == "some last_name"
      assert participant.login == "some login"
      assert participant.middle_name == "some middle_name"
      assert participant.password == "some password"
    end

    test "create_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logic.create_participant(@invalid_attrs)
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{} = participant} = Logic.update_participant(participant, @update_attrs)
      assert participant.email == "some updated email"
      assert participant.first_name == "some updated first_name"
      assert participant.last_name == "some updated last_name"
      assert participant.login == "some updated login"
      assert participant.middle_name == "some updated middle_name"
      assert participant.password == "some updated password"
    end

    test "update_participant/2 with invalid data returns error changeset" do
      participant = participant_fixture()
      assert {:error, %Ecto.Changeset{}} = Logic.update_participant(participant, @invalid_attrs)
      assert participant == Logic.get_participant!(participant.id)
    end

    test "delete_participant/1 deletes the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{}} = Logic.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Logic.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = participant_fixture()
      assert %Ecto.Changeset{} = Logic.change_participant(participant)
    end
  end

  describe "user" do
    alias Backend.Logic.Schema.User

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", login: "some login", middle_name: "some middle_name", password: "some password"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", login: "some updated login", middle_name: "some updated middle_name", password: "some updated password"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, login: nil, middle_name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logic.create_user()

      user
    end

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert Logic.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Logic.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Logic.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.login == "some login"
      assert user.middle_name == "some middle_name"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logic.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Logic.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.login == "some updated login"
      assert user.middle_name == "some updated middle_name"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Logic.update_user(user, @invalid_attrs)
      assert user == Logic.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Logic.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Logic.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Logic.change_user(user)
    end
  end
end
