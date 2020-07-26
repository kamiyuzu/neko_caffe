defmodule NekoCaffeWeb.AdoptionControllerTest do
  use NekoCaffeWeb.ConnCase

  alias NekoCaffe.Registry
  alias NekoCaffe.Registry.Adoption

  @create_attrs %{
    worker_name: "some worker_name"
  }
  @update_attrs %{
    worker_name: "some updated worker_name"
  }
  @invalid_attrs %{worker_name: nil}

  def fixture(:adoption) do
    {:ok, adoption} = Registry.create_adoption(@create_attrs)
    adoption
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all adoptions", %{conn: conn} do
      conn = get(conn, Routes.adoption_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create adoption" do
    test "renders adoption when data is valid", %{conn: conn} do
      conn = post(conn, Routes.adoption_path(conn, :create), adoption: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.adoption_path(conn, :show, id))

      assert %{
               "id" => id,
               "worker_name" => "some worker_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.adoption_path(conn, :create), adoption: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update adoption" do
    setup [:create_adoption]

    test "renders adoption when data is valid", %{conn: conn, adoption: %Adoption{id: id} = adoption} do
      conn = put(conn, Routes.adoption_path(conn, :update, adoption), adoption: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.adoption_path(conn, :show, id))

      assert %{
               "id" => id,
               "worker_name" => "some updated worker_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, adoption: adoption} do
      conn = put(conn, Routes.adoption_path(conn, :update, adoption), adoption: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete adoption" do
    setup [:create_adoption]

    test "deletes chosen adoption", %{conn: conn, adoption: adoption} do
      conn = delete(conn, Routes.adoption_path(conn, :delete, adoption))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.adoption_path(conn, :show, adoption))
      end
    end
  end

  defp create_adoption(_) do
    adoption = fixture(:adoption)
    %{adoption: adoption}
  end
end
