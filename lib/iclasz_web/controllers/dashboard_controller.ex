defmodule IclaszWeb.DashboardController do
  use IclaszWeb, :controller
  alias Iclasz.Classrooms

  def index(conn, _params) do
    classrooms = Classrooms.get_all_user_classrooms(conn.assigns.current_user)
    render(conn, "index.html", classrooms: classrooms)
  end
end
