defmodule NekoCaffe.Pets.Cat do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias NekoCaffe.Clients.Owner

  schema "cats" do
    field :age, :integer
    field :breed, :string
    field :name, :string

    belongs_to :owner, Owner

    timestamps()
  end

  @doc false
  def changeset(cat, attrs) do
    cat
    |> cast(attrs, [:name, :age, :breed])
    |> validate_required([:name, :age, :breed])
  end
end
