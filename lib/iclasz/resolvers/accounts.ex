defmodule Iclasz.Accounts do
  use Iclasz, :resolver
  alias Iclasz.Schema.User
  alias Pbkdf2
  @doc false
  def registration_changeset(user \\ %User{}, attrs \\ %{}) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :last_name, :email, :password])
    |> validate_length(:password, min: 8, max: 24)
    |> validate_confirmation(:password, message: "does not match")
    |> hash_password()
  end

  defp hash_password(%{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset

  def create_user(params) do
    %User{}
    |> registration_changeset(params)
    |> Repo.insert()
  end

  def get_user_by_id(id) when not is_nil(id), do: Repo.get_by(User, id: id)
  def get_user_by_id(_id), do: nil
end
