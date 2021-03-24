defmodule BackendWeb.CoachControllerTest do
  use BackendWeb.ConnCase

  alias Backend.Logic
  alias Backend.Logic.Coach

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    middle_name: "some middle_name"
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    middle_name: "some updated middle_name"
  }
  @invalid_attrs %{first_name: nil, last_name: nil, middle_name: nil}

  def fixture(:coach) do
    {:ok, coach} = Logic.create_coach(@create_attrs)
    coach
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all coach", %{conn: conn} do
      conn = get(conn, Routes.coach_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create coach" do
    test "renders coach when data is valid", %{conn: conn} do
      conn = post(conn, Routes.coach_path(conn, :create), coach: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.coach_path(conn, :show, id))

      assert %{
               "id" => id,
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "middle_name" => "some middle_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.coach_path(conn, :create), coach: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update coach" do
    setup [:create_coach]

    test "renders coach when data is valid", %{conn: conn, coach: %Coach{id: id} = coach} do
      conn = put(conn, Routes.coach_path(conn, :update, coach), coach: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.coach_path(conn, :show, id))

      assert %{
               "id" => id,
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "middle_name" => "some updated middle_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, coach: coach} do
      conn = put(conn, Routes.coach_path(conn, :update, coach), coach: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete coach" do
    setup [:create_coach]

    test "deletes chosen coach", %{conn: conn, coach: coach} do
      conn = delete(conn, Routes.coach_path(conn, :delete, coach))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.coach_path(conn, :show, coach))
      end
    end
  end

  defp create_coach(_) do
    coach = fixture(:coach)
    %{coach: coach}
  end
end
