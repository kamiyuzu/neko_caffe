defmodule NekoCaffe.Repo.Migrations.AddOwnerIdToCat do
  use Ecto.Migration

  def change do
    alter table(:cats) do
      add :owner_id, references(:owners, on_delete: :nothing)
    end
  end
end
