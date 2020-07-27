defmodule NekoCaffe.Registry.Adoption do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias NekoCaffe.Clients.Owner

  schema "adoptions" do
    field :worker_name, :string
    field :owner_id, :id

    has_many :owners, Owner

    timestamps()
  end

  @doc false
  def changeset(adoption, attrs) do
    adoption
    |> cast(attrs, [:worker_name, :owner_id])
    |> validate_required([:worker_name, :owner_id])
    |> put_assoc(:owners, attrs["owners"])
  end
end
