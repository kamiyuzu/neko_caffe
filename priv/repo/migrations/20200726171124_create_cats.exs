defmodule NekoCaffe.Repo.Migrations.CreateCats do
  use Ecto.Migration

  def change do
    create table(:cats) do
      add :name, :string
      add :age, :integer
      add :breed, :string

      timestamps()
    end
  end
end
