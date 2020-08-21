defmodule Iclasz.Questions do
  use Iclasz, :resolver

  alias Iclasz.Schema.{
    Classroom,
    User,
    Question
  }

  alias Iclasz.EmbeddedSchema.{
    Data,
    MultipleChoice
  }

  @multiple_choice_attrs [:description, :choice_a, :choice_b, :choice_c, :choice_d]
  alias Pbkdf2
  @doc false
  def create_changeset(question \\ %Question{}, attrs \\ %{}) do
    question
    |> cast(attrs, [:type, :classroom_id])
    |> cast_embed(:data, with: &data_changeset/2)
  end

  defp data_changeset(data, attrs) do
    data
    |> cast(attrs, [])
    |> cast_embed(:multiple_choice, with: &multiple_choice_changeset/2)
  end

  defp multiple_choice_changeset(data, attrs) do
    data
    |> cast(attrs, @multiple_choice_attrs)
    |> validate_required(@multiple_choice_attrs)
  end
end
