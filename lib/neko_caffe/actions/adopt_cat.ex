defmodule NekoCaffe.Actions.AdoptCat do

  alias NekoCaffe.Repo
  alias NekoCaffe.Clients.Owner
  alias NekoCaffe.Registry
  alias NekoCaffe.Registry.Adoption

  @typep worker_name_key :: String.t()
  @typep owner_id_key :: String.t()
  @typep adoption_params :: %{required(worker_name_key) => String.t(), required(owner_id_key) => integer()}
  @spec call(adoption_params, []) :: {:ok, %Adoption{}} | {:error, details :: String.t()}
  def call(adoption_params, _opts \\ []) do
    with {:ok, owner} <- get_owner!(adoption_params["owner_id"]),
    :ok <- owner_has_a_cat?(owner),
    adoption_params <- Map.put(adoption_params, "owners", [owner]),
    {:ok, %Adoption{} = adoption} <- Registry.create_adoption(adoption_params) do
      {:ok, adoption}
    end
  end

  @spec get_owner!(integer()) :: {:ok, %Owner{}} | {:error, details :: String.t()}
  defp get_owner!(id) do
    case Repo.get(Owner, id) do
      nil -> {:error, "Cant find owner with id: #{id}"}
      owner -> {:ok, owner}
    end
  end

  @spec owner_has_a_cat?(%Owner{}) :: :ok | {:error, error_details :: String.t()}
  defp owner_has_a_cat?(owner) do
    owner = Repo.preload(owner, :cats)

    case owner.cats do
      [] -> {:error, "Owner isnt married to a cat yet"}
      _ -> :ok
    end
  end
end
