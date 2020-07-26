defmodule NekoCaffeWeb.OwnerControllerTest do
  use NekoCaffeWeb.ConnCase

  alias NekoCaffe.Clients
  alias NekoCaffe.Clients.Owner

  @create_attrs %{
    email: "some email",
    name: "some name"
  }
  @update_attrs %{
    email: "some updated email",
    name: "some updated name"
  }
  @invalid_attrs %{email: nil, name: nil}

  def fixture(:owner) do
    {:ok, owner} = Clients.create_owner(@create_attrs)
    owner
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all owners", %{conn: conn} do
      conn = get(conn, Routes.owner_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create owner" do
    test "renders owner when data is valid", %{conn: conn} do
      conn = post(conn, Routes.owner_path(conn, :create), owner: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.owner_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.owner_path(conn, :create), owner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update owner" do
    setup [:create_owner]

    test "renders owner when data is valid", %{conn: conn, owner: %Owner{id: id} = owner} do
      conn = put(conn, Routes.owner_path(conn, :update, owner), owner: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.owner_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, owner: owner} do
      conn = put(conn, Routes.owner_path(conn, :update, owner), owner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete owner" do
    setup [:create_owner]

    test "deletes chosen owner", %{conn: conn, owner: owner} do
      conn = delete(conn, Routes.owner_path(conn, :delete, owner))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.owner_path(conn, :show, owner))
      end
    end
  end

  defp create_owner(_) do
    owner = fixture(:owner)
    %{owner: owner}
  end
end
