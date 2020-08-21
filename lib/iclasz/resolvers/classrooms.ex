defmodule Iclasz.Classrooms do
  use Iclasz, :resolver

  alias Iclasz.Schema.{
    Classroom,
    User
  }

  alias Pbkdf2
  @doc false
  def create_changeset(classroom \\ %Classroom{}, attrs \\ %{}) do
    classroom
    |> cast(attrs, [:user_id])
    |> generate_classroom_code()
  end

  defp generate_classroom_code(%{valid?: true} = changeset) do
    code = :crypto.strong_rand_bytes(5) |> Base.url_encode64() |> binary_part(0, 5)
    put_change(changeset, :code, code)
  end

  def create_classroom(%User{} = user) do
    %Classroom{}
    |> create_changeset(%{user_id: user.id})
    |> Repo.insert()
  end

  def get_all_user_classrooms(%User{} = user) do
    from(c in Classroom, where: c.user_id == ^user.id) |> Repo.all()
  end

  def get_classroom_by_code(code), do: Repo.get_by(Classroom, code: code)
end
