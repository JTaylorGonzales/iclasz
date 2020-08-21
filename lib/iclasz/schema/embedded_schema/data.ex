defmodule Iclasz.EmbeddedSchema.Data do
  use Iclasz, :schema
  alias Iclasz.EmbeddedSchema.MultipleChoice

  embedded_schema do
    embeds_many :multiple_choice, MultipleChoice
  end
end
