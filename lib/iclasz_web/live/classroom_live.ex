defmodule IclaszWeb.ClassroomLive do
  use IclaszWeb, :live_view

  alias Iclasz.{
    Classrooms,
    Questions
  }

  alias Iclasz.Repo
  alias Iclasz.Schema.Question

  @impl true
  def mount(%{"code" => code}, _session, socket) do
    classroom = Classrooms.get_classroom_by_code(code)

    {:ok, ch} =
      Questions.create_changeset(%Question{}, %{
        type: "multiple_choice",
        classroom_id: classroom.id,
        data: %{
          multiple_choice: [
            %{
              description: "a",
              choice_a: "wat",
              choice_b: "wat",
              choice_c: "wat",
              choice_d: "wat"
            }
          ]
        }
      })
      |> Repo.insert()

    {:ok, ch} =
      Questions.create_changeset(ch, %{
        type: "multiple_choice",
        classroom_id: classroom.id,
        data: %{
          multiple_choice: [
            %{
              description: "a",
              choice_a: "wat",
              choice_b: "wat",
              choice_c: "wat",
              choice_d: "wat"
            }
          ]
        }
      })
      |> Repo.insert()

    require IEx
    IEx.pry()

    socket =
      socket
      |> assign(:changeset, ch)
      |> assign(:classroom_code, code)

    {:ok, socket}
  end

  def handle_event("save", params, socket) do
    require IEx
    IEx.pry()
  end
end
