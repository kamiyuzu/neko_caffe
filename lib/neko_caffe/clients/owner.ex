defmodule NekoCaffe.Clients.Owner do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias NekoCaffe.Pets.Cat
  alias NekoCaffe.Registry.Adoption

  schema "owners" do
    field :email, :string
    field :name, :string
    field :cat_id, :integer

    has_many :cats, Cat
    belongs_to :adoption, Adoption

    timestamps()
  end

  @doc false
  def changeset(owner, attrs) do
    owner
    |> cast(attrs, [:name, :email, :cat_id])
    |> validate_required([:name, :email, :cat_id])
    |> put_assoc(:cats, attrs["cats"])
  end
end
