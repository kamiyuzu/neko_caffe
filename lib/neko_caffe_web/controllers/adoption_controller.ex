defmodule NekoCaffeWeb.AdoptionController do
  use NekoCaffeWeb, :controller

  alias NekoCaffe.Clients.Owner
  alias NekoCaffe.Registry
  alias NekoCaffe.Registry.Adoption
  alias NekoCaffe.Repo

  action_fallback NekoCaffeWeb.FallbackController

  def index(conn, _params) do
    adoptions = Registry.list_adoptions()
    render(conn, "index.json", adoptions: adoptions)
  end

  def create(conn, %{"adoption" => adoption_params}) do
    with {:ok, owner} <- get_owner!(adoption_params["owner_id"]),
         :ok <- owner_has_a_cat?(owner),
         adoption_params <- Map.put(adoption_params, "owners", [owner]),
         {:ok, %Adoption{} = adoption} <- Registry.create_adoption(adoption_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.adoption_path(conn, :show, adoption))
      |> render("show.json", adoption: adoption)
    else
      {:error, "Owner isnt married to a cat yet"} ->
        error_msg =
          "Coudnlt create adoption because owner with id: #{adoption_params["owner_id"]} doesnt have a cute cat yet."

        render_text_error(conn, error_msg)

      {:error, details} ->
        render_text_error(conn, details)
    end
  end

  @spec render_text_error(Plug.Conn.t(), error_details :: String.t()) :: Plug.Conn.t()
  def render_text_error(conn, details) do
    conn
    |> put_status(:bad_request)
    |> text("#{inspect(%{error: details})}")
    |> halt
  end

  @spec get_owner!(integer()) :: {:error, details :: String.t()} | {:ok, %Owner{}}
  def get_owner!(id) do
    case Repo.get(Owner, id) do
      nil -> {:error, "Cant find owner with id: #{id}"}
      owner -> {:ok, owner}
    end
  end

  @spec owner_has_a_cat?(%Owner{}) :: atom()
  defp owner_has_a_cat?(owner) do
    owner = Repo.preload(owner, :cats)

    case owner.cats do
      [] -> {:error, "Owner isnt married to a cat yet"}
      _ -> :ok
    end
  end

  def show(conn, %{"id" => id}) do
    adoption = Registry.get_adoption!(id)
    render(conn, "show.json", adoption: adoption)
  end

  def update(conn, %{"id" => id, "adoption" => adoption_params}) do
    adoption = Registry.get_adoption!(id)

    with {:ok, %Adoption{} = adoption} <- Registry.update_adoption(adoption, adoption_params) do
      render(conn, "show.json", adoption: adoption)
    end
  end

  def delete(conn, %{"id" => id}) do
    adoption = Registry.get_adoption!(id)

    with {:ok, %Adoption{}} <- Registry.delete_adoption(adoption) do
      send_resp(conn, :no_content, "")
    end
  end
end
