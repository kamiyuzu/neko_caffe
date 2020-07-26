defmodule NekoCaffe.Repo.Migrations.CreateOwners do
  use Ecto.Migration

  def change do
    create table(:owners) do
      add :name, :string
      add :email, :string
      add :cat_id, references(:cats, on_delete: :nothing)

      timestamps()
    end

    create index(:owners, [:cat_id])
  end
end
