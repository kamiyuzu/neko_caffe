defmodule NekoCaffe.Pets.Cat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cats" do
    field :age, :integer
    field :breed, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(cat, attrs) do
    cat
    |> cast(attrs, [:name, :age, :breed])
    |> validate_required([:name, :age, :breed])
  end
end
