defmodule Iclasz.Schema.Question do
  use Iclasz, :schema
  alias Iclasz.Schema.Classroom
  alias Iclasz.EmbeddedSchema.Data

  schema "questions" do
    field :type, :string
    embeds_one :data, Data
    belongs_to :classroom, Classroom
    timestamps()
  end
end
