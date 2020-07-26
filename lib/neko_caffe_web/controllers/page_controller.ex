defmodule NekoCaffeWeb.PageController do
  use NekoCaffeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
