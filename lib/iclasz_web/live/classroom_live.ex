defmodule IclaszWeb.ClassroomLive do
  use IclaszWeb, :live_view

  alias Iclasz.{
    Classrooms,
    Questions,
    Accounts
  }

  alias Iclasz.Repo
  alias Iclasz.Schema.Question

  @impl true
  def mount(%{"code" => code}, session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(Iclasz.PubSub, code)
    classroom = Classrooms.get_classroom_by_code(code)
    current_user = Accounts.get_user_by_id(session["user_id"])

    ch =
      Questions.create_changeset(%Question{}, %{
        classroom_id: classroom.id,
        data: %{
          multiple_choice: %{
            description: "",
            choice_a: "",
            choice_b: "",
            choice_c: "",
            choice_d: ""
          }
        }
      })

    questions = Questions.get_all_classroom_questions(classroom.id)

    socket =
      socket
      |> assign(:changeset, ch)
      |> assign(:classroom_code, code)
      |> assign(:questions, questions)
      |> assign(:current_user, current_user)
      |> assign(:current_question, nil)
      |> assign(:correct_answers, 0)

    {:ok, socket}
  end

  def handle_event(
        "save",
        %{"question" => %{"type" => type, "data" => data}} = params,
        socket
      ) do
    classroom = Classrooms.get_classroom_by_code(socket.assigns.classroom_code)

    {:ok, ch} =
      Questions.create_changeset(%Question{}, %{
        classroom_id: classroom.id,
        type: type,
        data: data
      })
      |> Repo.insert()
  end

  def handle_event("broadcast_question", %{"question_id" => question_id}, socket) do
    Phoenix.PubSub.broadcast(
      Iclasz.PubSub,
      socket.assigns.classroom_code,
      {:question_started, Questions.get_question_by_id(question_id)}
    )

    {:noreply, socket}
  end

  def handle_info({:question_started, question}, socket) do
    {:noreply, assign(socket, :current_question, question)}
  end

  def handle_event("answer", %{"answer" => answer}, socket) do
    Phoenix.PubSub.broadcast(
      Iclasz.PubSub,
      socket.assigns.classroom_code,
      {:student_answered, "student_id", answer}
    )

    {:noreply, socket}
  end

  def handle_info({:student_answered, student_id, answer}, socket) do
    socket =
      if socket.assigns.current_question.data.multiple_choice.correct_choice == answer do
        wat = socket.assigns.correct_answers + 1

        assign(socket, :correct_answers, wat)
      else
        socket
      end

    {:noreply, socket}
  end
end
