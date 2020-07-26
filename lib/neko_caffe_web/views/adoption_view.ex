defmodule NekoCaffeWeb.AdoptionView do
  use NekoCaffeWeb, :view
  alias NekoCaffeWeb.AdoptionView

  def render("index.json", %{adoptions: adoptions}) do
    %{data: render_many(adoptions, AdoptionView, "adoption.json")}
  end

  def render("show.json", %{adoption: adoption}) do
    %{data: render_one(adoption, AdoptionView, "adoption.json")}
  end

  def render("adoption.json", %{adoption: adoption}) do
    %{id: adoption.id,
      worker_name: adoption.worker_name}
  end
end
