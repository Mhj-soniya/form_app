defmodule Form.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> validate_length(:password_hash, min: 7)
    |> unique_constraint(:email)
  end

  def changeset_password(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:password_hash])
    |> validate_required([:password_hash])
    |> validate_length(:password_hash, min: 7, message: "Password length does not match")
    |> validate_confirmation(:password_hash, message: "Passwords do not match")
  end
end
