defmodule Iclasz.Classrooms do
  use Iclasz, :resolver
  alias Iclasz.Schema.Classroom
  alias Pbkdf2
  @doc false
  def create_changeset(classroom \\ %Classroom{}, attrs \\ %{}) do
    classroom
    |> cast(attrs, [:user])
    |> generate_classroom_code()
  end

  defp generate_classroom_code(%{valid?: true} = changeset) do
    code = :crypto.strong_rand_bytes(5)
    put_change(changeset, :code, code)
  end
end
