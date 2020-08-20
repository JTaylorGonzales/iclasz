defmodule Iclasz.Schema.User do
  use Iclasz, :schema

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :type, :string, default: "instructor"
    timestamps()
  end
end
