defmodule NekoCaffeWeb.CatControllerTest do
  use NekoCaffeWeb.ConnCase

  alias NekoCaffe.Pets
  alias NekoCaffe.Pets.Cat

  @create_attrs %{
    age: 42,
    breed: "some breed",
    name: "some name"
  }
  @update_attrs %{
    age: 43,
    breed: "some updated breed",
    name: "some updated name"
  }
  @invalid_attrs %{age: nil, breed: nil, name: nil}

  def fixture(:cat) do
    {:ok, cat} = Pets.create_cat(@create_attrs)
    cat
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cats", %{conn: conn} do
      conn = get(conn, Routes.cat_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cat" do
    test "renders cat when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cat_path(conn, :create), cat: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.cat_path(conn, :show, id))

      assert %{
               "id" => id,
               "age" => 42,
               "breed" => "some breed",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cat_path(conn, :create), cat: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cat" do
    setup [:create_cat]

    test "renders cat when data is valid", %{conn: conn, cat: %Cat{id: id} = cat} do
      conn = put(conn, Routes.cat_path(conn, :update, cat), cat: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.cat_path(conn, :show, id))

      assert %{
               "id" => id,
               "age" => 43,
               "breed" => "some updated breed",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cat: cat} do
      conn = put(conn, Routes.cat_path(conn, :update, cat), cat: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cat" do
    setup [:create_cat]

    test "deletes chosen cat", %{conn: conn, cat: cat} do
      conn = delete(conn, Routes.cat_path(conn, :delete, cat))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.cat_path(conn, :show, cat))
      end
    end
  end

  defp create_cat(_) do
    cat = fixture(:cat)
    %{cat: cat}
  end
end
