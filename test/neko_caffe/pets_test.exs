defmodule NekoCaffe.PetsTest do
  use NekoCaffe.DataCase

  alias NekoCaffe.Pets

  describe "cats" do
    alias NekoCaffe.Pets.Cat

    @valid_attrs %{age: 42, breed: "some breed", name: "some name"}
    @update_attrs %{age: 43, breed: "some updated breed", name: "some updated name"}
    @invalid_attrs %{age: nil, breed: nil, name: nil}

    def cat_fixture(attrs \\ %{}) do
      {:ok, cat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pets.create_cat()

      cat
    end

    test "list_cats/0 returns all cats" do
      cat = cat_fixture()
      assert Pets.list_cats() == [cat]
    end

    test "get_cat!/1 returns the cat with given id" do
      cat = cat_fixture()
      assert Pets.get_cat!(cat.id) == cat
    end

    test "create_cat/1 with valid data creates a cat" do
      assert {:ok, %Cat{} = cat} = Pets.create_cat(@valid_attrs)
      assert cat.age == 42
      assert cat.breed == "some breed"
      assert cat.name == "some name"
    end

    test "create_cat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pets.create_cat(@invalid_attrs)
    end

    test "update_cat/2 with valid data updates the cat" do
      cat = cat_fixture()
      assert {:ok, %Cat{} = cat} = Pets.update_cat(cat, @update_attrs)
      assert cat.age == 43
      assert cat.breed == "some updated breed"
      assert cat.name == "some updated name"
    end

    test "update_cat/2 with invalid data returns error changeset" do
      cat = cat_fixture()
      assert {:error, %Ecto.Changeset{}} = Pets.update_cat(cat, @invalid_attrs)
      assert cat == Pets.get_cat!(cat.id)
    end

    test "delete_cat/1 deletes the cat" do
      cat = cat_fixture()
      assert {:ok, %Cat{}} = Pets.delete_cat(cat)
      assert_raise Ecto.NoResultsError, fn -> Pets.get_cat!(cat.id) end
    end

    test "change_cat/1 returns a cat changeset" do
      cat = cat_fixture()
      assert %Ecto.Changeset{} = Pets.change_cat(cat)
    end
  end
end
