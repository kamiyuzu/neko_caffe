defmodule NekoCaffeWeb.AdoptionController do
  use NekoCaffeWeb, :controller

  alias NekoCaffe.Registry
  alias NekoCaffe.Registry.Adoption

  action_fallback NekoCaffeWeb.FallbackController

  def index(conn, _params) do
    adoptions = Registry.list_adoptions()
    render(conn, "index.json", adoptions: adoptions)
  end

  def create(conn, %{"adoption" => adoption_params}) do
    with {:ok, %Adoption{} = adoption} <- Registry.create_adoption(adoption_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.adoption_path(conn, :show, adoption))
      |> render("show.json", adoption: adoption)
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
