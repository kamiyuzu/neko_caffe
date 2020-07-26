defmodule NekoCaffe.Repo.Migrations.CreateAdoptions do
  use Ecto.Migration

  def change do
    create table(:adoptions) do
      add :worker_name, :string
      add :owner_id, references(:owners, on_delete: :nothing)

      timestamps()
    end

    create index(:adoptions, [:owner_id])
  end
end
