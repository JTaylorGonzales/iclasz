defmodule Iclasz.EmbeddedSchema.MultipleChoice do
  use Iclasz, :schema

  embedded_schema do
    field :description, :string
    field :choice_a, :string
    field :choice_b, :string
    field :choice_c, :string
    field :choice_d, :string
    field :correct_choice, :string
  end
end
