defmodule FormWeb.RegistrationController do
  use FormWeb, :controller

  alias Form.Accounts
  alias Form.Accounts.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: "/")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, _params) do
    users = Accounts.list_users()
    render(conn, :show, users: users)
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: "/users")
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = User.changeset_password(user, %{})
    render(conn, :edit, changeset: changeset, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
      user = Accounts.get_user!(id)

      user_param = case user_params["password"] == user_params["confirm_password"] do
        true -> %{"password_hash" => user_params["password"]}
        false ->
          conn
          |> put_flash(:info, "Password doesn't match!")
          |> render(:edit, changeset: User.changeset_password(user, %{}), user: user)
      end

      # Update password
      case Accounts.update_user(user, user_param) do
        {:ok, _user} ->
          conn
          |> put_flash(:info, "Password changed successfully.")
          |> redirect(to: "/users")
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :edit, changeset: changeset, user: user)
      end
  end

end
