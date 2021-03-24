defmodule BackendWeb.DanceControllerTest do
  use BackendWeb.ConnCase

  alias Backend.Logic
  alias Backend.Logic.Dance

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:dance) do
    {:ok, dance} = Logic.create_dance(@create_attrs)
    dance
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dance", %{conn: conn} do
      conn = get(conn, Routes.dance_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create dance" do
    test "renders dance when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dance_path(conn, :create), dance: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.dance_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dance_path(conn, :create), dance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update dance" do
    setup [:create_dance]

    test "renders dance when data is valid", %{conn: conn, dance: %Dance{id: id} = dance} do
      conn = put(conn, Routes.dance_path(conn, :update, dance), dance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.dance_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, dance: dance} do
      conn = put(conn, Routes.dance_path(conn, :update, dance), dance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete dance" do
    setup [:create_dance]

    test "deletes chosen dance", %{conn: conn, dance: dance} do
      conn = delete(conn, Routes.dance_path(conn, :delete, dance))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.dance_path(conn, :show, dance))
      end
    end
  end

  defp create_dance(_) do
    dance = fixture(:dance)
    %{dance: dance}
  end
end
