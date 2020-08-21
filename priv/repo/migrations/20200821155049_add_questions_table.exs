defmodule Iclasz.Repo.Migrations.AddQuestionsTable do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:type, :string)
      add(:data, :jsonb)
      add(:classroom_id, references(:classrooms, type: :uuid))
      timestamps()
    end
  end
end
