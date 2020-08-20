defmodule Iclasz.Schema.Classroom do
  use Iclasz, :schema
  alias Iclasz.Schema.User

  schema "classrooms" do
    field :code, :string
    field :name, :string
    field :description, :string
    belongs_to :teacher, User
    timestamps()
  end
end
