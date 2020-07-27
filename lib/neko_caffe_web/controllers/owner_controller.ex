defmodule NekoCaffeWeb.OwnerController do
  use NekoCaffeWeb, :controller

  alias NekoCaffe.Clients
  alias NekoCaffe.Clients.Owner
  alias NekoCaffe.Pets

  action_fallback NekoCaffeWeb.FallbackController

  def index(conn, _params) do
    owners = Clients.list_owners()
    render(conn, "index.json", owners: owners)
  end

  def create(conn, %{"owner" => owner_params}) do
    cat = Pets.get_cat!(owner_params["cat_id"])
    owner_params = Map.put(owner_params, "cats", [cat])

    with {:ok, %Owner{} = owner} <- Clients.create_owner(owner_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.owner_path(conn, :show, owner))
      |> render("show.json", owner: owner)
    end
  end

  def show(conn, %{"id" => id}) do
    owner = Clients.get_owner!(id)
    render(conn, "show.json", owner: owner)
  end

  def update(conn, %{"id" => id, "owner" => owner_params}) do
    owner = Clients.get_owner!(id)

    with {:ok, %Owner{} = owner} <- Clients.update_owner(owner, owner_params) do
      render(conn, "show.json", owner: owner)
    end
  end

  def delete(conn, %{"id" => id}) do
    owner = Clients.get_owner!(id)

    with {:ok, %Owner{}} <- Clients.delete_owner(owner) do
      send_resp(conn, :no_content, "")
    end
  end
end
