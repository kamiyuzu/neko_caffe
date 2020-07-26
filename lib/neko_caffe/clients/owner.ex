defmodule NekoCaffe.Clients.Owner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "owners" do
    field :email, :string
    field :name, :string
    field :cat_id, :id

    timestamps()
  end

  @doc false
  def changeset(owner, attrs) do
    owner
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
