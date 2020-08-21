defmodule IclaszWeb.ClassroomController do
  use IclaszWeb, :controller

  alias Iclasz.{
    Classrooms,
    Schema.Classroom
  }

  def create(conn, _params) do
    case Classrooms.create_classroom(conn.assigns.current_user) do
      {:ok, classroom} ->
        conn
        |> put_flash(:info, "Classroom Created")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Error")
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end

  def show(conn, %{"code" => code}) do
    case Classrooms.get_classroom_by_code(code) do
      %Classroom{} = classroom ->
        render(conn, "show.html", classroom: classroom)

      _nil ->
        conn
        |> put_flash(:info, "classroom not found")
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end
end
