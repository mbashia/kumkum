defmodule KumkumWeb.PageController do
  use KumkumWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
