defmodule NekoCaffe.Repo.Migrations.AddAdoptionIdToCustomer do
  use Ecto.Migration

  def change do
    alter table(:owners) do
      add :adoption_id, references(:adoptions, on_delete: :nothing)
    end
  end
end
