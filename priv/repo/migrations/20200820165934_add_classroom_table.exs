defmodule Iclasz.Repo.Migrations.AddClassroomTable do
  use Ecto.Migration

  def change do
    create table(:classrooms, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string
      add :name, :string
      add :description, :text
      add :user_id, references(:users, type: :uuid)

      timestamps()
    end
  end
end
