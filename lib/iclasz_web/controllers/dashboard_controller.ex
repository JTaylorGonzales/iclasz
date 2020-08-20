defmodule IclaszWeb.DashboardController do
  use IclaszWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
