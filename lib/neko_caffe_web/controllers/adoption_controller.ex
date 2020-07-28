defmodule NekoCaffeWeb.AdoptionController do
  use NekoCaffeWeb, :controller

  alias NekoCaffe.Actions.AdoptCat
  alias NekoCaffe.Registry
  alias NekoCaffe.Registry.Adoption

  action_fallback NekoCaffeWeb.FallbackController

  def index(conn, _params) do
    adoptions = Registry.list_adoptions()
    render(conn, "index.json", adoptions: adoptions)
  end

  def create(conn, %{"adoption" => adoption_params}) do
    with {:ok, %Adoption{} = adoption} <- AdoptCat.call(adoption_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.adoption_path(conn, :show, adoption))
      |> render("show.json", adoption: adoption)
    else
      {:error, "Owner isnt married to a cat yet"} ->
        error_msg =
          ~s(Coudnlt create adoption because owner with id: #{adoption_params["owner_id"]} doesnt have a cute cat yet.)

        render_text_error(conn, error_msg)

      {:error, details} ->
        render_text_error(conn, details)
    end
  end

  @spec render_text_error(Plug.Conn.t(), error_details :: String.t()) :: Plug.Conn.t()
  defp render_text_error(conn, details) do
    conn
    |> put_status(:bad_request)
    |> text("#{inspect(%{error: details})}")
    |> halt
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
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
