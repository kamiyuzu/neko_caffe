defmodule NekoCaffe.Registry do
  @moduledoc """
  The Registry context.
  """

  import Ecto.Query, warn: false
  alias NekoCaffe.Repo

  alias NekoCaffe.Registry.Adoption

  @doc """
  Returns the list of adoptions.

  ## Examples

      iex> list_adoptions()
      [%Adoption{}, ...]

  """
  def list_adoptions do
    Repo.all(Adoption)
  end

  @doc """
  Gets a single adoption.

  Raises `Ecto.NoResultsError` if the Adoption does not exist.

  ## Examples

      iex> get_adoption!(123)
      %Adoption{}

      iex> get_adoption!(456)
      ** (Ecto.NoResultsError)

  """
  def get_adoption!(id), do: Repo.get!(Adoption, id)

  @doc """
  Creates a adoption.

  ## Examples

      iex> create_adoption(%{field: value})
      {:ok, %Adoption{}}

      iex> create_adoption(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_adoption(attrs \\ %{}) do
    %Adoption{}
    |> Adoption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a adoption.

  ## Examples

      iex> update_adoption(adoption, %{field: new_value})
      {:ok, %Adoption{}}

      iex> update_adoption(adoption, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_adoption(%Adoption{} = adoption, attrs) do
    adoption
    |> Adoption.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a adoption.

  ## Examples

      iex> delete_adoption(adoption)
      {:ok, %Adoption{}}

      iex> delete_adoption(adoption)
      {:error, %Ecto.Changeset{}}

  """
  def delete_adoption(%Adoption{} = adoption) do
    Repo.delete(adoption)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking adoption changes.

  ## Examples

      iex> change_adoption(adoption)
      %Ecto.Changeset{data: %Adoption{}}

  """
  def change_adoption(%Adoption{} = adoption, attrs \\ %{}) do
    Adoption.changeset(adoption, attrs)
  end
end
