defmodule NekoCaffeWeb.OwnerView do
  use NekoCaffeWeb, :view
  alias NekoCaffeWeb.OwnerView

  def render("index.json", %{owners: owners}) do
    %{data: render_many(owners, OwnerView, "owner.json")}
  end

  def render("show.json", %{owner: owner}) do
    %{data: render_one(owner, OwnerView, "owner.json")}
  end

  def render("owner.json", %{owner: owner}) do
    %{id: owner.id,
      name: owner.name,
      email: owner.email}
  end
end
