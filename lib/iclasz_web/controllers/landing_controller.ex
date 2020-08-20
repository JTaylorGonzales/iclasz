defmodule IclaszWeb.LandingController do
  use IclaszWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
