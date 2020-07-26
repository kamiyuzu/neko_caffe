defmodule NekoCaffe.RegistryTest do
  use NekoCaffe.DataCase

  alias NekoCaffe.Registry

  describe "adoptions" do
    alias NekoCaffe.Registry.Adoption

    @valid_attrs %{worker_name: "some worker_name"}
    @update_attrs %{worker_name: "some updated worker_name"}
    @invalid_attrs %{worker_name: nil}

    def adoption_fixture(attrs \\ %{}) do
      {:ok, adoption} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Registry.create_adoption()

      adoption
    end

    test "list_adoptions/0 returns all adoptions" do
      adoption = adoption_fixture()
      assert Registry.list_adoptions() == [adoption]
    end

    test "get_adoption!/1 returns the adoption with given id" do
      adoption = adoption_fixture()
      assert Registry.get_adoption!(adoption.id) == adoption
    end

    test "create_adoption/1 with valid data creates a adoption" do
      assert {:ok, %Adoption{} = adoption} = Registry.create_adoption(@valid_attrs)
      assert adoption.worker_name == "some worker_name"
    end

    test "create_adoption/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registry.create_adoption(@invalid_attrs)
    end

    test "update_adoption/2 with valid data updates the adoption" do
      adoption = adoption_fixture()
      assert {:ok, %Adoption{} = adoption} = Registry.update_adoption(adoption, @update_attrs)
      assert adoption.worker_name == "some updated worker_name"
    end

    test "update_adoption/2 with invalid data returns error changeset" do
      adoption = adoption_fixture()
      assert {:error, %Ecto.Changeset{}} = Registry.update_adoption(adoption, @invalid_attrs)
      assert adoption == Registry.get_adoption!(adoption.id)
    end

    test "delete_adoption/1 deletes the adoption" do
      adoption = adoption_fixture()
      assert {:ok, %Adoption{}} = Registry.delete_adoption(adoption)
      assert_raise Ecto.NoResultsError, fn -> Registry.get_adoption!(adoption.id) end
    end

    test "change_adoption/1 returns a adoption changeset" do
      adoption = adoption_fixture()
      assert %Ecto.Changeset{} = Registry.change_adoption(adoption)
    end
  end
end
