defmodule NekoCaffe.Registry.Adoption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "adoptions" do
    field :worker_name, :string
    field :owner_id, :id

    timestamps()
  end

  @doc false
  def changeset(adoption, attrs) do
    adoption
    |> cast(attrs, [:worker_name])
    |> validate_required([:worker_name])
  end
end
