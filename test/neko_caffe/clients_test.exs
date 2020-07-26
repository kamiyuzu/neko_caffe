defmodule NekoCaffe.ClientsTest do
  use NekoCaffe.DataCase

  alias NekoCaffe.Clients

  describe "owners" do
    alias NekoCaffe.Clients.Owner

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def owner_fixture(attrs \\ %{}) do
      {:ok, owner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Clients.create_owner()

      owner
    end

    test "list_owners/0 returns all owners" do
      owner = owner_fixture()
      assert Clients.list_owners() == [owner]
    end

    test "get_owner!/1 returns the owner with given id" do
      owner = owner_fixture()
      assert Clients.get_owner!(owner.id) == owner
    end

    test "create_owner/1 with valid data creates a owner" do
      assert {:ok, %Owner{} = owner} = Clients.create_owner(@valid_attrs)
      assert owner.email == "some email"
      assert owner.name == "some name"
    end

    test "create_owner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_owner(@invalid_attrs)
    end

    test "update_owner/2 with valid data updates the owner" do
      owner = owner_fixture()
      assert {:ok, %Owner{} = owner} = Clients.update_owner(owner, @update_attrs)
      assert owner.email == "some updated email"
      assert owner.name == "some updated name"
    end

    test "update_owner/2 with invalid data returns error changeset" do
      owner = owner_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_owner(owner, @invalid_attrs)
      assert owner == Clients.get_owner!(owner.id)
    end

    test "delete_owner/1 deletes the owner" do
      owner = owner_fixture()
      assert {:ok, %Owner{}} = Clients.delete_owner(owner)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_owner!(owner.id) end
    end

    test "change_owner/1 returns a owner changeset" do
      owner = owner_fixture()
      assert %Ecto.Changeset{} = Clients.change_owner(owner)
    end
  end
end
